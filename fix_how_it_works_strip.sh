#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

STRIP='  <div class="scroll-strip"><div class="scroll-strip-track">'
STRIP="$STRIP<img src=\"images/team-green.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/team-white.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/hero-empower.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/hero-team-lineup.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/value-people.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/team-green.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/team-white.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/hero-empower.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/hero-team-lineup.jpg\" alt=\"\">"
STRIP="$STRIP<img src=\"images/value-people.jpg\" alt=\"\">"
STRIP="$STRIP</div></div>"

if ! grep -q "scroll-strip" index.html; then
  awk -v strip="$STRIP" '
    /<p class="section-lead">From an idea to a clear pathway\.<\/p>/ { print; print strip; next }
    { print }
  ' index.html > index_tmp.html && mv index_tmp.html index.html
  echo "Scroll strip added."
else
  echo "Already present, skipped."
fi

echo "--- Verifying ---"
grep -n "scroll-strip" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix: actually apply How It Works scrolling image strip"
git push

echo "Done. Live in a minute or two."

