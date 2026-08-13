#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i \
  -e "/picsum\.photos\/id\/1011/d" \
  -e "/picsum\.photos\/id\/1025/d" \
  -e "/picsum\.photos\/id\/1074/d" \
  index.html

echo "--- Verifying ---"
grep -n "slide\|picsum" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Remove leftover placeholder hero slides, keep only real team photos"
git push

echo "Done. Live in a minute or two."

