#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Building 5 separate destination pages..."

# ---------------------------------------------------------------------------
# Shared CSS for destination pages
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Destination pages ---------------- */
.dest-hero {
  background: linear-gradient(135deg, var(--green), var(--green-dark));
  color: var(--white);
  text-align: center;
  padding: 70px 24px 50px;
}
.flag-icon-lg { width: 72px; height: 52px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.3); display: inline-block; margin-bottom: 16px; }
.dest-hero h1 { font-size: 2.2rem; margin-bottom: 10px; }
.dest-hero p { opacity: 0.95; max-width: 600px; margin: 0 auto; }
.dest-content { max-width: 800px; margin: 0 auto; padding: 50px 24px; }
.dest-content h2 { text-align: left; font-size: 1.3rem; color: var(--green-dark); margin: 34px 0 10px; }
.dest-content h2:first-child { margin-top: 0; }
.dest-content p { color: var(--muted); margin-bottom: 6px; }
EOF

# ---------------------------------------------------------------------------
# Function to write the shared header
# ---------------------------------------------------------------------------
write_header() {
  local file="$1" title="$2" desc="$3" slug="$4"
  cat > "$file" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${title}</title>
<meta name="description" content="${desc}">
<meta name="robots" content="index, follow">
<meta property="og:title" content="${title}">
<meta property="og:description" content="${desc}">
<meta property="og:type" content="website">
<meta property="og:image" content="https://vikanns.com/images/team-green.jpg">
<link rel="canonical" href="https://vikanns.com/${slug}.html">
<link rel="icon" type="image/png" href="images/logo.png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lipis/flag-icons@7.2.3/css/flag-icons.min.css">
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
      <li><a href="index.html#eligibility">Check Eligibility</a></li>
      <li><a href="index.html#about">About Us</a></li>
      <li><a href="index.html#services">Services</a></li>
      <li><a href="index.html#destinations">Destinations</a></li>
      <li><a href="index.html#how-it-works">How It Works</a></li>
      <li><a href="index.html#resources">Resources</a></li>
      <li><a href="index.html#contact">Contact</a></li>
    </ul>
    <a href="index.html#eligibility" class="btn-primary nav-cta">Check My Eligibility</a>
  </nav>
</header>
EOF
}

# ---------------------------------------------------------------------------
# Function to write the shared footer
# ---------------------------------------------------------------------------
write_footer() {
  local file="$1"
  cat >> "$file" << 'EOF'

<footer>
  <div class="footer-grid">
    <div class="footer-col">
      <h3>Vikanns Ltd</h3>
      <p>People. Ideas. Possibilities.</p>
      <p>Creating pathways to education, opportunity and a better future.</p>
    </div>
    <div class="footer-col">
      <h4>Quick Links</h4>
      <a href="index.html#home">Home</a>
      <a href="index.html#about">About Us</a>
      <a href="index.html#services">Services</a>
      <a href="index.html#destinations">Destinations</a>
      <a href="index.html#resources">Resources</a>
      <a href="index.html#contact">Contact</a>
    </div>
    <div class="footer-col">
      <h4>Destinations</h4>
      <a href="uk.html">United Kingdom</a>
      <a href="canada.html">Canada</a>
      <a href="new-zealand.html">New Zealand</a>
      <a href="netherlands.html">Netherlands</a>
      <a href="europe.html">Europe &amp; Beyond</a>
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

<a href="https://wa.me/2347032751486?text=Hello%20Vikanns%2C%20I%27m%20interested%20in%20exploring%20my%20options"
   class="whatsapp-float" target="_blank" rel="noopener" aria-label="Chat with us on WhatsApp">
  <i class="fa-brands fa-whatsapp"></i>
</a>

<script src="script.js"></script>
</body>
</html>
EOF
}

