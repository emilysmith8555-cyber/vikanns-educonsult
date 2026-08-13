#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|https://formspree.io/f/REPLACE_WITH_YOUR_FORM_ID|https://formspree.io/f/xqpzlewe|' index.html

echo "--- Verifying ---"
grep -n "formspree" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Wire up real Formspree endpoint for contact form"
git push

echo "Done. Live in a minute or two."

