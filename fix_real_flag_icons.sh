#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Load the flag-icons library via CDN
if ! grep -q "flag-icons" index.html; then
  sed -i 's|<link rel="stylesheet" href="style.css">|<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css">\n<link rel="stylesheet" href="style.css">|' index.html
fi

# 2. Remove the old color-bar spans (no longer used)
sed -i '/<span class="flag-bar /d' index.html

# 3. Put a real flag icon directly beside each country name
awk '
  /<h3>United Kingdom<\/h3>/ { print "      <h3><span class=\"fi fi-gb flag-icon\"></span> United Kingdom</h3>"; next }
  /<h3>Canada<\/h3>/ { print "      <h3><span class=\"fi fi-ca flag-icon\"></span> Canada</h3>"; next }
  /<h3>Netherlands<\/h3>/ { print "      <h3><span class=\"fi fi-nl flag-icon\"></span> Netherlands</h3>"; next }
  /<h3>Europe &amp; Beyond<\/h3>/ { print "      <h3><span class=\"fi fi-eu flag-icon\"></span> Europe &amp; Beyond</h3>"; next }
  /<h3>New Zealand<\/h3>/ { print "      <h3><span class=\"fi fi-nz flag-icon\"></span> New Zealand</h3>"; next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 4. Remove old flag-bar CSS, add proper sizing for the real flag icons
sed -i '/^\/\* ---------------- Destination flag-color bars/,/^\.flag-nz {.*}$/d' style.css

cat >> style.css << 'EOF'

/* ---------------- Real flag icons beside country names ---------------- */
.destination-card h3 {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}
.flag-icon {
  width: 42px;
  height: 30px;
  border-radius: 4px;
  box-shadow: 0 1px 4px rgba(0,0,0,0.25);
  background-size: cover;
}
EOF

echo "--- Verifying ---"
grep -n "flag-icons\|fi fi-\|flag-icon\b" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Replace color bars with real flag icons beside each country name"
git push

echo "Done. Live in a minute or two."

