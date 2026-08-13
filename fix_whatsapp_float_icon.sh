#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# Replace the floating WhatsApp button's emoji (sits alone on its own line)
sed -i 's|^  💬$|  <i class="fa-brands fa-whatsapp"></i>|' index.html

# Icon styling (only add if not already there)
if ! grep -q "Brand icons in Contact section" style.css; then
  cat >> style.css << 'EOF'

/* ---------------- Brand icons in Contact section ---------------- */
.contact-info a i { margin-right: 8px; }
.whatsapp-float i { font-size: 1.6rem; }
EOF
fi

echo "--- Verifying ---"
grep -n "font-awesome\|fa-phone\|fa-whatsapp\|fa-facebook\|fa-instagram\|fa-tiktok" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Use real brand icons instead of emoji in Contact section"
git push

echo "Done. Live in a minute or two."