# ---------------------------------------------------------------------------
# 1. UNITED KINGDOM
# ---------------------------------------------------------------------------
write_header "uk.html" "Study in the UK from Nigeria | Vikanns Ltd" "Explore studying in the United Kingdom with guidance from Vikanns Ltd \u2014 admissions, visa preparation, funding and more for Nigerian students." "uk"
cat >> uk.html << 'EOF'
<section class="dest-hero">
  <span class="fi fi-gb flag-icon-lg"></span>
  <h1>Study in the United Kingdom</h1>
  <p>Globally recognised universities and a wide range of undergraduate and postgraduate programmes.</p>
</section>
<section class="dest-content">
  <h2>Why Study Here?</h2>
  <p>The UK is home to a broad mix of long-established and modern universities, with programmes spanning nearly every field of study.</p>

  <h2>Popular Study Areas</h2>
  <p>Business, engineering, health sciences, law, computing and the creative arts are commonly pursued by international students.</p>

  <h2>Typical Programme Options</h2>
  <p>Bachelor's, Master's (including MRes routes), PhD, professional and foundation programmes are available depending on your background.</p>

  <h2>Admission Considerations</h2>
  <p>Admission requirements vary by institution and programme, and generally consider your academic history, references and personal statement.</p>

  <h2>English Language Requirements</h2>
  <p>Most institutions require evidence of English proficiency (such as IELTS), though requirements differ by programme and provider.</p>

  <h2>Tuition Considerations</h2>
  <p>Tuition varies significantly by institution, city and level of study. We help you understand the cost structure for your chosen path.</p>

  <h2>Living Cost Considerations</h2>
  <p>Cost of living varies by city, with London generally higher than other regions. We help you plan realistically for your situation.</p>

  <h2>Visa Information</h2>
  <p>UK study typically requires a student visa route with its own documentation and financial requirements, which we help you prepare for.</p>

  <h2>Work Rights</h2>
  <p>Work entitlements for international students can vary and change over time. We guide you to the current official position for your circumstances.</p>

  <h2>Post-Study Considerations</h2>
  <p>Some graduates may be able to explore post-study options depending on current immigration rules at the time of your graduation.</p>

  <h2>Funding Options</h2>
  <p>We help eligible students explore study loans and other financing routes appropriate for UK study.</p>

  <h2>Important Requirements</h2>
  <p>Requirements can include academic transcripts, proof of funds, a valid passport and other destination-specific documentation.</p>

  <h2>Who This Destination May Suit</h2>
  <p>Students seeking a wide choice of institutions and programmes, and who meet the relevant academic and financial requirements.</p>

  <h2>Application Timeline</h2>
  <p>Timelines vary by institution and intake. We help you plan backward from your target start date.</p>

  <p class="disclaimer-inline center">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</section>
EOF
write_footer "uk.html"

# ---------------------------------------------------------------------------
# 2. CANADA
# ---------------------------------------------------------------------------
write_header "canada.html" "Study in Canada from Nigeria | Vikanns Ltd" "Explore studying in Canada with guidance from Vikanns Ltd \u2014 admissions, visa preparation, funding and vocational pathways for Nigerian students." "canada"
cat >> canada.html << 'EOF'
<section class="dest-hero">
  <span class="fi fi-ca flag-icon-lg"></span>
  <h1>Study in Canada</h1>
  <p>Academic pathways across universities, colleges and selected vocational programmes.</p>
