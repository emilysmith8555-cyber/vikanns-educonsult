#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<textarea name="message" placeholder="Tell us about your goals" rows="4" required></textarea>|<textarea name="message" placeholder="Tell us about your goals" rows="4" required></textarea>\n    <input type="text" name="_gotcha" style="display:none" tabindex="-1" autocomplete="off">|' index.html

echo "--- Verifying ---"
grep -n "_gotcha" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add honeypot field to filter bot spam from contact form"
git push

echo "Done. Live in a minute or two."

