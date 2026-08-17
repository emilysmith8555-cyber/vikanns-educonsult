#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# Remove the previous mismatched logo image + its CSS
sed -i '/<img src="images\/logo.png" alt="Vikanns Ltd logo" class="footer-logo">/d' index.html

# Replace the "Vikanns Ltd" heading text with the logo image itself (same sizing as nav)
awk '
  /<h3>Vikanns Ltd<\/h3>/ && !done {
    print "      <img src=\"images/logo.png\" alt=\"Vikanns Ltd logo\" class=\"footer-logo-img\">"
    done=1
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# Remove old footer-logo CSS block, add correct sizing matching the nav logo
sed -i '/\/\* ---------------- Footer logo ---------------- \*\//,/^}/d' style.css

cat >> style.css << 'EOF'

/* ---------------- Footer logo (matches nav sizing) ---------------- */
.footer-logo-img {
  height: 42px;
  width: auto;
  display: block;
  margin-bottom: 10px;
  border-radius: 6px;
}
EOF

echo "--- Verifying ---"
grep -n "footer-logo" index.html style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix footer logo: replace text with logo image, sized like nav"
git push

echo "Done. Live in a minute or two."

