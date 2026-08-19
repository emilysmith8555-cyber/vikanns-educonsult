#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Clickable map link, replacing plain "Abuja, Nigeria" text
# ---------------------------------------------------------------------------
MAPS_URL='https://www.google.com/maps/search/?api=1&query=Vikanns+Ltd+Abuja+Nigeria'

sed -i "s|<p class=\"address\">📍 Abuja, Nigeria</p>|<p class=\"address\"><a href=\"${MAPS_URL}\" target=\"_blank\" rel=\"noopener\">📍 Abuja, Nigeria</a></p>|" index.html

# Footer contact column: "Abuja, Nigeria" as its own <p>, make it a link too
awk -v url="$MAPS_URL" '
  /<p>Abuja, Nigeria<\/p>/ && !done {
    print "      <a href=\"" url "\" target=\"_blank\" rel=\"noopener\">Abuja, Nigeria</a>"
    done=1
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

echo "--- Verifying map links ---"
grep -n "google.com/maps" index.html

# ---------------------------------------------------------------------------
# 2. Show current title + meta description for review
# ---------------------------------------------------------------------------
echo ""
echo "--- Current <title> and meta description ---"
grep -n "<title>\|name=\"description\"\|og:title\|og:description" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add clickable Google Maps link for Abuja address in Contact and footer"
git push

echo ""
echo "Done. Live in a minute or two."