</section>
<section class="dest-content">
  <h2>Why Study Here?</h2>
  <p>Canada offers a wide mix of university and college pathways, including practical vocational routes alongside traditional degrees.</p>

  <h2>Popular Study Areas</h2>
  <p>Business, healthcare-related vocational programmes, engineering, technology and applied sciences are commonly pursued.</p>

  <h2>Typical Programme Options</h2>
  <p>Bachelor's, Master's, diploma and vocational programmes (such as Personal Support Worker routes) are available depending on your profile.</p>

  <h2>Admission Considerations</h2>
  <p>Requirements vary by institution and can include prior qualifications such as SSCE/WAEC results, depending on the programme level.</p>

  <h2>English Language Requirements</h2>
  <p>Most institutions require evidence of English proficiency, with specific requirements varying by programme and provider.</p>

  <h2>Tuition Considerations</h2>
  <p>Tuition varies by institution, province and programme type. We help you understand realistic cost expectations for your chosen path.</p>

  <h2>Living Cost Considerations</h2>
  <p>Living costs vary by province and city. We help you plan with a realistic view of your specific destination within Canada.</p>

  <h2>Visa Information</h2>
  <p>Canadian study typically requires a study permit with its own documentation and financial requirements, which we help you prepare for.</p>

  <h2>Work Rights</h2>
  <p>Work entitlements for international students can vary and change over time. We guide you to the current official position for your circumstances.</p>

  <h2>Post-Study Considerations</h2>
  <p>Some graduates may be able to explore post-graduation options depending on current immigration rules at the time of your graduation.</p>

  <h2>Funding Options</h2>
  <p>We help eligible students explore study loans and other financing routes appropriate for Canadian study.</p>

  <h2>Important Requirements</h2>
  <p>Requirements can include academic transcripts, proof of funds, a valid passport and other destination-specific documentation.</p>

  <h2>Who This Destination May Suit</h2>
  <p>Students interested in both traditional degrees and practical vocational pathways, who meet the relevant requirements.</p>

  <h2>Application Timeline</h2>
  <p>Timelines vary by institution and intake. We help you plan backward from your target start date.</p>

  <p class="disclaimer-inline center">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</section>
EOF
write_footer "canada.html"

# ---------------------------------------------------------------------------
# 3. NEW ZEALAND
# ---------------------------------------------------------------------------
write_header "new-zealand.html" "Study in New Zealand from Nigeria | Vikanns Ltd" "Explore studying in New Zealand with guidance from Vikanns Ltd \u2014 admissions, visa preparation and funding for Nigerian students." "new-zealand"
cat >> new-zealand.html << 'EOF'
<section class="dest-hero">
  <span class="fi fi-nz flag-icon-lg"></span>
  <h1>Study in New Zealand</h1>
  <p>Welcoming universities and institutes known for research, innovation and quality of life.</p>
</section>
<section class="dest-content">
  <h2>Why Study Here?</h2>
  <p>New Zealand is known for a supportive study environment, quality institutions and a strong emphasis on research and practical learning.</p>

  <h2>Popular Study Areas</h2>
  <p>Agriculture, environmental science, business, engineering and health-related fields are commonly pursued by international students.</p>

  <h2>Typical Programme Options</h2>
  <p>Bachelor's, Master's, PhD and vocational/certificate programmes are available depending on your background and goals.</p>

  <h2>Admission Considerations</h2>
  <p>Admission requirements vary by institution and programme, generally considering your academic history and chosen field.</p>

  <h2>English Language Requirements</h2>
  <p>Most institutions require evidence of English proficiency, with specific requirements varying by programme and provider.</p>

  <h2>Tuition Considerations</h2>
  <p>Tuition varies by institution and programme. We help you understand realistic cost expectations for your chosen path.</p>

  <h2>Living Cost Considerations</h2>
  <p>Living costs vary by city and lifestyle. We help you plan with a realistic view for your specific situation.</p>

  <h2>Visa Information</h2>
  <p>Study in New Zealand typically requires a student visa with its own documentation and financial requirements, which we help you prepare for.</p>

  <h2>Work Rights</h2>
  <p>Work entitlements for international students can vary and change over time. We guide you to the current official position for your circumstances.</p>

  <h2>Post-Study Considerations</h2>
  <p>Some graduates may be able to explore post-study options depending on current immigration rules at the time of your graduation.</p>

  <h2>Funding Options</h2>
  <p>We help eligible students explore study loans and other financing routes appropriate for study in New Zealand.</p>

  <h2>Important Requirements</h2>
  <p>Requirements can include academic transcripts, proof of funds, a valid passport and other destination-specific documentation.</p>

  <h2>Who This Destination May Suit</h2>
  <p>Students who value a smaller, supportive study environment and meet the relevant academic and financial requirements.</p>

  <h2>Application Timeline</h2>
  <p>Timelines vary by institution and intake. We help you plan backward from your target start date.</p>

  <p class="disclaimer-inline center">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</section>
