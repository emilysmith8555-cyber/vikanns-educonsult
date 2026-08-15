#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

cat > robots.txt << 'EOF'
User-agent: *
Allow: /
Sitemap: https://vikanns.com/sitemap.xml
EOF

cat > sitemap.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://vikanns.com/</loc>
    <priority>1.0</priority>
  </url>
</urlset>
EOF

echo "--- Verifying ---"
cat robots.txt
echo "---"
cat sitemap.xml

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix robots.txt and sitemap.xml to reference vikanns.com"
git push

echo "Done. Live in a minute or two."

