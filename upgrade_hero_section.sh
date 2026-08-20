#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

python3 --version >/dev/null 2>&1 || true

awk '
  /<section id="home" class="hero">/ { in_hero=1 }
  in_hero && /<div class="hero-content">/ {
    print
    print "    <p class=\"eyebrow\">PEOPLE. IDEAS. POSSIBILITIES.</p>"
    print "    <h1>Study Abroad With a Clearer Plan</h1>"
    print "    <p>Find the right course, university, destination and funding pathway with personalised guidance from Vikanns.</p>"
    print "    <div class=\"hero-buttons\">"
    print "      <a href=\"#contact\" class=\"btn-primary\">Check My Eligibility</a>"
    print "      <a href=\"https://wa.me/2347032751486\" target=\"_blank\" rel=\"noopener\" class=\"btn-outline\">Talk to an Adviser</a>"
    print "      <a href=\"#services\" class=\"btn-outline\">Explore Study Options</a>"
    print "    </div>"
    print "    <p class=\"hero-trust\">Personalised guidance &bull; Transparent process &bull; Student-first support</p>"
    skip_old=1
    next
  }
  in_hero && skip_old && /<\/section>/ { in_hero=0; skip_old=0; print; next }
  in_hero && skip_old { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Hero trust line ---------------- */
.hero-trust {
  font-size: 0.85rem;
  opacity: 0.9;
  margin-top: 4px;
  letter-spacing: 0.3px;
}
EOF

echo "--- Verifying ---"
grep -n "Study Abroad With a Clearer Plan\|Check My Eligibility\|Talk to an Adviser\|Explore Study Options\|hero-trust" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Upgrade hero section per new conversion-focused brief"
git push

echo "Done. Live in a minute or two."

