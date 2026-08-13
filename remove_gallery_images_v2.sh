#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i \
  -e '/picsum\.photos\/id\/1027/d' \
  -e '/picsum\.photos\/id\/1035/d' \
  -e '/picsum\.photos\/id\/1041/d' \
  -e '/picsum\.photos\/id\/1043/d' \
  -e '/picsum\.photos\/id\/1050/d' \
  -e '/picsum\.photos\/id\/1059/d' \
  index.html

sed -i 's|Photos shown are illustrative placeholders — real student photos coming soon.|Photos coming soon.|' index.html

echo "--- Verifying ---"
grep -n "gallery-grid\|Photos coming soon\|picsum" index.html || true

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Remove placeholder gallery images"
git push

echo "Done. Changes will be live on the site within a minute or two."

