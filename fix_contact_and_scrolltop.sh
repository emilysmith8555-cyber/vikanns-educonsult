#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Make email optional (remove required, note it in the placeholder)
sed -i 's|<input type="email" name="email" placeholder="Email Address" required>|<input type="email" name="email" placeholder="Email Address (optional)">|' index.html

# 2. Add Partnership WhatsApp block to Contact, right after the phone numbers
awk '
  /<a href="tel:\+2348163848822">/ {
    print
    getline
    print
    print "  <div class=\"partner-cta\">"
    print "    <h3>Represent an Institution or Business?</h3>"
    print "    <p>We welcome partnerships with institutions, organisations and businesses to create meaningful opportunities together.</p>"
    print "    <a href=\"https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20am%20interested%20in%20discussing%20a%20partnership.\" target=\"_blank\" rel=\"noopener\" class=\"btn-outline\">Partner With Vikanns</a>"
    print "  </div>"
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 3. Position the scroll-to-top button directly above the WhatsApp button
cat >> style.css << 'EOF'

/* ---------------- Scroll-to-top button, aligned with WhatsApp float ---------------- */
.scroll-top-btn {
  position: fixed;
  bottom: 94px;
  right: 24px;
  z-index: 199;
}
EOF

echo "--- Verifying ---"
grep -n "Email Address (optional)\|Represent an Institution\|discussing a partnership" index.html
grep -A3 "scroll-top-btn {" style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Make email optional, add Partnership WhatsApp link to Contact, align scroll-top button with WhatsApp float"
git push

echo "Done. Live in a minute or two."

