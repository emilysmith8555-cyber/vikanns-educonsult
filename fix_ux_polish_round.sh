#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Push the scroll-top arrow further above the WhatsApp button
# ---------------------------------------------------------------------------
sed -i 's|^  bottom: 94px;$|  bottom: 120px;|' style.css

# ---------------------------------------------------------------------------
# 2. Make the hamburger nav universal (desktop AND mobile), fixing the
#    hero-crowding issue on PC — tap to open, tap anywhere to close
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Universal hamburger nav (desktop + mobile) ---------------- */
.menu-toggle { display: block !important; }
.nav-links {
  position: absolute !important;
  top: 100% !important;
  left: 0 !important;
  right: 0 !important;
  background: var(--white) !important;
  flex-direction: row !important;
  flex-wrap: wrap !important;
  justify-content: center !important;
  align-items: center !important;
  padding: 16px 0 !important;
  display: none !important;
  box-shadow: 0 8px 16px rgba(0,0,0,0.08) !important;
  gap: 10px 18px !important;
}
.nav-links.open { display: flex !important; }
.nav-cta { display: inline-block !important; }

/* ---------------- Let the site breathe on wide screens ---------------- */
@media (min-width: 1400px) {
  section, .navbar { max-width: 1500px; }
}

/* ---------------- Bigger Values slideshow on wide screens ---------------- */
@media (min-width: 1024px) {
  .values-slideshow { max-width: 640px; height: 520px; }
}
EOF

# ---------------------------------------------------------------------------
# 3. Add visible labels to the Booking form's date/time fields
# ---------------------------------------------------------------------------
sed -i 's|<input type="date" id="bookDate">|<label class="booking-label">Choose your date</label>\n    <input type="date" id="bookDate">|' index.html
sed -i 's|<input type="time" id="bookTime">|<label class="booking-label">Choose your time</label>\n    <input type="time" id="bookTime">|' index.html
sed -i 's|<option value="">Select a service</option>|<option value="">Choose your service</option>|' index.html

cat >> style.css << 'EOF'

/* ---------------- Booking form labels ---------------- */
.booking-label { font-size: 0.85rem; font-weight: 600; color: var(--green-dark); margin-bottom: -6px; }
EOF

echo "--- Verifying ---"
grep -n "bottom: 120px\|booking-label\|Choose your service\|Choose your date\|Choose your time" index.html style.css

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "UX polish: universal hamburger nav, wider desktop layout, bigger Values slideshow on PC, booking form labels, fix scroll-top overlap"
git push

echo "Done. Live in a minute or two."

