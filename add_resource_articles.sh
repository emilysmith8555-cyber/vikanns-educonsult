#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Building 6 Resource Centre article pages..."

# ---------------------------------------------------------------------------
# Shared header/footer functions (same pattern as the destination pages)
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
<meta property="og:type" content="article">
<meta property="og:image" content="https://vikanns.com/images/team-green.jpg">
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
      <li><a href="index.html#eligibility">Check Eligibility</a></li>
      <li><a href="index.html#services">Services</a></li>
      <li><a href="index.html#destinations">Destinations</a></li>
      <li><a href="index.html#resources">Resources</a></li>
      <li><a href="index.html#contact">Contact</a></li>
    </ul>
    <a href="index.html#eligibility" class="btn-primary nav-cta">Check My Eligibility</a>
  </nav>
</header>
EOF
}

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

write_article_meta() {
  local category="$1" date="$2" readtime="$3" title="$4"
  cat << EOF
<article class="article-page">
  <div class="article-meta">
    <span class="article-category">${category}</span>
    <span class="article-date">${date}</span>
    <span class="article-readtime">${readtime} read</span>
  </div>
  <h1>${title}</h1>
EOF
}

cat >> style.css << 'EOF'

/* ---------------- Article pages ---------------- */
.article-page { max-width: 760px; margin: 0 auto; padding: 50px 24px; }
.article-meta { display: flex; gap: 12px; align-items: center; margin-bottom: 14px; font-size: 0.82rem; flex-wrap: wrap; }
.article-category { background: var(--green); color: var(--white); padding: 4px 12px; border-radius: 20px; font-weight: 700; }
.article-date, .article-readtime { color: var(--muted); }
.article-page h1 { font-size: 1.9rem; color: var(--green-dark); margin-bottom: 24px; }
.article-page h2 { font-size: 1.2rem; color: var(--green-dark); margin: 28px 0 8px; }
.article-page p { color: var(--muted); margin-bottom: 8px; }
.article-page ul { margin: 0 0 12px 20px; color: var(--muted); }
.article-page li { margin-bottom: 4px; }

/* ---------------- Resource cards with metadata ---------------- */
.resource-card-meta { display: flex; gap: 8px; font-size: 0.75rem; color: var(--muted); margin-bottom: 8px; flex-wrap: wrap; }
.resource-card-meta .article-category { font-size: 0.7rem; padding: 3px 10px; }
EOF

# ---------------------------------------------------------------------------
# ARTICLE 1 — How to Choose the Right Country to Study Abroad
# ---------------------------------------------------------------------------
write_header "how-to-choose-country.html" "How to Choose the Right Country to Study Abroad | Vikanns Ltd" "A practical guide to weighing budget, academics, language and post-study goals when choosing where to study abroad." "how-to-choose-country"
write_article_meta "Study Abroad" "2026" "5 min" "How to Choose the Right Country to Study Abroad" >> how-to-choose-country.html
cat >> how-to-choose-country.html << 'EOF'
  <p>Choosing where to study is just as important as choosing what to study. The right country for one student may not be the right one for another \u2014 it depends on your goals, budget and circumstances.</p>

  <h2>Start With Your Budget</h2>
  <p>Tuition and living costs vary significantly across countries and even across cities within the same country. Be honest about what you can realistically afford before falling in love with a particular destination.</p>

  <h2>Consider Your Field of Study</h2>
  <p>Some countries have stronger reputations or more programme options in specific fields. Research which destinations genuinely support your intended area of study, rather than choosing based on popularity alone.</p>

  <h2>Language Requirements</h2>
  <p>Some destinations teach primarily in English, others may require additional language study. Factor this into your timeline and preparation.</p>

  <h2>Think About Life After Graduation</h2>
  <p>Consider what you want your life to look like after your studies \u2014 whether that means returning home, working abroad, or something else \u2014 and how each destination's rules and opportunities align with that.</p>

  <h2>Talk It Through</h2>
  <p>There is rarely one "correct" answer. Speaking with an adviser who can weigh your specific academic background, budget and goals together often makes the decision much clearer.</p>

  <p class="disclaimer-inline">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</article>
EOF
write_footer "how-to-choose-country.html"

