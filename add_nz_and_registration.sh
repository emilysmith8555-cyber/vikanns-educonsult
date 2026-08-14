#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Add New Zealand as a 5th destination card
# ---------------------------------------------------------------------------
sed -i 's|<div class="destination-card">\n      <h3>Europe|XXXPLACEHOLDERXXX|' index.html 2>/dev/null || true

awk '
  /<div class="destination-card">/ { print; count++; if (count==4) {
    # after printing the 4th card opening, we still need its full content — handled by normal pass-through
  } }
  { print_line = 1 }
  { print }
' index.html > /tmp/nz_pass1.html 2>/dev/null || cp index.html /tmp/nz_pass1.html

# Simpler, reliable approach: insert the New Zealand card right before the closing </div> of destination-grid
awk '
  /<div class="destination-grid">/ { in_grid=1 }
  in_grid && /<\/div>$/ && !inserted {
    print "    <div class=\"destination-card\">"
    print "      <span class=\"flag-bar flag-nz\"></span>"
    print "      <h3>New Zealand</h3>"
    print "      <p>Discover welcoming universities and institutes known for research, innovation and quality of life.</p>"
    print "      <a href=\"#contact\" class=\"btn-outline\">Explore New Zealand Options</a>"
    print "    </div>"
    print
    inserted=1
    in_grid=0
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# Add flag-bar accent to the existing 4 destination cards too, using each country's real flag colors
sed -i 's|<div class="destination-card">\n      <h3>United Kingdom</h3>|<div class="destination-card">\n      <span class="flag-bar flag-uk"></span>\n      <h3>United Kingdom</h3>|' index.html
perl -0pi -e 's/<div class="destination-card">\s*\n\s*<h3>United Kingdom<\/h3>/<div class="destination-card">\n      <span class="flag-bar flag-uk"><\/span>\n      <h3>United Kingdom<\/h3>/' index.html 2>/dev/null || true

# Termux-safe (no perl/python multi-line) approach: use awk for each card individually
awk '
  /<h3>United Kingdom<\/h3>/ && !u { print "      <span class=\"flag-bar flag-uk\"></span>"; u=1 }
  /<h3>Canada<\/h3>/ && !c { print "      <span class=\"flag-bar flag-ca\"></span>"; c=1 }
  /<h3>Netherlands<\/h3>/ && !n { print "      <span class=\"flag-bar flag-nl\"></span>"; n=1 }
  /<h3>Europe &amp; Beyond<\/h3>/ && !e { print "      <span class=\"flag-bar flag-eu\"></span>"; e=1 }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# ---------------------------------------------------------------------------
# 2. Registration link — placed in the hero (top, first thing seen) and the
#    final CTA (bottom, last thing seen) for maximum visibility
# ---------------------------------------------------------------------------
REG_URL='https://app.coursefinder.ai/student-platform/471d93c9/sign-up?fbclid=IwRlRTSATrw59wZG9mAWZkaWQWUMdmhclQ7GO9vM-ND-LG_0B2MfiGwmV4dG4DYWVtAjEwAHNydGMGYXBwX2lkCjY2Mjg1NjgzNzkAAR4h8rkDlUflobKek0WVAVY5FFrAP6qHoqMx7nfuUKllVlG0pQ3Ny8dTJ0-eRQ_aem_fXly7G1NQUR6cUaHfCYm7w'

sed -i "s|<a href=\"#services\" class=\"btn-outline\">Explore Our Services</a>|<a href=\"#services\" class=\"btn-outline\">Explore Our Services</a>\n      <a href=\"${REG_URL}\" target=\"_blank\" rel=\"noopener\" class=\"btn-register\">Register Now</a>|" index.html

sed -i "s|<a href=\"https://wa.me/2347032751486\" target=\"_blank\" rel=\"noopener\" class=\"btn-outline-light\">Talk to Vikanns</a>|<a href=\"https://wa.me/2347032751486\" target=\"_blank\" rel=\"noopener\" class=\"btn-outline-light\">Talk to Vikanns</a>\n    <a href=\"${REG_URL}\" target=\"_blank\" rel=\"noopener\" class=\"btn-register\">Register Now</a>|" index.html

# ---------------------------------------------------------------------------
# 3. Styling: flag-color bars + a distinct, eye-catching Register button
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Destination flag-color bars ---------------- */
.flag-bar { display: block; height: 8px; border-radius: 6px; margin: -26px -26px 18px; }
.flag-uk { background: linear-gradient(90deg, #012169 33%, #ffffff 33% 66%, #C8102E 66%); }
.flag-ca { background: linear-gradient(90deg, #FF0000 33%, #ffffff 33% 66%, #FF0000 66%); }
.flag-nl { background: linear-gradient(180deg, #AE1C28 33%, #ffffff 33% 66%, #21468B 66%); }
.flag-eu { background: linear-gradient(90deg, #003399, #FFCC00); }
.flag-nz { background: linear-gradient(90deg, #00247D 33%, #CC142B 33% 66%, #ffffff 66%); }

/* ---------------- Register Now button (distinct, eye-catching) ---------------- */
.btn-register {
  display: inline-block;
  background: #FFCC00;
  color: #1a1a1a;
  font-weight: 800;
  padding: 13px 28px;
  border-radius: 30px;
  transition: transform 0.2s, background 0.2s;
}
.btn-register:hover { transform: translateY(-2px); background: #ffdb4d; }
EOF

echo "--- Verifying ---"
grep -n "New Zealand\|flag-bar\|btn-register" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add New Zealand destination, country flag-color accents, registration link in hero and final CTA"
git push

echo "Done. Live in a minute or two."