EOF
write_footer "new-zealand.html"

# ---------------------------------------------------------------------------
# 4. NETHERLANDS
# ---------------------------------------------------------------------------
write_header "netherlands.html" "Study in the Netherlands from Nigeria | Vikanns Ltd" "Explore studying in the Netherlands with guidance from Vikanns Ltd \u2014 admissions, visa preparation and funding for Nigerian students." "netherlands"
cat >> netherlands.html << 'EOF'
<section class="dest-hero">
  <span class="fi fi-nl flag-icon-lg"></span>
  <h1>Study in the Netherlands</h1>
  <p>Innovative institutions and internationally focused programmes across a range of disciplines.</p>
</section>
<section class="dest-content">
  <h2>Why Study Here?</h2>
  <p>The Netherlands offers a large number of English-taught programmes and an internationally-minded academic environment.</p>

  <h2>Popular Study Areas</h2>
  <p>Business, engineering, data science, design and international relations are commonly pursued by international students.</p>

  <h2>Typical Programme Options</h2>
  <p>Bachelor's, Master's and PhD programmes are available, with many taught fully in English.</p>

  <h2>Admission Considerations</h2>
  <p>Admission requirements vary by institution and programme, generally considering your academic history and chosen field.</p>

  <h2>English Language Requirements</h2>
  <p>Most English-taught programmes require evidence of English proficiency, with requirements varying by institution.</p>

  <h2>Tuition Considerations</h2>
  <p>Tuition varies by institution and programme. We help you understand realistic cost expectations for your chosen path.</p>

  <h2>Living Cost Considerations</h2>
  <p>Living costs vary by city. We help you plan with a realistic view for your specific situation.</p>

  <h2>Visa Information</h2>
  <p>Study in the Netherlands typically requires a residence permit process with its own documentation and financial requirements, which we help you prepare for.</p>

  <h2>Work Rights</h2>
  <p>Work entitlements for international students can vary and change over time. We guide you to the current official position for your circumstances.</p>

  <h2>Post-Study Considerations</h2>
  <p>Some graduates may be able to explore post-study options depending on current immigration rules at the time of your graduation.</p>

  <h2>Funding Options</h2>
  <p>We help eligible students explore study loans and other financing routes appropriate for study in the Netherlands.</p>

  <h2>Important Requirements</h2>
  <p>Requirements can include academic transcripts, proof of funds, a valid passport and other destination-specific documentation.</p>

  <h2>Who This Destination May Suit</h2>
  <p>Students who want an English-taught programme in a compact, internationally connected country, and who meet the relevant requirements.</p>

  <h2>Application Timeline</h2>
  <p>Timelines vary by institution and intake. We help you plan backward from your target start date.</p>

  <p class="disclaimer-inline center">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</section>
EOF
write_footer "netherlands.html"

# ---------------------------------------------------------------------------
# 5. EUROPE & BEYOND
# ---------------------------------------------------------------------------
write_header "europe.html" "Study in Europe from Nigeria | Vikanns Ltd" "Explore study opportunities across Europe with guidance from Vikanns Ltd \u2014 admissions, visa preparation and funding for Nigerian students." "europe"
cat >> europe.html << 'EOF'
<section class="dest-hero">
  <span class="fi fi-eu flag-icon-lg"></span>
  <h1>Europe &amp; Beyond</h1>
  <p>Suitable opportunities across selected European and other international destinations.</p>