# ---------------------------------------------------------------------------
# ARTICLE 2 — UK vs New Zealand for Nigerian Students
# ---------------------------------------------------------------------------
write_header "uk-vs-new-zealand.html" "UK vs New Zealand for Nigerian Students | Vikanns Ltd" "A balanced comparison of studying in the UK versus New Zealand, to help Nigerian students think through the choice." "uk-vs-new-zealand"
write_article_meta "Destinations" "2026" "6 min" "UK vs New Zealand for Nigerian Students" >> uk-vs-new-zealand.html
cat >> uk-vs-new-zealand.html << 'EOF'
  <p>Both the UK and New Zealand are popular destinations for Nigerian students, but they offer quite different experiences. Here is a balanced look at how they compare.</p>

  <h2>Academic Landscape</h2>
  <p>The UK has a very large number of universities and an extremely wide range of programmes across nearly every field. New Zealand has fewer institutions overall, with a strong research and practical-learning focus.</p>

  <h2>Cost Considerations</h2>
  <p>Both tuition and living costs vary by city and institution in each country. Rather than assuming one is cheaper than the other, it is worth comparing specific programmes and cities directly.</p>

  <h2>Visa Pathways</h2>
  <p>Each country has its own distinct student visa process, with its own documentation and financial requirements. These can and do change over time, so always confirm current requirements directly with official sources.</p>

  <h2>Lifestyle and Environment</h2>
  <p>The UK offers dense, historic cities with a fast pace of life in many areas. New Zealand is generally known for a quieter, more nature-oriented environment. Which suits you depends entirely on your own preferences.</p>

  <h2>Which Might Suit You?</h2>
  <p>If you're drawn to a huge range of programme choices and a fast-paced environment, the UK may appeal. If you prefer a smaller, closely-knit academic community with an emphasis on research and practical skills, New Zealand may be worth a closer look.</p>

  <p class="disclaimer-inline">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</article>
EOF
write_footer "uk-vs-new-zealand.html"

# ---------------------------------------------------------------------------
# ARTICLE 3 — How Education Funding Works
# ---------------------------------------------------------------------------
write_header "how-education-funding-works.html" "How Education Funding Works | Vikanns Ltd" "An honest overview of how education funding, study loans and financing generally work for international students." "how-education-funding-works"
write_article_meta "Funding" "2026" "5 min" "How Education Funding Works" >> how-education-funding-works.html
cat >> how-education-funding-works.html << 'EOF'
  <p>Funding is often the single biggest question for students planning to study abroad. Here is a clear, honest overview of how it generally works.</p>

  <h2>Personal and Family Funding</h2>
  <p>Many students fund their education through personal or family savings, sometimes combined with other sources. This remains the most straightforward path where it's available.</p>

  <h2>Study Loans</h2>
  <p>Study loans are offered by third-party financial institutions, not by Vikanns directly. Each lender has its own eligibility criteria, interest terms and repayment conditions \u2014 these should be read and understood carefully before committing.</p>

  <h2>Scholarships and Institutional Support</h2>
  <p>Some institutions offer scholarships or bursaries, though availability and eligibility vary widely by programme and destination.</p>

  <h2>What Vikanns Does \u2014 and Doesn't \u2014 Do</h2>
  <p>Vikanns provides advisory guidance to help you understand and navigate your funding options. We do not lend money ourselves, and any loan or financing decision is made independently by the relevant financial institution, not by us.</p>

  <h2>Getting Started</h2>
  <p>The clearest first step is an honest conversation about your budget and options \u2014 this shapes which destinations and programmes are realistically achievable for you.</p>

  <p class="disclaimer-inline">Vikanns does not guarantee funding approval. Funding is subject to the requirements and decisions of the relevant financial institution.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</article>
EOF
write_footer "how-education-funding-works.html"

