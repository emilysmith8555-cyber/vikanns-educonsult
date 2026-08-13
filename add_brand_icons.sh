#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Load Font Awesome (brand + solid icon sets) via CDN
if ! grep -q "font-awesome" index.html; then
  sed -i 's|<link rel="stylesheet" href="style.css">|<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">\n<link rel="stylesheet" href="style.css">|' index.html
fi

# 2. Swap emoji for real brand icons in the Contact section
sed -i \
  -e 's|📞 +234 703 275 1486|<i class="fa-solid fa-phone"></i> +234 703 275 1486|' \
  -e 's|📞 +234 816 384 8822|<i class="fa-solid fa-phone"></i> +234 816 384 8822|' \
  -e 's|💬 WhatsApp Us|<i class="fa-brands fa-whatsapp"></i> WhatsApp Us|' \
  -e 's|📘 Facebook|<i class="fa-brands fa-facebook"></i> Facebook|' \
  -e 's|📸 Instagram|<i class="fa-brands fa-instagram"></i> Instagram|' \
  -e 's|🎵 TikTok|<i class="fa-brands fa-tiktok"></i> TikTok|' \
  index.html

# 3. Also give the floating WhatsApp button a real icon instead of an emoji
sed -i 's|aria-label="Chat with us on WhatsApp">\n  💬|aria-label="Chat with us on WhatsApp">\n  <i class="fa-brands fa-whatsapp"></i>|' index.html
python3 - << 'PYEOF' 2>/dev/null || true
PYEOF
perl -0pi -e 's/aria-label="Chat with us on WhatsApp">\s*💬/aria-label="Chat with us on WhatsApp">\n  <i class="fa-brands fa-whatsapp"><\/i>/s' index.html

# 4. Icon styling
cat >> style.css << 'EOF'

/* ---------------- Brand icons in Contact section ---------------- */
.contact-info a i { margin-right: 8px; }
.whatsapp-float i { font-size: 1.6rem; }
EOF

echo "--- Verifying ---"
grep -n "font-awesome\|fa-phone\|fa-whatsapp\|fa-facebook\|fa-instagram\|fa-tiktok" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Use real brand icons instead of emoji in Contact section"
git push

echo "Done. Live in a minute or two."

