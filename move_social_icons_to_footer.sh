#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Remove the social links from the Contact section (keep the 2 phone links only)
sed -i '/wa\.me\/2347032751486" target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"><\/i> Chat with a Vikanns Adviser/d' index.html
sed -i '/facebook\.com\/share\/1EomntQ24U/d' index.html
sed -i '/instagram\.com\/vikannseduconsult/d' index.html
sed -i '/tiktok\.com\/@vikanns\.educonsul/d' index.html

# 2. Add icon-only social row to the footer, just above the disclaimer
awk '
  /<p class="footer-disclaimer">/ && !done {
    print "  <div class=\"footer-social\">"
    print "    <a href=\"https://wa.me/2347032751486\" target=\"_blank\" rel=\"noopener\" aria-label=\"WhatsApp\"><i class=\"fa-brands fa-whatsapp\"></i></a>"
    print "    <a href=\"https://www.facebook.com/share/1EomntQ24U/?mibextid=wwXIfr\" target=\"_blank\" rel=\"noopener\" aria-label=\"Facebook\"><i class=\"fa-brands fa-facebook\"></i></a>"
    print "    <a href=\"https://instagram.com/vikannseduconsult\" target=\"_blank\" rel=\"noopener\" aria-label=\"Instagram\"><i class=\"fa-brands fa-instagram\"></i></a>"
    print "    <a href=\"https://www.tiktok.com/@vikanns.educonsul?_r=1&_t=ZS-98rJl8ROFEn\" target=\"_blank\" rel=\"noopener\" aria-label=\"TikTok\"><i class=\"fa-brands fa-tiktok\"></i></a>"
    print "  </div>"
    done=1
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Footer social icons ---------------- */
.footer-social {
  display: flex;
  justify-content: center;
  gap: 22px;
  margin: 8px 0 22px;
}
.footer-social a {
  color: var(--white);
  font-size: 1.5rem;
  transition: opacity 0.2s, transform 0.2s;
}
.footer-social a:hover { opacity: 0.8; transform: translateY(-3px); }
EOF

echo "--- Verifying ---"
grep -n "footer-social\|fa-whatsapp\|fa-facebook\|fa-instagram\|fa-tiktok" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Move social icons from Contact section to footer, icon-only"
git push

echo "Done. Live in a minute or two."

