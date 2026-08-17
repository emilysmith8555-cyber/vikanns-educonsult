#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<a href="#services">Partnerships</a>|<a href="#contact">Partnerships</a>|' index.html

echo "--- Verifying ---"
grep -n "Partnerships" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix Partnerships footer link to point to Contact section, not old Services location"
git push

echo "Done. Live in a minute or two."

