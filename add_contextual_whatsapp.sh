#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Floating button label per brief ("Chat With Vikanns")
sed -i 's|aria-label="Chat with us on WhatsApp">|aria-label="Chat With Vikanns">|' index.html

# 2. Eligibility section — WhatsApp alternative near the top
sed -i 's|<p class="section-lead">Answer a few questions and discover which study pathways may fit your profile.</p>|<p class="section-lead">Answer a few questions and discover which study pathways may fit your profile.</p>\n  <p class="wa-alt"><a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20would%20like%20to%20check%20my%20study%20abroad%20eligibility." target="_blank" rel="noopener"><i class="fa-brands fa-whatsapp"></i> Prefer WhatsApp? Chat with us instead</a></p>|' index.html

# 3. Admissions service (01) — contextual WhatsApp link after its CTA
sed -i 's|<a href="#contact" class="btn-outline">Find My Programme</a>|<a href="#contact" class="btn-outline">Find My Programme</a>\n      <a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20would%20like%20help%20choosing%20a%20study%20programme." target="_blank" rel="noopener" class="wa-alt-link"><i class="fa-brands fa-whatsapp"></i> Or WhatsApp us</a>|' index.html

# 4. Visa service (02) — contextual WhatsApp link after its CTA
sed -i 's|<a href="#contact" class="btn-outline">Get Visa Guidance</a>|<a href="#contact" class="btn-outline">Get Visa Guidance</a>\n      <a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20would%20like%20guidance%20with%20my%20student%20visa%20preparation." target="_blank" rel="noopener" class="wa-alt-link"><i class="fa-brands fa-whatsapp"></i> Or WhatsApp us</a>|' index.html

# 5. Funding section — contextual WhatsApp link after its CTA
sed -i 's|<div class="center-btn"><a href="#contact" class="btn-primary">Explore Funding Options</a></div>|<div class="center-btn"><a href="#contact" class="btn-primary">Explore Funding Options</a><br><a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%20would%20like%20to%20learn%20about%20education%20funding%20options." target="_blank" rel="noopener" class="wa-alt-link-light"><i class="fa-brands fa-whatsapp"></i> Or WhatsApp us</a></div>|' index.html

cat >> style.css << 'EOF'

/* ---------------- Contextual WhatsApp links ---------------- */
.wa-alt { text-align: center; font-size: 0.85rem; margin-bottom: 20px; }
.wa-alt a { color: #25d366; font-weight: 600; }
.wa-alt-link, .wa-alt-link-light { display: inline-block; margin-top: 8px; font-size: 0.85rem; color: #25d366; font-weight: 600; }
.wa-alt-link-light { color: rgba(255,255,255,0.9); }
EOF

echo "--- Verifying ---"
grep -c "wa.me" index.html
grep -n "Chat With Vikanns\|Prefer WhatsApp\|Or WhatsApp us" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add contextual WhatsApp messages per Section 13 of upgrade brief (partnership link pending)"
git push

echo "Done. Live in a minute or two."

