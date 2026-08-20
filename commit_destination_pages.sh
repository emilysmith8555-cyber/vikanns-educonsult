#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add 5 separate destination pages with full SEO metadata"
git push

echo "Done. Pages are now live."