</section>
<section class="dest-content">
  <h2>Why Study Here?</h2>
  <p>Beyond the UK and Netherlands, several European countries and other destinations offer distinct academic and cultural opportunities.</p>

  <h2>Popular Study Areas</h2>
  <p>Available fields vary by country and institution; we help you identify options that align with your goals.</p>

  <h2>Typical Programme Options</h2>
  <p>Bachelor's, Master's, PhD and vocational programmes may be available depending on the specific destination.</p>

  <h2>Admission Considerations</h2>
  <p>Admission requirements vary widely by country and institution, generally considering your academic history and chosen field.</p>

  <h2>English Language Requirements</h2>
  <p>Requirements vary by destination and programme \u2014 some are taught in English, others may require the local language.</p>

  <h2>Tuition Considerations</h2>
  <p>Tuition varies significantly across destinations. We help you understand realistic cost expectations for your chosen path.</p>

  <h2>Living Cost Considerations</h2>
  <p>Living costs vary by country and city. We help you plan with a realistic view for your specific situation.</p>

  <h2>Visa Information</h2>
  <p>Visa or residence permit requirements vary by destination, and we help you prepare according to the specific country's process.</p>

  <h2>Work Rights</h2>
  <p>Work entitlements for international students vary by country and change over time. We guide you to the current official position.</p>

  <h2>Post-Study Considerations</h2>
  <p>Post-study options depend on the specific country and current immigration rules at the time of your graduation.</p>

  <h2>Funding Options</h2>
  <p>We help eligible students explore study loans and other financing routes appropriate for their chosen destination.</p>

  <h2>Important Requirements</h2>
  <p>Requirements can include academic transcripts, proof of funds, a valid passport and other destination-specific documentation.</p>

  <h2>Who This Destination May Suit</h2>
  <p>Students open to exploring options beyond the most common destinations, who meet the relevant requirements for their chosen country.</p>

  <h2>Application Timeline</h2>
  <p>Timelines vary widely by country and institution. We help you plan backward from your target start date.</p>

  <p class="disclaimer-inline center">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</section>
EOF
write_footer "europe.html"

# ---------------------------------------------------------------------------
# Link the homepage destination cards to the new pages
# ---------------------------------------------------------------------------
sed -i \
  -e '0,/<h3><span class="fi fi-gb flag-icon"><\/span> United Kingdom<\/h3>/! b' \
  index.html 2>/dev/null || true

python3 --version >/dev/null 2>&1 || true

awk '
  /Explore UK Options<\/a>/ { gsub(/href="#contact"/, "href=\"uk.html\""); print; next }
  /Explore Canada Options<\/a>/ { gsub(/href="#contact"/, "href=\"canada.html\""); print; next }
  /Explore Netherlands Options<\/a>/ { gsub(/href="#contact"/, "href=\"netherlands.html\""); print; next }
  /Explore New Zealand Options<\/a>/ { gsub(/href="#contact"/, "href=\"new-zealand.html\""); print; next }
  /Explore Available Destinations<\/a>/ { gsub(/href="#contact"/, "href=\"europe.html\""); print; next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# ---------------------------------------------------------------------------
# Update sitemap.xml with the 5 new pages
# ---------------------------------------------------------------------------
cat > sitemap.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://vikanns.com/</loc><priority>1.0</priority></url>
  <url><loc>https://vikanns.com/uk.html</loc><priority>0.8</priority></url>
  <url><loc>https://vikanns.com/canada.html</loc><priority>0.8</priority></url>
  <url><loc>https://vikanns.com/new-zealand.html</loc><priority>0.8</priority></url>
  <url><loc>https://vikanns.com/netherlands.html</loc><priority>0.8</priority></url>
  <url><loc>https://vikanns.com/europe.html</loc><priority>0.8</priority></url>
</urlset>
EOF

echo "--- Verifying ---"
ls -la uk.html canada.html new-zealand.html netherlands.html europe.html
grep -n "uk.html\|canada.html\|netherlands.html\|new-zealand.html\|europe.html" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add 5 separate destination pages (UK, Canada, New Zealand, Netherlands, Europe) with full SEO metadata"
git push

echo ""
echo "Done. Live in a minute or two at e.g. https://vikanns.com/uk.html"

