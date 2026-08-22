#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Building 7 legal pages..."

write_header() {
  local file="$1" title="$2" slug="$3"
  cat > "$file" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title} | Vikanns Ltd</title>
<meta name="robots" content="noindex, follow">
<link rel="canonical" href="https://vikanns.com/${slug}.html">
<link rel="icon" type="image/png" href="images/logo.png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="style.css">
</head>
<body>
<header>
  <nav class="navbar">
    <div class="logo">
      <a href="index.html" style="display:flex;align-items:center;gap:10px;text-decoration:none;">
        <img src="images/logo.png" alt="Vikanns Ltd logo" class="logo-img"><span class="logo-text">Vikanns Ltd</span>
      </a>
    </div>
    <button class="menu-toggle" aria-label="Toggle navigation menu" onclick="toggleMenu()">&#9776;</button>
    <ul class="nav-links" id="navLinks">
      <li><a href="index.html#home">Home</a></li>
      <li><a href="index.html#contact">Contact</a></li>
    </ul>
    <a href="index.html#eligibility" class="btn-primary nav-cta">Check My Eligibility</a>
  </nav>
</header>
<article class="article-page">
EOF
}

write_footer() {
  local file="$1"
  cat >> "$file" << 'EOF'
</article>
<footer>
  <div class="footer-grid">
    <div class="footer-col">
      <h3>Vikanns Ltd</h3>
      <p>People. Ideas. Possibilities.</p>
    </div>
    <div class="footer-col">
      <h4>Quick Links</h4>
      <a href="index.html#home">Home</a>
      <a href="index.html#services">Services</a>
      <a href="index.html#contact">Contact</a>
    </div>
    <div class="footer-col">
      <h4>Legal</h4>
      <a href="privacy-policy.html">Privacy Policy</a>
      <a href="terms.html">Terms &amp; Conditions</a>
      <a href="cookie-policy.html">Cookie Policy</a>
      <a href="disclaimer.html">Disclaimer</a>
      <a href="refund-policy.html">Refund/Cancellation Policy</a>
      <a href="funding-disclaimer.html">Funding Disclaimer</a>
      <a href="visa-disclaimer.html">Visa Disclaimer</a>
    </div>
    <div class="footer-col">
      <h4>Contact</h4>
      <p>Abuja, Nigeria</p>
      <p>+234 703 275 1486</p>
      <p>+234 816 384 8822</p>
    </div>
  </div>
  <p class="footer-disclaimer">Vikanns Ltd provides education, advisory and application support services. We do not guarantee admission, visa approval, funding approval or any immigration outcome. Final decisions are made by the relevant educational institutions, financial institutions and government authorities.</p>
  <p class="footer-copyright">&copy; <span id="year"></span> Vikanns Ltd. All rights reserved.</p>
</footer>
<a href="https://wa.me/2347032751486" class="whatsapp-float" target="_blank" rel="noopener" aria-label="Chat With Vikanns"><i class="fa-brands fa-whatsapp"></i></a>
<script src="script.js"></script>
</body>
</html>
EOF
}

# ---------------------------------------------------------------------------
# 1. PRIVACY POLICY
# ---------------------------------------------------------------------------
write_header "privacy-policy.html" "Privacy Policy" "privacy-policy"
cat >> privacy-policy.html << 'EOF'
  <h1>Privacy Policy</h1>
  <p>Vikanns Ltd ("we", "us", "our") respects your privacy. This policy explains what information we collect and how we use it.</p>

  <h2>Information We Collect</h2>
  <p>When you use our contact form, eligibility checker, or consultation booking, we may collect your name, email, phone/WhatsApp number, academic background, and information about your study goals.</p>

  <h2>How We Use It</h2>
  <p>We use this information solely to respond to your enquiry and provide advisory services related to study abroad, admissions, visa guidance, and funding.</p>

  <h2>Third-Party Processing</h2>
  <p>Form submissions on this site are processed through Formspree, a third-party form-handling service, which delivers your message to us by email. We do not sell or share your information with unrelated third parties.</p>

  <h2>Your Rights</h2>
  <p>You may request access to, correction of, or deletion of your personal information at any time by contacting us directly.</p>

  <h2>Contact</h2>
  <p>For privacy questions, reach us via the contact details on our <a href="index.html#contact">Contact page</a>.</p>
EOF
write_footer "privacy-policy.html"

# ---------------------------------------------------------------------------
# 2. TERMS & CONDITIONS
# ---------------------------------------------------------------------------
write_header "terms.html" "Terms & Conditions" "terms"
cat >> terms.html << 'EOF'
  <h1>Terms &amp; Conditions</h1>
  <p>By using this website, you agree to the following terms.</p>

  <h2>Our Services</h2>
  <p>Vikanns Ltd provides education, advisory and application support services. We do not guarantee admission, visa approval, funding approval, or any immigration outcome. Final decisions are made by the relevant educational institutions, financial institutions and government authorities.</p>

  <h2>Website Content</h2>
  <p>All content on this website, including text, graphics and logos, belongs to Vikanns Ltd unless otherwise stated, and may not be reproduced without permission.</p>

  <h2>Accuracy of Information</h2>
  <p>We aim to keep information on this site accurate and current, but requirements for destinations, visas and funding change over time. Always confirm current requirements with the relevant institution or authority.</p>

  <h2>Limitation of Liability</h2>
  <p>Vikanns Ltd is not liable for decisions made by third-party institutions, lenders or government authorities, or for outcomes outside our direct control.</p>

  <h2>Changes to These Terms</h2>
  <p>We may update these terms from time to time. Continued use of the site after changes indicates acceptance of the updated terms.</p>
EOF
write_footer "terms.html"

