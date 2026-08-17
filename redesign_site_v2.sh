#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Rebuilding Services, Destinations, How It Works, and Contact..."

# ---------------------------------------------------------------------------
# 1. SERVICES — swipeable cards, partnerships removed (moves to Contact)
# ---------------------------------------------------------------------------
SERVICES_NEW=$(cat << 'EOF'
<section id="services" class="services reveal">
  <h2>What We Do</h2>
  <p class="section-lead">Solutions designed around your goals. Vikanns provides practical support across education, international opportunities and advisory services.</p>
  <p class="swipe-hint">Swipe to see all &rarr;</p>
  <div class="swipe-carousel">
    <div class="swipe-card">
      <span class="service-num">01</span>
      <h3>Study Abroad &amp; Admissions</h3>
      <p class="service-tagline">Find the right academic pathway.</p>
      <p>We guide students through identifying suitable programmes, institutions and destinations based on their academic background, career goals and budget.</p>
      <p class="list-lead">Our support can include:</p>
      <ul>
        <li>Bachelor's programmes</li>
        <li>Master's programmes</li>
        <li>MRes and postgraduate routes</li>
        <li>Professional and vocational programmes</li>
        <li>Certificate programmes</li>
        <li>Course and destination selection</li>
        <li>Application preparation and submission</li>
      </ul>
      <a href="#contact" class="btn-outline">Explore Study Options</a>
    </div>
    <div class="swipe-card">
      <span class="service-num">02</span>
      <h3>Visa Guidance &amp; Application Support</h3>
      <p class="service-tagline">Prepare with clarity and confidence.</p>
      <p>We help students understand visa requirements and organise their applications carefully.</p>
      <p class="list-lead">Our guidance can include:</p>
      <ul>
        <li>Document preparation</li>
        <li>Financial documentation guidance</li>
        <li>Application guidance</li>
        <li>Visa documentation review</li>
        <li>Interview preparation</li>
        <li>Pre-departure guidance</li>
      </ul>
      <p class="disclaimer-inline">We do not guarantee visa outcomes. Instead, we help you understand the requirements and prepare a complete, well-organised application.</p>
      <a href="#contact" class="btn-outline">Get Visa Guidance</a>
    </div>
    <div class="swipe-card">
      <span class="service-num">03</span>
      <h3>Education Funding</h3>
      <p class="service-tagline">Explore ways to finance your education.</p>
      <p>Funding international education can be one of the biggest challenges students face. Vikanns helps eligible students explore available funding options, including study loans and other education financing solutions.</p>
      <p class="list-lead">We help you understand:</p>
      <ul>
        <li>Available funding options</li>
        <li>Eligibility requirements</li>
        <li>Loan documentation</li>
        <li>Repayment considerations</li>
        <li>Proof-of-funds requirements</li>
      </ul>
      <a href="#contact" class="btn-outline">Explore Funding Options</a>
    </div>
    <div class="swipe-card">
      <span class="service-num">04</span>
      <h3>Proof of Funds Solutions</h3>
      <p class="service-tagline">Make your financial documentation part of the plan.</p>
      <p>Understanding financial requirements can be confusing. We help eligible students navigate proof-of-funds requirements and identify appropriate solutions for their chosen destination and programme. Our approach is based on transparency, proper documentation and compliance with the relevant requirements.</p>
      <a href="#contact" class="btn-outline">Speak With an Adviser</a>
    </div>
    <div class="swipe-card">
      <span class="service-num">05</span>
      <h3>Academic &amp; Career Advisory</h3>
      <p class="service-tagline">Don't choose a course simply because it is available. Choose a pathway that makes sense for your future.</p>
      <p>We help students think beyond admission by considering their academic background, career direction, destination, budget and long-term goals.</p>
      <a href="#contact" class="btn-outline">Book a Consultation</a>
    </div>
  </div>
</section>
EOF
)

