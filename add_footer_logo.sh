#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<div class="footer-col">\n      <h3>Vikanns Ltd</h3>|<div class="footer-col">\n      <img src="images/logo.png" alt="Vikanns Ltd logo" class="footer-logo">\n      <h3>Vikanns Ltd</h3>|' index.html
# sed above will not match across lines; use awk instead for reliability
awk '
  /<h3>Vikanns Ltd<\/h3>/ && !done {
    print "      <img src=\"images/logo.png\" alt=\"Vikanns Ltd logo\" class=\"footer-logo\">"
    print
    done=1
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Footer logo ---------------- */
.footer-logo {
  height: 46px;
  width: auto;
  margin-bottom: 10px;
  filter: brightness(0) invert(1);
}
EOF

echo "--- Verifying ---"
grep -n "footer-logo" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add logo to footer"
git push

echo "Done. Live in a minute or two."