# ---------------------------------------------------------------------------
# 3. COOKIE POLICY
# ---------------------------------------------------------------------------
write_header "cookie-policy.html" "Cookie Policy" "cookie-policy"
cat >> cookie-policy.html << 'EOF'
  <h1>Cookie Policy</h1>
  <p>This site uses a minimal number of cookies and third-party resources.</p>

  <h2>What We Use</h2>
  <ul>
    <li>Fonts and icons loaded from external content delivery networks (Font Awesome, flag-icons)</li>
    <li>Formspree, our third-party form processor, which may set its own cookies when you submit a form</li>
  </ul>

  <h2>What We Don't Do</h2>
  <p>We do not currently use advertising or tracking cookies on this site.</p>

  <h2>Managing Cookies</h2>
  <p>You can control or delete cookies through your browser settings at any time.</p>
EOF
write_footer "cookie-policy.html"

# ---------------------------------------------------------------------------
# 4. DISCLAIMER
# ---------------------------------------------------------------------------
write_header "disclaimer.html" "Disclaimer" "disclaimer"
cat >> disclaimer.html << 'EOF'
  <h1>Disclaimer</h1>
  <p>The information on this website is provided for general guidance only.</p>

  <h2>No Guaranteed Outcomes</h2>
  <p>Vikanns Ltd does not guarantee admission, visa approval, funding approval, or any immigration outcome. Final decisions rest solely with the relevant educational institutions, financial institutions and government authorities.</p>

  <h2>General Information</h2>
  <p>Content on this site, including destination pages and articles, is general in nature and may not reflect the most current requirements. Always verify current requirements with the relevant institution or government authority before making decisions.</p>

  <h2>No Professional Advice</h2>
  <p>Nothing on this site constitutes legal, financial or immigration advice. For specific guidance, speak directly with our team.</p>
EOF
write_footer "disclaimer.html"

# ---------------------------------------------------------------------------
# 5. REFUND / CANCELLATION POLICY
# ---------------------------------------------------------------------------
write_header "refund-policy.html" "Refund/Cancellation Policy" "refund-policy"
cat >> refund-policy.html << 'EOF'
  <h1>Refund / Cancellation Policy</h1>
  <p>Refund and cancellation terms depend on the specific service engaged and are agreed individually with each client before work begins.</p>

  <h2>Before You Commit</h2>
  <p>We encourage you to ask about applicable refund or cancellation terms for your specific service before making any payment, so expectations are clear from the start.</p>

  <h2>Third-Party Fees</h2>
  <p>Some costs (such as institution application fees or visa fees) are paid to third parties and are governed by that third party's own refund policy, not ours.</p>

  <h2>Questions</h2>
  <p>Contact us directly for the specific terms applicable to your engagement.</p>
EOF
write_footer "refund-policy.html"

# ---------------------------------------------------------------------------
# 6. FUNDING DISCLAIMER
# ---------------------------------------------------------------------------
write_header "funding-disclaimer.html" "Funding Disclaimer" "funding-disclaimer"
cat >> funding-disclaimer.html << 'EOF'
  <h1>Funding Disclaimer</h1>
  <p>Vikanns Ltd provides advisory guidance on education funding options. We are not a lender.</p>

  <h2>No Guaranteed Approval</h2>
  <p>Vikanns does not guarantee funding approval. Any loan, financing or funding decision is made independently by the relevant third-party financial institution, based on their own eligibility criteria and terms.</p>

  <h2>Our Role</h2>
  <p>We help you understand available options, documentation and eligibility considerations. We do not control lender decisions, interest rates, or repayment terms.</p>
EOF
write_footer "funding-disclaimer.html"

# ---------------------------------------------------------------------------
# 7. VISA DISCLAIMER
# ---------------------------------------------------------------------------
write_header "visa-disclaimer.html" "Visa Disclaimer" "visa-disclaimer"
cat >> visa-disclaimer.html << 'EOF'
  <h1>Visa Disclaimer</h1>
  <p>Vikanns Ltd provides guidance and application support for student visas. We are not a government authority.</p>

  <h2>No Guaranteed Approval</h2>
  <p>Visa decisions are made solely by the relevant government authority. We do not guarantee visa approval under any circumstances.</p>

  <h2>Our Role</h2>
  <p>We help you understand typical requirements and prepare a complete, well-organised application. Requirements change over time \u2014 always confirm current requirements with the relevant government authority.</p>
EOF
write_footer "visa-disclaimer.html"

# ---------------------------------------------------------------------------
# Add the Legal column to the homepage footer
# ---------------------------------------------------------------------------
awk '
  /<h4>Contact<\/h4>/ && !inserted {
    print "    <div class=\"footer-col\">"
    print "      <h4>Legal</h4>"
    print "      <a href=\"privacy-policy.html\">Privacy Policy</a>"
    print "      <a href=\"terms.html\">Terms &amp; Conditions</a>"
    print "      <a href=\"cookie-policy.html\">Cookie Policy</a>"
    print "      <a href=\"disclaimer.html\">Disclaimer</a>"
    print "      <a href=\"refund-policy.html\">Refund/Cancellation Policy</a>"
    print "      <a href=\"funding-disclaimer.html\">Funding Disclaimer</a>"
    print "      <a href=\"visa-disclaimer.html\">Visa Disclaimer</a>"
    print "    </div>"
    print "    <div class=\"footer-col\">"
    print "      <h4>Contact</h4>"
    inserted=1
    next
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

echo "--- Verifying ---"
ls -la privacy-policy.html terms.html cookie-policy.html disclaimer.html refund-policy.html funding-disclaimer.html visa-disclaimer.html
grep -c "footer-col" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add 7 legal pages and link them from the footer (Section 16)"
git push

echo ""
echo "Done. Live in a minute or two."

