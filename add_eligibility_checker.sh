#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Point the hero's "Check My Eligibility" button to the new section
# ---------------------------------------------------------------------------
sed -i 's|<a href="#contact" class="btn-primary">Check My Eligibility</a>|<a href="#eligibility" class="btn-primary">Check My Eligibility</a>|' index.html

# 2. Add a nav link right after Home, since this is now the primary conversion path
if ! grep -q 'href="#eligibility"' index.html; then
  sed -i 's|<li><a href="#home">Home</a></li>|<li><a href="#home">Home</a></li>\n      <li><a href="#eligibility">Check Eligibility</a></li>|' index.html
fi

# ---------------------------------------------------------------------------
# 3. Insert the eligibility checker section right after the trust strip
# ---------------------------------------------------------------------------
awk '
  /<section id="about" class="about reveal">/ && !inserted {
    print "<section id=\"eligibility\" class=\"eligibility reveal\">"
    print "  <h2>Check Your Study Abroad Eligibility</h2>"
    print "  <p class=\"section-lead\">Answer a few questions and discover which study pathways may fit your profile.</p>"
    print "  <form id=\"eligibilityForm\" class=\"eligibility-form\" action=\"https://formspree.io/f/xqpzlewe\" method=\"POST\">"
    print "    <input type=\"hidden\" name=\"form_type\" value=\"Eligibility Checker\">"
    print "    <input type=\"text\" name=\"_gotcha\" style=\"display:none\" tabindex=\"-1\" autocomplete=\"off\">"
    print "    <p class=\"elig-progress\" id=\"eligProgressText\">Step 1 of 7</p>"
    print ""
    print "    <div class=\"elig-step active\" data-step=\"1\">"
    print "      <h3>Personal Information</h3>"
    print "      <input type=\"text\" name=\"full_name\" placeholder=\"Full Name\" required>"
    print "      <input type=\"email\" name=\"email\" placeholder=\"Email\" required>"
    print "      <input type=\"text\" name=\"whatsapp\" placeholder=\"WhatsApp Number\" required>"
    print "      <input type=\"number\" name=\"age\" placeholder=\"Age\" required min=\"10\" max=\"100\">"
    print "      <input type=\"text\" name=\"country_residence\" placeholder=\"Country of Residence\" required>"
    print "    </div>"
    print ""
    print "    <div class=\"elig-step\" data-step=\"2\">"
    print "      <h3>Academic Background</h3>"
    print "      <input type=\"text\" name=\"qualification\" placeholder=\"Highest Qualification\" required>"
    print "      <input type=\"text\" name=\"institution\" placeholder=\"Institution\">"
    print "      <input type=\"text\" name=\"field_of_study\" placeholder=\"Field of Study\">"
    print "      <input type=\"text\" name=\"grade\" placeholder=\"Grade / GPA\">"
    print "      <input type=\"text\" name=\"graduation_year\" placeholder=\"Graduation Year\">"
    print "    </div>"
    print ""
    print "    <div class=\"elig-step\" data-step=\"3\">"
    print "      <h3>Study Preference</h3>"
    print "      <select name=\"degree_level\" required>"
    print "        <option value=\"\">Preferred Degree Level</option>"
    print "        <option>Bachelor'\''s</option>"
    print "        <option>Master'\''s</option>"
    print "        <option>MRes</option>"
    print "        <option>PhD</option>"
    print "        <option>Professional</option>"
    print "        <option>Vocational</option>"
    print "        <option>Certificate</option>"
    print "      </select>"
    print "      <input type=\"text\" name=\"preferred_field\" placeholder=\"Preferred Field\">"
    print "      <input type=\"text\" name=\"preferred_intake\" placeholder=\"Preferred Intake\">"
    print "    </div>"
    print ""
    print "    <div class=\"elig-step\" data-step=\"4\">"
    print "      <h3>Destination</h3>"
    print "      <p class=\"elig-hint\">Select all that interest you:</p>"
    print "      <label><input type=\"checkbox\" name=\"destination_uk\" value=\"United Kingdom\" class=\"elig-dest\"> United Kingdom</label>"
    print "      <label><input type=\"checkbox\" name=\"destination_canada\" value=\"Canada\" class=\"elig-dest\"> Canada</label>"
    print "      <label><input type=\"checkbox\" name=\"destination_nz\" value=\"New Zealand\" class=\"elig-dest\"> New Zealand</label>"
    print "      <label><input type=\"checkbox\" name=\"destination_nl\" value=\"Netherlands\" class=\"elig-dest\"> Netherlands</label>"
    print "      <label><input type=\"checkbox\" name=\"destination_eu\" value=\"Other Europe\" class=\"elig-dest\"> Other Europe</label>"
    print "      <label><input type=\"checkbox\" name=\"destination_other\" value=\"Other\" class=\"elig-dest\"> Other</label>"
    print "    </div>"
    print ""
    print "    <div class=\"elig-step\" data-step=\"5\">"
    print "      <h3>English Language</h3>"
    print "      <select name=\"english_test\" required>"
    print "        <option value=\"\">Select an option</option>"
    print "        <option>IELTS</option>"
    print "        <option>TOEFL</option>"
    print "        <option>PTE</option>"
    print "        <option>Duolingo</option>"
    print "        <option>Other</option>"
    print "        <option>Not yet taken</option>"
    print "      </select>"
    print "    </div>"
    print ""
    print "    <div class=\"elig-step\" data-step=\"6\">"
    print "      <h3>Budget</h3>"
    print "      <input type=\"text\" name=\"annual_budget\" placeholder=\"Approximate annual education budget\" required>"
    print "    </div>"
    print ""
    print "    <div class=\"elig-step\" data-step=\"7\">"
    print "      <h3>Your Preliminary Study Profile</h3>"
    print "      <div id=\"eligResultCards\"></div>"
    print "      <p class=\"elig-disclaimer\">This assessment provides preliminary guidance only. Final eligibility depends on the institution, programme, immigration authority and applicable requirements.</p>"
    print "      <button type=\"submit\" class=\"btn-primary\">Speak With a Vikanns Adviser</button>"
    print "    </div>"
    print ""
    print "    <div class=\"elig-nav\">"
    print "      <button type=\"button\" id=\"eligBack\" class=\"btn-outline\">Back</button>"
    print "      <button type=\"button\" id=\"eligNext\" class=\"btn-primary\">Next</button>"
    print "    </div>"
    print "  </form>"
    print "</section>"
    print ""
    inserted=1
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# ---------------------------------------------------------------------------
# 4. Styling
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Eligibility Checker ---------------- */
.eligibility { text-align: center; }
.eligibility-form { max-width: 560px; margin: 20px auto 0; text-align: left; }
.elig-progress { text-align: center; font-weight: 700; color: var(--green-dark); margin-bottom: 20px; }
.elig-step { display: none; flex-direction: column; gap: 12px; }
.elig-step.active { display: flex; }
.elig-step h3 { color: var(--green-dark); margin-bottom: 6px; }
.elig-step input, .elig-step select {
  padding: 12px 14px; border: 1px solid #ccc; border-radius: 8px; font-family: inherit; font-size: 1rem; width: 100%;
}
.elig-step label { display: flex; align-items: center; gap: 8px; font-size: 0.95rem; }
.elig-hint { color: var(--muted); font-size: 0.9rem; margin-bottom: 4px; }
.elig-disclaimer { font-size: 0.85rem; font-style: italic; color: var(--muted); margin: 16px 0; }
.elig-nav { display: flex; justify-content: space-between; margin-top: 24px; }
.elig-result-card {
  background: #f4fbf7; border: 1px solid #e0f0e6; border-radius: 12px;
  padding: 18px; margin-bottom: 12px; text-align: left;
}
.elig-result-card h4 { color: var(--green-dark); margin-bottom: 6px; }
EOF

# ---------------------------------------------------------------------------
# 5. Multi-step JS logic (no page reload; final step submits via Formspree)
# ---------------------------------------------------------------------------
cat >> script.js << 'EOF'

// Eligibility Checker — multi-step navigation
(function () {
  const steps = document.querySelectorAll('.elig-step');
  if (steps.length === 0) return;
  const totalSteps = steps.length;
  let current = 1;
  const nextBtn = document.getElementById('eligNext');
  const backBtn = document.getElementById('eligBack');
  const progressText = document.getElementById('eligProgressText');
  const resultCards = document.getElementById('eligResultCards');

  function showStep(n) {
    steps.forEach(s => s.classList.remove('active'));
    const target = document.querySelector('.elig-step[data-step="' + n + '"]');
    if (target) target.classList.add('active');
    progressText.textContent = 'Step ' + n + ' of ' + totalSteps;
    backBtn.style.visibility = n === 1 ? 'hidden' : 'visible';
    nextBtn.style.display = n === totalSteps ? 'none' : 'inline-block';
    if (n === totalSteps) buildResults();
  }

  function buildResults() {
    const checked = document.querySelectorAll('.elig-dest:checked');
    resultCards.innerHTML = '';
    if (checked.length === 0) {
      resultCards.innerHTML = '<p>No destinations selected yet \u2014 go back to Step 4 to choose one or more.</p>';
      return;
    }
    checked.forEach(function (box) {
      const card = document.createElement('div');
      card.className = 'elig-result-card';
      card.innerHTML = '<h4>' + box.value + '</h4><p>You have expressed interest in this destination. A Vikanns adviser can walk you through what this pathway may involve for your specific profile.</p>';
      resultCards.appendChild(card);
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener('click', function () {
      const activeStep = document.querySelector('.elig-step[data-step="' + current + '"]');
      const requiredFields = activeStep.querySelectorAll('[required]');
      for (const f of requiredFields) {
        if (!f.value) { f.reportValidity(); return; }
      }
      if (current < totalSteps) {
        current++;
        showStep(current);
      }
    });
  }
  if (backBtn) {
    backBtn.addEventListener('click', function () {
      if (current > 1) {
        current--;
        showStep(current);
      }
    });
  }
  showStep(current);
})();
EOF

echo "--- Verifying ---"
grep -n "id=\"eligibility\"\|eligibilityForm\|elig-step\|Check Eligibility" index.html | head -20

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add 7-step eligibility checker with honest, non-fabricated results"
git push

echo "Done. Live in a minute or two."