# ---------------------------------------------------------------------------
# ARTICLE 4 — Understanding Proof of Funds
# ---------------------------------------------------------------------------
write_header "understanding-proof-of-funds.html" "Understanding Proof of Funds | Vikanns Ltd" "What proof of funds means, why it's required, and common mistakes to avoid when preparing your documentation." "understanding-proof-of-funds"
write_article_meta "Funding" "2026" "4 min" "Understanding Proof of Funds" >> understanding-proof-of-funds.html
cat >> understanding-proof-of-funds.html << 'EOF'
  <p>Proof of funds is one of the most commonly misunderstood parts of a study abroad application. Here's what it actually means.</p>

  <h2>What It Means</h2>
  <p>Proof of funds is documented evidence that you, or your sponsor, have enough money to cover your tuition and living costs for a defined period. It reassures institutions and immigration authorities that you can support yourself.</p>

  <h2>Why It's Required</h2>
  <p>Institutions and governments want confidence that students won't face financial hardship partway through their studies, which could affect both the student and the institution.</p>

  <h2>What Counts as Legitimate Evidence</h2>
  <p>This typically includes bank statements, sponsor letters and other financial documentation \u2014 exact requirements vary by destination, so always confirm the specifics for your chosen country and institution.</p>

  <h2>Common Mistakes</h2>
  <ul>
    <li>Submitting statements that don't cover the required time period</li>
    <li>Unclear or undocumented source of funds</li>
    <li>Inconsistent information between sponsor and applicant documents</li>
    <li>Waiting until the last minute to gather documentation</li>
  </ul>

  <h2>Our Approach</h2>
  <p>We help you understand what's genuinely required and how to present your documentation clearly and honestly. We do not manufacture, create, falsify or artificially arrange financial evidence \u2014 only legitimate documentation is ever appropriate.</p>

  <p class="disclaimer-inline">Requirements and availability may change. Always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</article>
EOF
write_footer "understanding-proof-of-funds.html"

# ---------------------------------------------------------------------------
# ARTICLE 5 — How to Prepare for a Student Visa
# ---------------------------------------------------------------------------
write_header "how-to-prepare-for-student-visa.html" "How to Prepare for a Student Visa | Vikanns Ltd" "Practical steps for preparing a strong, well-organised student visa application." "how-to-prepare-for-student-visa"
write_article_meta "Visa" "2026" "5 min" "How to Prepare for a Student Visa" >> how-to-prepare-for-student-visa.html
cat >> how-to-prepare-for-student-visa.html << 'EOF'
  <p>A well-prepared visa application is one of the most important parts of your study abroad journey. Here's how to approach it.</p>

  <h2>Start Early</h2>
  <p>Visa processing times vary and can take longer than expected. Starting your preparation as early as possible reduces stress and avoids rushed mistakes.</p>

  <h2>Gather the Right Documents</h2>
  <p>Common requirements include your offer letter, passport, proof of funds, academic transcripts and English language test results \u2014 though the exact list depends on your destination.</p>

  <h2>Understand the Financial Requirements</h2>
  <p>Most student visas require evidence that you can cover your costs. Make sure your financial documentation is complete, accurate and consistent before submission.</p>

  <h2>Prepare for an Interview, If Required</h2>
  <p>Some visa processes include an interview. Being able to clearly explain your study plans, why you chose your institution, and your intentions helps demonstrate genuine intent.</p>

  <h2>Avoid Common Mistakes</h2>
  <ul>
    <li>Submitting incomplete documentation</li>
    <li>Inconsistent information across different documents</li>
    <li>Leaving preparation until the last minute</li>
    <li>Not understanding the specific requirements of your destination country</li>
  </ul>

  <p class="disclaimer-inline">We do not guarantee visa outcomes. Instead, we help you understand the requirements and prepare a complete, well-organised application. Requirements and availability may change \u2014 always confirm current requirements with the relevant institution and government authority.</p>
  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</article>
EOF
write_footer "how-to-prepare-for-student-visa.html"

# ---------------------------------------------------------------------------
# ARTICLE 6 — How to Choose the Right Course
# ---------------------------------------------------------------------------
write_header "how-to-choose-the-right-course.html" "How to Choose the Right Course | Vikanns Ltd" "How to think through choosing a course that fits your interests, strengths and long-term goals." "how-to-choose-the-right-course"
write_article_meta "Career & Academic" "2026" "4 min" "How to Choose the Right Course" >> how-to-choose-the-right-course.html
cat >> how-to-choose-the-right-course.html << 'EOF'
  <p>Choosing a course is a decision that shapes years of your life \u2014 it deserves more thought than picking whatever is available or popular.</p>

  <h2>Start With Your Interests</h2>
  <p>You are far more likely to succeed in a field you're genuinely curious about, rather than one chosen only because it seems impressive or in demand.</p>

  <h2>Consider Your Strengths</h2>
  <p>Be honest about your academic strengths. A course that plays to what you're naturally good at tends to be more sustainable over several years of study.</p>

  <h2>Think About Long-Term Direction</h2>
  <p>Consider where you'd like your career to go, and whether a specific course genuinely supports that direction \u2014 rather than assuming any degree will automatically lead somewhere good.</p>

  <h2>Understand the Course Structure</h2>
  <p>Look closely at what a programme actually involves \u2014 modules, practical components, and how it's assessed \u2014 rather than judging purely by its title.</p>

  <h2>Get a Second Opinion</h2>
  <p>Talking it through with someone who can see your whole picture \u2014 academic background, budget, destination options and goals together \u2014 often reveals options you hadn't considered.</p>

  <div class="center-btn"><a href="index.html#eligibility" class="btn-primary">Check My Eligibility</a></div>
