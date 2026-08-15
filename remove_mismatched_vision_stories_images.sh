#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i '/<div class="vision-float"><img src="images\/team-white.jpg"/d' index.html
sed -i '/<div class="stories-zoom"><img src="images\/hero-team-lineup.jpg"/d' index.html

echo "--- Verifying (should show nothing) ---"
grep -n "vision-float\|stories-zoom" index.html || echo "Confirmed: both removed from the page."

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Remove mismatched placeholder images from Vision and Student Stories, keep Services and How It Works"
git push

echo "Done. Live in a minute or two."

