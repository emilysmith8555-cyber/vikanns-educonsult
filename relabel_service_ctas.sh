#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i '193s|<a href="#contact" class="btn-outline">Explore Study Options</a>|<a href="#contact" class="btn-outline">Find My Programme</a>|' index.html
sed -i '227s|<a href="#contact" class="btn-outline">Explore Funding Options</a>|<a href="#contact" class="btn-outline">Explore Funding</a>|' index.html

echo "--- Verifying ---"
sed -n '193p;227p' index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Relabel service CTAs per upgrade brief (Section 7)"
git push

echo "Done. Live in a minute or two."

