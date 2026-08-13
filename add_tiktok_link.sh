#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<a href="https://instagram.com/vikannseduconsult" target="_blank" rel="noopener">📸 Instagram</a>|<a href="https://instagram.com/vikannseduconsult" target="_blank" rel="noopener">📸 Instagram</a>\n    <a href="https://www.tiktok.com/@vikanns.educonsul?_r=1\&_t=ZS-98rJl8ROFEn" target="_blank" rel="noopener">🎵 TikTok</a>|' index.html

echo "--- Verifying ---"
grep -n "tiktok\|Instagram" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add TikTok link to contact section"
git push

echo "Done. Live in a minute or two."