</article>
EOF
write_footer "how-to-choose-the-right-course.html"

# ---------------------------------------------------------------------------
# Update the homepage Resources section with real article cards
# ---------------------------------------------------------------------------
awk '
  /<section id="resources" class="resources reveal">/ {
    print
    print "  <h2>Vikanns Resources</h2>"
    print "  <p class=\"section-lead\">Information that helps you make better decisions. International education involves major decisions. Our resources are designed to help students and families understand their options before making them.</p>"
    print "  <div class=\"resource-grid\">"
    print "    <div class=\"resource-card\"><div class=\"resource-card-meta\"><span class=\"article-category\">Study Abroad</span><span>5 min read</span></div><h3>How to Choose the Right Country to Study Abroad</h3><p>Weighing budget, academics, language and post-study goals.</p><a href=\"how-to-choose-country.html\" class=\"btn-outline\">Read More</a></div>"
    print "    <div class=\"resource-card\"><div class=\"resource-card-meta\"><span class=\"article-category\">Destinations</span><span>6 min read</span></div><h3>UK vs New Zealand for Nigerian Students</h3><p>A balanced comparison to help you think through the choice.</p><a href=\"uk-vs-new-zealand.html\" class=\"btn-outline\">Read More</a></div>"
    print "    <div class=\"resource-card\"><div class=\"resource-card-meta\"><span class=\"article-category\">Funding</span><span>5 min read</span></div><h3>How Education Funding Works</h3><p>An honest overview of loans, financing and eligibility.</p><a href=\"how-education-funding-works.html\" class=\"btn-outline\">Read More</a></div>"
    print "    <div class=\"resource-card\"><div class=\"resource-card-meta\"><span class=\"article-category\">Funding</span><span>4 min read</span></div><h3>Understanding Proof of Funds</h3><p>What it means, why it matters, and common mistakes.</p><a href=\"understanding-proof-of-funds.html\" class=\"btn-outline\">Read More</a></div>"
    print "    <div class=\"resource-card\"><div class=\"resource-card-meta\"><span class=\"article-category\">Visa</span><span>5 min read</span></div><h3>How to Prepare for a Student Visa</h3><p>Practical steps for a strong, well-organised application.</p><a href=\"how-to-prepare-for-student-visa.html\" class=\"btn-outline\">Read More</a></div>"
    print "    <div class=\"resource-card\"><div class=\"resource-card-meta\"><span class=\"article-category\">Career &amp; Academic</span><span>4 min read</span></div><h3>How to Choose the Right Course</h3><p>Thinking through interests, strengths and long-term goals.</p><a href=\"how-to-choose-the-right-course.html\" class=\"btn-outline\">Read More</a></div>"
    print "  </div>"
    print "</section>"
    skip=1
    next
  }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# ---------------------------------------------------------------------------
# Update sitemap.xml with the 6 new article pages
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
  <url><loc>https://vikanns.com/how-to-choose-country.html</loc><priority>0.7</priority></url>
  <url><loc>https://vikanns.com/uk-vs-new-zealand.html</loc><priority>0.7</priority></url>
  <url><loc>https://vikanns.com/how-education-funding-works.html</loc><priority>0.7</priority></url>
  <url><loc>https://vikanns.com/understanding-proof-of-funds.html</loc><priority>0.7</priority></url>
  <url><loc>https://vikanns.com/how-to-prepare-for-student-visa.html</loc><priority>0.7</priority></url>
  <url><loc>https://vikanns.com/how-to-choose-the-right-course.html</loc><priority>0.7</priority></url>
</urlset>
EOF

echo "--- Verifying ---"
ls -la how-to-choose-country.html uk-vs-new-zealand.html how-education-funding-works.html understanding-proof-of-funds.html how-to-prepare-for-student-visa.html how-to-choose-the-right-course.html
grep -c "resource-card\"" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add 6 full Resource Centre articles with real content (Section 12)"
git push

echo ""
echo "Done. Live in a minute or two."

