#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<link rel="icon" type="image/png" href="images/logo.png">|<meta name="google-site-verification" content="rbU5IRCKcbdlBPZKkVEI2NWpjaaZ95d7O-pYLXcT88g" />\n<link rel="icon" type="image/png" href="images/logo.png">|' index.html

echo "--- Verifying ---"
grep -n "google-site-verification" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add Google Search Console verification tag"
git push

echo "Done. Live in a minute or two."

