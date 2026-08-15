#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Copying new hero images from Downloads..."
cp ~/storage/downloads/hero-empower.jpg images/hero-empower.jpg
cp ~/storage/downloads/hero-team-lineup.jpg images/hero-team-lineup.jpg
echo "Images copied:"
ls -la images/hero-*.jpg

# Add the two new slides into the hero slideshow, keeping the existing two
sed -i "s|<div class=\"slide\" style=\"background-image:url('images/team-white.jpg')\"></div>|<div class=\"slide\" style=\"background-image:url('images/team-white.jpg')\"></div>\n    <div class=\"slide\" style=\"background-image:url('images/hero-empower.jpg')\"></div>\n    <div class=\"slide\" style=\"background-image:url('images/hero-team-lineup.jpg')\"></div>|" index.html

echo "--- Verifying ---"
grep -n "team-green.jpg\|team-white.jpg\|hero-empower.jpg\|hero-team-lineup.jpg" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add two more images to hero slideshow"
git push

echo "Done. Live in a minute or two."

