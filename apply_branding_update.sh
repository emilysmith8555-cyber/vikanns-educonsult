#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

mkdir -p images

echo "==> Copying images from Downloads..."
cp ~/storage/downloads/'vikanns-logo (1).png' images/logo.png
cp ~/storage/downloads/'vikanns-team-green (1).jpg' images/team-green.jpg
cp ~/storage/downloads/'vikanns-team-white (1).jpg' images/team-white.jpg
echo "Images copied:"
ls -la images/

# ---------------------------------------------------------------------------
# 1. Logo: replace the graduation-cap emoji with the real logo image
# ---------------------------------------------------------------------------
sed -i 's|<div class="logo">🎓 Vikanns Educonsult</div>|<div class="logo"><img src="images/logo.png" alt="Vikanns Ltd logo" class="logo-img"></div>|' index.html

cat >> style.css << 'EOF'

/* ---------------- Logo image ---------------- */
.logo-img {
  height: 42px;
  width: auto;
  display: block;
}
EOF

# ---------------------------------------------------------------------------
# 2. Hero slideshow: swap placeholder photos for the real team photos
# ---------------------------------------------------------------------------
python3 - << 'PYEOF' 2>/dev/null || true
PYEOF

sed -i '/hero-slideshow/,/<\/div>/{
  /class="slide/d
}' index.html

# Re-insert the hero-slideshow block cleanly with the 2 real photos
sed -i 's|<div class="hero-slideshow">|<div class="hero-slideshow">\n    <div class="slide active" style="background-image:url('"'"'images/team-green.jpg'"'"')"></div>\n    <div class="slide" style="background-image:url('"'"'images/team-white.jpg'"'"')"></div>|' index.html

# ---------------------------------------------------------------------------
# 3. Facebook link
# ---------------------------------------------------------------------------
sed -i 's|https://facebook.com/VikannsEduconsult|https://www.facebook.com/share/1EomntQ24U/?mibextid=wwXIfr|' index.html

# ---------------------------------------------------------------------------
# 4. Company name: "Vikanns Educonsult" -> "Vikanns Ltd" everywhere in the page
# ---------------------------------------------------------------------------
sed -i 's|Vikanns Educonsult Ltd|Vikanns Ltd|g; s|Vikanns Educonsult|Vikanns Ltd|g' index.html

# ---------------------------------------------------------------------------
# 5. "Who We Are" section: replace with the new copy
# ---------------------------------------------------------------------------
awk '
  /<section id="about" class="about reveal">/ { print; print "  <h2>Who We Are</h2>"; skip=1; next }
  skip && /<\/section>/ { print "  <p>Vikanns Ltd is a forward-thinking Nigerian company focused on creating opportunities, connecting people to possibilities, and delivering solutions that create lasting value. From our roots in education and study-abroad services, we continue to expand into diverse sectors, partnerships, and ventures both locally and internationally.</p>"; print "  <p>We believe in the power of People, Ideas and Possibilities to build a better future.</p>"; print; skip=0; next }
  skip { next }
  { print }
' index.html > index_new.html && mv index_new.html index.html

echo "--- Verifying key changes ---"
grep -n "logo-img\|team-green\|team-white\|share/1EomntQ24U\|Vikanns Ltd\|forward-thinking" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Real logo, team photos, updated branding and About text"
git push

echo ""
echo "Done. Live in a minute or two."

