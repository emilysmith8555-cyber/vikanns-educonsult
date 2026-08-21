#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Remove the broken/duplicated address paragraph from Contact
sed -i '/<p class="address"><a href="https:\/\/www.google.com\/maps\/search/d' index.html

# 2. Remove the "Represent an Institution" partnership block
sed -i '/<div class="partner-cta">/,/<\/div>/d' index.html

# 3. Remove the whole newsletter section
awk '
  /<section id="newsletter" class="newsletter reveal">/ { skip=1 }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 4. Remove the two "Swipe to see all" hint lines
sed -i '/<p class="swipe-hint">Swipe to see all/d' index.html

echo "--- Verifying (should show nothing for all of these) ---"
grep -n "Represent an Institution\|Get Intake Update\|Swipe to see all\|maps/search/?api=1<p" index.html || echo "Clean — none of the removed content remains."

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Remove broken address line, partnership section, newsletter section, and swipe hints"
git push

echo "Done. Live in a minute or two."

