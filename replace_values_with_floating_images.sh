#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Copying value images from Downloads..."
cp ~/storage/downloads/value-people.jpg images/value-people.jpg
cp ~/storage/downloads/value-integrity.jpg images/value-integrity.jpg
cp ~/storage/downloads/value-excellence.jpg images/value-excellence.jpg
cp ~/storage/downloads/value-innovation.jpg images/value-innovation.jpg
cp ~/storage/downloads/value-impact.jpg images/value-impact.jpg
echo "Images copied:"
ls -la images/value-*.jpg

# ---------------------------------------------------------------------------
# Replace the text-based Values grid with a floating (crossfading) image slideshow
# ---------------------------------------------------------------------------
awk '
  /<section id="values" class="values reveal">/ {
    print "<section id=\"values\" class=\"values reveal\">"
    print "  <h2>Our Values</h2>"
    print "  <div class=\"values-slideshow\">"
    print "    <div class=\"v-slide active\" style=\"background-image:url('"'"'images/value-people.jpg'"'"')\"></div>"
    print "    <div class=\"v-slide\" style=\"background-image:url('"'"'images/value-integrity.jpg'"'"')\"></div>"
    print "    <div class=\"v-slide\" style=\"background-image:url('"'"'images/value-excellence.jpg'"'"')\"></div>"
    print "    <div class=\"v-slide\" style=\"background-image:url('"'"'images/value-innovation.jpg'"'"')\"></div>"
    print "    <div class=\"v-slide\" style=\"background-image:url('"'"'images/value-impact.jpg'"'"')\"></div>"
    print "  </div>"
    print "</section>"
    skip=1
    next
  }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Our Values floating image slideshow ---------------- */
.values-slideshow {
  position: relative;
  width: 100%;
  max-width: 460px;
  height: 440px;
  margin: 30px auto 0;
  border-radius: 18px;
  overflow: hidden;
  box-shadow: 0 10px 28px rgba(0,0,0,0.18);
}
.v-slide {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  transition: opacity 1.8s ease-in-out;
}
.v-slide.active { opacity: 1; }
EOF

cat >> script.js << 'EOF'

// Our Values floating image slideshow
(function () {
  const vSlides = document.querySelectorAll('.values-slideshow .v-slide');
  let vCurrent = 0;
  if (vSlides.length > 1) {
    setInterval(() => {
      vSlides[vCurrent].classList.remove('active');
      vCurrent = (vCurrent + 1) % vSlides.length;
      vSlides[vCurrent].classList.add('active');
    }, 3200);
  }
})();
EOF

echo "--- Verifying ---"
grep -n "values-slideshow\|v-slide\|value-people\|value-integrity\|value-excellence\|value-innovation\|value-impact" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Replace text-based Values section with floating image slideshow"
git push

echo "Done. Live in a minute or two."

