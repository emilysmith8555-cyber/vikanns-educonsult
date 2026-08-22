#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i '10s|.*|<meta property="og:title" content="Vikanns Ltd \| Education, Opportunities \&amp; Global Pathways">|' index.html
sed -i '11s|.*|<meta property="og:description" content="Explore study abroad, admissions, funding, visa guidance and academic opportunities with Vikanns.">|' index.html

echo "--- Verifying ---"
sed -n '10,11p' index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Update homepage default social sharing text per Section 20 of upgrade brief"
git push

echo "Done. Live in a minute or two."