awk -v repl="$SERVICES_NEW" '
  /<section id="services" class="services reveal">/ { in_sec=1; print repl; next }
  in_sec && /<\/section>/ { in_sec=0; next }
  in_sec { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

echo "Services rebuilt."

# ---------------------------------------------------------------------------
# 2. DESTINATIONS — simple flag + name tiles, no write-ups
# ---------------------------------------------------------------------------
DEST_NEW=$(cat << 'EOF'
<section id="destinations" class="destinations reveal">
  <h2>Explore Your Possibilities</h2>
  <p class="section-lead">One goal. Many possible destinations. Choosing where to study is just as important as choosing what to study.</p>
  <div class="destination-tiles">
    <a href="#contact" class="dest-tile"><span class="fi fi-gb flag-icon-lg"></span><span>United Kingdom</span></a>
    <a href="#contact" class="dest-tile"><span class="fi fi-ca flag-icon-lg"></span><span>Canada</span></a>
    <a href="#contact" class="dest-tile"><span class="fi fi-nl flag-icon-lg"></span><span>Netherlands</span></a>
    <a href="#contact" class="dest-tile"><span class="fi fi-nz flag-icon-lg"></span><span>New Zealand</span></a>
    <a href="#contact" class="dest-tile"><span class="fi fi-eu flag-icon-lg"></span><span>Europe &amp; Beyond</span></a>
  </div>
  <p class="disclaimer-inline center">Available institutions, programmes and destinations may vary according to intake, eligibility and current programme availability.</p>
</section>
EOF
)

awk -v repl="$DEST_NEW" '
  /<section id="destinations" class="destinations reveal">/ { in_sec=1; print repl; next }
  in_sec && /<\/section>/ { in_sec=0; next }
  in_sec { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

echo "Destinations rebuilt."

# ---------------------------------------------------------------------------
# 3. HOW IT WORKS — swipeable cards, scroll-strip removed
# ---------------------------------------------------------------------------
HOWITWORKS_NEW=$(cat << 'EOF'
<section id="how-it-works" class="how-it-works reveal">
  <h2>Your Journey. Simplified.</h2>
  <p class="section-lead">From an idea to a clear pathway.</p>
  <p class="swipe-hint">Swipe to see all &rarr;</p>
  <div class="swipe-carousel">
    <div class="swipe-card">
      <span class="step-num-lg">01</span>
      <h3>Tell Us Your Goal</h3>
      <p>Tell us about your academic background, preferred destination, career plans and budget. Your goals come first.</p>
    </div>
    <div class="swipe-card">
      <span class="step-num-lg">02</span>
      <h3>Explore Your Options</h3>
      <p>We help you identify programmes and pathways that align with your profile and objectives. The right option isn't always the most obvious one.</p>
    </div>
    <div class="swipe-card">
      <span class="step-num-lg">03</span>
      <h3>Prepare Your Application</h3>
      <p>We guide you through the required documents and application process. Every detail matters.</p>
    </div>
    <div class="swipe-card">
      <span class="step-num-lg">04</span>
      <h3>Secure Your Admission</h3>
      <p>Once your application is submitted, we help you understand the next steps towards your offer and enrolment. One step closer.</p>
    </div>
    <div class="swipe-card">
      <span class="step-num-lg">05</span>
      <h3>Plan Your Funding &amp; Visa</h3>
      <p>Where applicable, we guide you through funding, proof-of-funds and visa preparation. Prepare properly. Move confidently.</p>
    </div>
    <div class="swipe-card">
      <span class="step-num-lg">06</span>
      <h3>Get Ready For Your Next Chapter</h3>
      <p>We help you prepare for the transition from home to your new academic destination. Your journey doesn't end at admission.</p>
    </div>
  </div>
</section>
EOF
)

awk -v repl="$HOWITWORKS_NEW" '
  /<section id="how-it-works" class="how-it-works reveal">/ { in_sec=1; print repl; next }
  in_sec && /<\/section>/ { in_sec=0; next }
  in_sec { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

echo "How It Works rebuilt."

# ---------------------------------------------------------------------------
# 4. CONTACT — add a Partnership CTA box
# ---------------------------------------------------------------------------
if ! grep -q "partner-cta" index.html; then
  sed -i 's|<p class="address">📍 Abuja, Nigeria</p>|<p class="address">📍 Abuja, Nigeria</p>\n  <div class="partner-cta">\n    <h3>Represent an Institution or Business?</h3>\n    <p>We welcome partnerships with institutions, organisations and businesses to create meaningful opportunities together.</p>\n    <a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%27m%20interested%20in%20a%20partnership" target="_blank" rel="noopener" class="btn-outline">Partner With Vikanns</a>\n  </div>|' index.html
  echo "Partnership CTA added to Contact."
else
  echo "Partnership CTA already present, skipped."
fi

# ---------------------------------------------------------------------------
# Styling
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Swipeable carousels (Services / How It Works) ---------------- */
.swipe-hint {
  text-align: center;
  font-size: 0.85rem;
  color: var(--muted);
  margin-bottom: 12px;
}
.swipe-carousel {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  gap: 20px;
  padding: 4px 4px 16px;
  -webkit-overflow-scrolling: touch;
}
.swipe-carousel::-webkit-scrollbar { height: 6px; }
.swipe-carousel::-webkit-scrollbar-thumb { background: var(--green); border-radius: 10px; }
.swipe-card {
  flex: 0 0 85%;
  scroll-snap-align: start;
  background: #f4fbf7;
  border: 1px solid #e0f0e6;
  border-radius: 16px;
  padding: 28px 24px;
}
@media (min-width: 700px) {
  .swipe-card { flex: 0 0 360px; }
}
.swipe-card .service-num { color: var(--green); font-weight: 800; font-size: 1.6rem; }
.swipe-card h3 { color: var(--green-dark); margin: 6px 0 4px; font-size: 1.2rem; }
.swipe-card .service-tagline { font-weight: 600; margin-bottom: 10px; }
.swipe-card p { color: var(--muted); margin-bottom: 10px; }
.swipe-card ul { margin: 0 0 14px 18px; color: var(--muted); }
.step-num-lg {
  display: inline-block;
  background: var(--green);
  color: var(--white);
  font-weight: 800;
  width: 44px; height: 44px; line-height: 44px;
  text-align: center;
  border-radius: 50%;
  margin-bottom: 12px;
}

/* ---------------- Destination tiles (flag + name only) ---------------- */
.destination-tiles {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 18px;
}
.dest-tile {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  padding: 24px 18px;
  background: #f4fbf7;
  border: 1px solid #e0f0e6;
  border-radius: 16px;
  width: 140px;
  text-align: center;
  font-weight: 600;
  color: var(--text);
  transition: transform 0.2s;
}
.dest-tile:hover { transform: translateY(-6px); }
.flag-icon-lg {
  width: 56px;
  height: 40px;
  border-radius: 6px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.2);
  background-size: cover;
}

/* ---------------- Partnership CTA in Contact ---------------- */
.partner-cta {
  max-width: 520px;
  margin: 30px auto 0;
  padding: 26px 24px;
  border: 2px dashed var(--green);
  border-radius: 16px;
  text-align: center;
}
.partner-cta h3 { color: var(--green-dark); margin-bottom: 8px; }
.partner-cta p { color: var(--muted); margin-bottom: 16px; }
EOF

echo "--- Verifying ---"
grep -n "swipe-carousel\|destination-tiles\|partner-cta\|step-num-lg" index.html | head -20

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Major redesign: swipeable Services/How It Works, simplified Destinations tiles, Partnership CTA in Contact"
git push

echo ""
echo "Done. Live in a minute or two."

