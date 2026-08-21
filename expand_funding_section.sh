#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

awk '
  /<section id="funding" class="funding-feature reveal">/ {
    print
    print "  <h2>Funding should not be the end of your dream.</h2>"
    print "  <p class=\"section-lead\">Your academic ambition deserves a plan.</p>"
    print "  <p>International education can be a significant investment. Vikanns helps eligible students explore available funding and financing options that may make their academic plans more achievable.</p>"
    print "  <div class=\"funding-grid\">"
    print "    <div class=\"funding-item\"><h3>Study Loan Options</h3><p>We help you understand the study loan routes that may be relevant to your destination and programme.</p></div>"
    print "    <div class=\"funding-item\"><h3>Education Financing</h3><p>Beyond loans, we help you explore other legitimate financing options available to eligible students.</p></div>"
    print "    <div class=\"funding-item\"><h3>Eligibility</h3><p>Funding eligibility depends on the lender or institution\u2019s own criteria \u2014 we help you understand what may apply to your situation.</p></div>"
    print "    <div class=\"funding-item\"><h3>Documentation</h3><p>We guide you through the paperwork typically required to support a funding application, prepared honestly and accurately.</p></div>"
    print "    <div class=\"funding-item\"><h3>Repayment Considerations</h3><p>We encourage you to understand repayment terms fully before committing to any loan or financing option.</p></div>"
    print "    <div class=\"funding-item\"><h3>Proof-of-Funds Requirements</h3><p>Many destinations require evidence of sufficient funds \u2014 we help you understand what this typically involves.</p></div>"
    print "  </div>"
    print "  <p class=\"funding-distinction\">Vikanns provides advisory guidance only. Any loan, financing or funding decision is made independently by the relevant third-party financial institution or lender, not by Vikanns.</p>"
    print "  <div class=\"center-btn\"><a href=\"#contact\" class=\"btn-primary\">Explore Funding Options</a></div>"
    print "  <p class=\"disclaimer-inline center\">Vikanns does not guarantee funding approval. Funding is subject to the requirements and decisions of the relevant financial institution.</p>"
    print "</section>"
    skip=1
    next
  }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Funding section grid ---------------- */
.funding-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 20px; margin: 24px 0; }
.funding-item { background: rgba(255,255,255,0.12); border-radius: 12px; padding: 20px; }
.funding-item h3 { color: var(--white); font-size: 1rem; margin-bottom: 8px; }
.funding-item p { color: rgba(255,255,255,0.9); font-size: 0.9rem; }
.funding-distinction { max-width: 700px; margin: 0 auto 8px; font-size: 0.9rem; color: rgba(255,255,255,0.95); text-align: center; font-weight: 600; }
EOF

echo "--- Verifying ---"
grep -n "funding-grid\|Study Loan Options\|Proof-of-Funds Requirements\|funding-distinction\|does not guarantee funding approval" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Expand Funding section per upgrade brief (Section 8)"
git push

echo "Done. Live in a minute or two."

