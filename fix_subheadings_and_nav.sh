#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Missing sub-headings before each service's bullet list
# ---------------------------------------------------------------------------
sed -i 's|<p>We guide students through the process of identifying suitable programmes, institutions and destinations based on their academic background, career goals and budget.</p>|<p>We guide students through the process of identifying suitable programmes, institutions and destinations based on their academic background, career goals and budget.</p>\n    <p class="list-lead">Our support can include:</p>|' index.html

sed -i 's|<p>We help students understand visa requirements and organise their applications carefully.</p>|<p>We help students understand visa requirements and organise their applications carefully.</p>\n    <p class="list-lead">Our guidance can include:</p>|' index.html

sed -i 's|<p>Funding international education can be one of the biggest challenges students face. Vikanns helps eligible students explore available funding options, including study loans and other education financing solutions.</p>|<p>Funding international education can be one of the biggest challenges students face. Vikanns helps eligible students explore available funding options, including study loans and other education financing solutions.</p>\n    <p class="list-lead">We help you understand:</p>|' index.html

# ---------------------------------------------------------------------------
# 2. Rename "What Guides Us" -> "Our Values"
# ---------------------------------------------------------------------------
sed -i 's|<h2>What Guides Us</h2>|<h2>Our Values</h2>|' index.html

# ---------------------------------------------------------------------------
# 3. Give every major section an id so it can be reached from the nav
# ---------------------------------------------------------------------------
sed -i 's|<section class="why-vikanns reveal">|<section id="why-vikanns" class="why-vikanns reveal">|' index.html
sed -i 's|<section class="funding-feature reveal">|<section id="funding" class="funding-feature reveal">|' index.html
sed -i 's|<section class="values reveal">|<section id="values" class="values reveal">|' index.html

# ---------------------------------------------------------------------------
# 4. Add nav links for the sections that did not have one yet
# ---------------------------------------------------------------------------
sed -i 's|<li><a href="#how-it-works">How It Works</a></li>|<li><a href="#how-it-works">How It Works</a></li>\n      <li><a href="#why-vikanns">Why Vikanns</a></li>\n      <li><a href="#funding">Funding</a></li>|' index.html

sed -i 's|<li><a href="#resources">Resources</a></li>|<li><a href="#resources">Resources</a></li>\n      <li><a href="#values">Our Values</a></li>\n      <li><a href="#faq">FAQ</a></li>|' index.html

cat >> style.css << 'EOF'

/* ---------------- List lead-in text ---------------- */
.list-lead {
  font-weight: 600;
  color: var(--green-dark);
  margin-bottom: 8px;
}
EOF

echo "--- Verifying ---"
grep -n "list-lead\|Our Values\|id=\"why-vikanns\"\|id=\"funding\"\|id=\"values\"\|href=\"#why-vikanns\"\|href=\"#funding\"\|href=\"#values\"\|href=\"#faq\"" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add missing list sub-headings, rename Our Values, add nav anchors for all major sections"
git push

echo "Done. Live in a minute or two."

