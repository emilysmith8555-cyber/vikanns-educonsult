#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Add nav link
sed -i 's|<li><a href="index.html#contact">Contact</a></li>|<li><a href="#booking">Book a Consultation</a></li>\n      <li><a href="#contact">Contact</a></li>|' index.html 2>/dev/null || true
sed -i 's|<li><a href="#contact">Contact</a></li>|<li><a href="#booking">Book a Consultation</a></li>\n      <li><a href="#contact">Contact</a></li>|' index.html

# 2. Insert the booking section right before Contact
awk '
  /<section id="contact" class="contact reveal">/ && !inserted {
    print "<section id=\"booking\" class=\"booking reveal\">"
    print "  <h2>Book a Consultation</h2>"
    print "  <p class=\"section-lead\">Select your preferences below, then continue on WhatsApp to confirm with our team.</p>"
    print "  <div class=\"booking-form\">"
    print "    <select id=\"bookService\">"
    print "      <option value=\"\">Select a service</option>"
    print "      <option>Study Abroad Admissions</option>"
    print "      <option>Visa Guidance</option>"
    print "      <option>Education Funding</option>"
    print "      <option>Proof of Funds Guidance</option>"
    print "      <option>Academic &amp; Career Advisory</option>"
    print "    </select>"
    print "    <input type=\"date\" id=\"bookDate\">"
    print "    <input type=\"time\" id=\"bookTime\">"
    print "    <button type=\"button\" id=\"bookSubmit\" class=\"btn-primary\">Continue on WhatsApp</button>"
    print "  </div>"
    print "  <p class=\"disclaimer-inline center\">This sends your preferences to our team on WhatsApp to confirm a suitable time \u2014 it does not reserve a slot automatically.</p>"
    print "</section>"
    print ""
    inserted=1
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# 3. Styling
cat >> style.css << 'EOF'

/* ---------------- Consultation Booking ---------------- */
.booking { text-align: center; }
.booking-form { max-width: 420px; margin: 20px auto 0; display: flex; flex-direction: column; gap: 12px; text-align: left; }
.booking-form select, .booking-form input {
  padding: 12px 14px; border: 1px solid #ccc; border-radius: 8px; font-family: inherit; font-size: 1rem; width: 100%;
}
EOF

# 4. JS: build the WhatsApp message from the selections
cat >> script.js << 'EOF'

// Consultation Booking — builds a pre-filled WhatsApp message from selections
(function () {
  const btn = document.getElementById('bookSubmit');
  if (!btn) return;
  btn.addEventListener('click', function () {
    const service = document.getElementById('bookService').value || 'a consultation';
    const date = document.getElementById('bookDate').value || 'a date to be discussed';
    const time = document.getElementById('bookTime').value || 'a time to be discussed';
    const msg = 'Hello Vikanns, I would like to book a consultation for ' + service + ' on ' + date + ' at ' + time + '.';
    window.open('https://wa.me/2347032751486?text=' + encodeURIComponent(msg), '_blank');
  });
})();
EOF

echo "--- Verifying ---"
grep -n "id=\"booking\"\|bookSubmit\|Book a Consultation" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add honest Consultation Booking flow (Section 15) — WhatsApp handoff, no fake confirmation"
git push

echo "Done. Live in a minute or two."

