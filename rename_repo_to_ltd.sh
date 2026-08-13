#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Renaming GitHub repo..."
gh repo rename vikanns-ltd --yes

echo "==> Updating local git remote..."
git remote set-url origin https://github.com/emilysmith8555-cyber/vikanns-ltd.git

echo "==> Updating internal URLs in sitemap/robots/README..."
sed -i 's|vikanns-educonsult|vikanns-ltd|g' robots.txt sitemap.xml README.md

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Update internal links after repo rename to vikanns-ltd"
git push

echo ""
echo "======================================================================"
echo " Done. Your new live URL is:"
echo "   https://emilysmith8555-cyber.github.io/vikanns-ltd/"
echo " (the old vikanns-educonsult link will likely stop working)"
echo "======================================================================"

