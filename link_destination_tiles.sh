#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<a href="#contact" class="dest-tile"><span class="fi fi-gb flag-icon-lg">|<a href="uk.html" class="dest-tile"><span class="fi fi-gb flag-icon-lg">|' index.html
sed -i 's|<a href="#contact" class="dest-tile"><span class="fi fi-ca flag-icon-lg">|<a href="canada.html" class="dest-tile"><span class="fi fi-ca flag-icon-lg">|' index.html
sed -i 's|<a href="#contact" class="dest-tile"><span class="fi fi-nl flag-icon-lg">|<a href="netherlands.html" class="dest-tile"><span class="fi fi-nl flag-icon-lg">|' index.html
sed -i 's|<a href="#contact" class="dest-tile"><span class="fi fi-nz flag-icon-lg">|<a href="new-zealand.html" class="dest-tile"><span class="fi fi-nz flag-icon-lg">|' index.html
sed -i 's|<a href="#contact" class="dest-tile"><span class="fi fi-eu flag-icon-lg">|<a href="europe.html" class="dest-tile"><span class="fi fi-eu flag-icon-lg">|' index.html

echo "--- Verifying ---"
grep -n "dest-tile" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Link destination tiles to their dedicated pages"
git push

echo "Done. Live in a minute or two."

