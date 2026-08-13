#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<div class="logo"><img src="images/logo.png" alt="Vikanns Ltd logo" class="logo-img"></div>|<div class="logo"><img src="images/logo.png" alt="Vikanns Ltd logo" class="logo-img"><span class="logo-text">Vikanns Ltd</span></div>|' index.html

cat >> style.css << 'EOF'

/* ---------------- Logo text beside the image ---------------- */
.logo {
  display: flex;
  align-items: center;
  gap: 10px;
}
.logo-text {
  font-weight: 800;
  font-size: 1.15rem;
  color: var(--green-dark);
}
EOF

echo "--- Verifying ---"
grep -n "logo-text\|logo-img" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add bold name beside the logo"
git push

echo "Done. Live in a minute or two."

