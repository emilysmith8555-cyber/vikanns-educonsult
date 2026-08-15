#!/usr/bin/env bash
cd ~/VikannsWebsite

PASS="✅"
FAIL="❌"
check() {
  if grep -q "$2" "$1" 2>/dev/null; then
    echo "$PASS $3"
  else
    echo "$FAIL $3 — MISSING"
  fi
}

echo "======================================================================"
echo " VIKANNS LTD SITE AUDIT — local files"
echo "======================================================================"

echo ""
echo "-- Branding --"
check index.html "images/logo.png" "Logo image referenced"
check index.html "Vikanns Ltd" "Vikanns Ltd branding present"
if grep -q "Vikanns Educonsult" index.html; then
  echo "$FAIL Old 'Vikanns Educonsult' branding still present somewhere"
else
  echo "$PASS No leftover 'Vikanns Educonsult' branding"
fi

echo ""
echo "-- Hero --"
check index.html "team-green.jpg" "Real team photo (green) in hero"
check index.html "team-white.jpg" "Real team photo (white) in hero"
if grep -q "picsum" index.html; then
  echo "$FAIL Leftover picsum placeholder image(s) still present"
else
  echo "$PASS No leftover picsum placeholder images"
fi

echo ""
echo "-- Navigation (all 11 anchors) --"
for anchor in home about services destinations how-it-works why-vikanns funding resources values faq contact; do
  check index.html "href=\"#$anchor\"" "Nav link -> #$anchor"
done

echo ""
echo "-- Services sub-headings --"
check index.html "Our support can include" "Service 01 sub-heading"
check index.html "Our guidance can include" "Service 02 sub-heading"
check index.html "We help you understand" "Service 03 sub-heading"

echo ""
echo "-- Destinations --"
check index.html "United Kingdom" "UK destination"
check index.html "Canada" "Canada destination"
check index.html "Netherlands" "Netherlands destination"
check index.html "New Zealand" "New Zealand destination"
check index.html "fi fi-gb" "UK flag icon"
check index.html "fi fi-ca" "Canada flag icon"
check index.html "fi fi-nl" "Netherlands flag icon"
check index.html "fi fi-nz" "New Zealand flag icon"
check index.html "fi fi-eu" "EU flag icon"

echo ""
echo "-- Our Values section --"
check index.html "Our Values" "'Our Values' heading (renamed from 'What Guides Us')"

echo ""
echo "-- Registration link --"
check index.html "coursefinder.ai" "Registration link present"
REG_COUNT=$(grep -o "coursefinder.ai" index.html | wc -l)
echo "   -> appears $REG_COUNT time(s) on the page"

echo ""
echo "-- Contact form --"
check index.html "formspree.io/f/xqpzlewe" "Correct Formspree endpoint"
check index.html "_gotcha" "Honeypot spam protection field"
check index.html "Preferred Destination" "Preferred Destination field"
check index.html "Preferred Intake" "Preferred Intake field"
check index.html "Highest Qualification" "Highest Qualification field"

echo ""
echo "-- Social links --"
check index.html "wa.me/2347032751486" "WhatsApp link"
check index.html "facebook.com/share/1EomntQ24U" "Facebook link (updated)"
check index.html "instagram.com/vikannseduconsult" "Instagram link"
check index.html "tiktok.com/@vikanns.educonsul" "TikTok link"
check index.html "fa-brands fa-whatsapp" "Real WhatsApp icon"
check index.html "fa-brands fa-facebook" "Real Facebook icon"

echo ""
echo "-- SEO / meta --"
check index.html "google-site-verification" "Google verification tag"
check index.html "rel=\"icon\"" "Favicon"
check index.html "og:image" "Social share preview image"
check index.html "robots.txt" ".gitignore n/a — checking file directly:" 2>/dev/null || true
if [ -f robots.txt ]; then echo "$PASS robots.txt exists"; else echo "$FAIL robots.txt missing"; fi
if [ -f sitemap.xml ]; then echo "$PASS sitemap.xml exists"; else echo "$FAIL sitemap.xml missing"; fi
check robots.txt "vikanns.com" "robots.txt points to vikanns.com"
check sitemap.xml "vikanns.com" "sitemap.xml points to vikanns.com"

echo ""
echo "-- Mobile nav UX --"
check style.css "flex-wrap: wrap" "Horizontal wrap nav layout"
check script.js "Close the mobile menu" "Tap-outside-to-close listener"

echo ""
echo "-- Custom domain --"
if [ -f CNAME ]; then
  echo "$PASS CNAME file exists, contains: $(cat CNAME)"
else
  echo "$FAIL CNAME file missing"
fi

echo ""
echo "======================================================================"
echo " LIVE SITE CHECK — comparing against https://vikanns.com/"
echo "======================================================================"
LIVE=$(curl -s https://vikanns.com/)
if echo "$LIVE" | grep -q "google-site-verification"; then
  echo "$PASS Live site has Google verification tag"
else
  echo "$FAIL Live site MISSING Google verification tag (may need redeploy)"
fi
if echo "$LIVE" | grep -q "_gotcha"; then
  echo "$PASS Live site has honeypot field"
else
  echo "$FAIL Live site MISSING honeypot field (may need redeploy)"
fi
if echo "$LIVE" | grep -q "New Zealand"; then
  echo "$PASS Live site has New Zealand destination"
else
  echo "$FAIL Live site MISSING New Zealand destination"
fi
if echo "$LIVE" | grep -q "coursefinder.ai"; then
  echo "$PASS Live site has registration link"
else
  echo "$FAIL Live site MISSING registration link"
fi

echo ""
echo "======================================================================"
echo " AUDIT COMPLETE"
echo "======================================================================"

