#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Remove the duplicate empty footer-col div right before Legal
awk '
  /<div class="footer-col">$/ {
    if (prev == "    <div class=\"footer-col\">") { next }
  }
  { print; prev = $0 }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 2. Fix the scroll-top button: change the ORIGINAL rule's left to right,
#    and remove my redundant duplicate rule entirely
sed -i '448s|left: 24px;|right: 24px;|' style.css

awk '
  /^\.scroll-top-btn \{$/ { count++ }
  count == 2 { skip=1 }
  skip && /^}$/ { skip=0; next }
  skip { next }
  { print }
' style.css > style_tmp.css && mv style_tmp.css style.css

echo "--- Verifying ---"
grep -n "footer-col" index.html | head -10
echo "---"
grep -n -A5 "scroll-top-btn {" style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix duplicate empty footer column and scroll-top button positioning conflict"
git push

echo "Done. Live in a minute or two."

