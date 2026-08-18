#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# Services swipe-cards
# ---------------------------------------------------------------------------
sed -i 's|<span class="service-num">01</span>|<i class="fa-solid fa-graduation-cap swipe-icon"></i>\n      <span class="service-num">01</span>|' index.html
sed -i 's|<span class="service-num">02</span>|<i class="fa-solid fa-plane swipe-icon"></i>\n      <span class="service-num">02</span>|' index.html
sed -i 's|<span class="service-num">03</span>|<i class="fa-solid fa-sack-dollar swipe-icon"></i>\n      <span class="service-num">03</span>|' index.html
sed -i 's|<span class="service-num">04</span>|<i class="fa-solid fa-file-invoice-dollar swipe-icon"></i>\n      <span class="service-num">04</span>|' index.html
sed -i 's|<span class="service-num">05</span>|<i class="fa-solid fa-compass swipe-icon"></i>\n      <span class="service-num">05</span>|' index.html

# ---------------------------------------------------------------------------
# How It Works swipe-cards
# ---------------------------------------------------------------------------
sed -i 's|<span class="step-num-lg">01</span>|<i class="fa-solid fa-bullseye swipe-icon"></i>\n      <span class="step-num-lg">01</span>|' index.html
sed -i 's|<span class="step-num-lg">02</span>|<i class="fa-solid fa-magnifying-glass swipe-icon"></i>\n      <span class="step-num-lg">02</span>|' index.html
sed -i 's|<span class="step-num-lg">03</span>|<i class="fa-solid fa-clipboard-list swipe-icon"></i>\n      <span class="step-num-lg">03</span>|' index.html
sed -i 's|<span class="step-num-lg">04</span>|<i class="fa-solid fa-envelope-circle-check swipe-icon"></i>\n      <span class="step-num-lg">04</span>|' index.html
sed -i 's|<span class="step-num-lg">05</span>|<i class="fa-solid fa-plane-departure swipe-icon"></i>\n      <span class="step-num-lg">05</span>|' index.html
sed -i 's|<span class="step-num-lg">06</span>|<i class="fa-solid fa-suitcase-rolling swipe-icon"></i>\n      <span class="step-num-lg">06</span>|' index.html

# ---------------------------------------------------------------------------
# Why Vikanns
# ---------------------------------------------------------------------------
sed -i 's|<h3>Personalised Guidance</h3>|<i class="fa-solid fa-user-check why-icon"></i><h3>Personalised Guidance</h3>|' index.html
sed -i 's|<h3>Practical Solutions</h3>|<i class="fa-solid fa-lightbulb why-icon"></i><h3>Practical Solutions</h3>|' index.html
sed -i 's|<h3>Transparent Process</h3>|<i class="fa-solid fa-eye why-icon"></i><h3>Transparent Process</h3>|' index.html
sed -i 's|<h3>Student-First Approach</h3>|<i class="fa-solid fa-heart why-icon"></i><h3>Student-First Approach</h3>|' index.html
sed -i 's|<h3>Funding Support</h3>|<i class="fa-solid fa-hand-holding-dollar why-icon"></i><h3>Funding Support</h3>|' index.html
sed -i 's|<h3>End-to-End Guidance</h3>|<i class="fa-solid fa-route why-icon"></i><h3>End-to-End Guidance</h3>|' index.html

# ---------------------------------------------------------------------------
# Resources
# ---------------------------------------------------------------------------
sed -i 's|<h3>Study Abroad Guides</h3>|<i class="fa-solid fa-book-open resource-icon"></i><h3>Study Abroad Guides</h3>|' index.html
sed -i 's|<h3>Funding Guides</h3>|<i class="fa-solid fa-coins resource-icon"></i><h3>Funding Guides</h3>|' index.html
sed -i 's|<h3>Visa Guidance</h3>|<i class="fa-solid fa-passport resource-icon"></i><h3>Visa Guidance</h3>|' index.html
sed -i 's|<h3>Intake Updates</h3>|<i class="fa-solid fa-calendar-days resource-icon"></i><h3>Intake Updates</h3>|' index.html
sed -i 's|<h3>Career &amp; Academic Insights</h3>|<i class="fa-solid fa-chart-line resource-icon"></i><h3>Career \&amp; Academic Insights</h3>|' index.html

# ---------------------------------------------------------------------------
# Styling
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Topical icons ---------------- */
.swipe-icon {
  display: block;
  font-size: 1.8rem;
  color: var(--green);
  margin-bottom: 6px;
}
.why-icon, .resource-icon {
  display: block;
  font-size: 1.6rem;
  color: var(--green);
  margin-bottom: 10px;
}
EOF

echo "--- Verifying ---"
grep -c "swipe-icon" index.html
grep -c "why-icon" index.html
grep -c "resource-icon" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add topical icons next to headings in Services, How It Works, Why Vikanns, Resources"
git push

echo "Done. Live in a minute or two."

