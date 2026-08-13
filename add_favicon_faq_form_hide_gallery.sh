#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Hide the empty gallery section + remove its nav link, until real photos exist
# ---------------------------------------------------------------------------
sed -i 's|<li><a href="#gallery">Gallery</a></li>|<!-- Gallery nav link hidden until real photos are added: <li><a href="#gallery">Gallery</a></li> -->|' index.html

awk '
  /<section id="gallery" class="gallery reveal">/ { print "<!-- Gallery section hidden until real photos are added:"; print; next }
  /<\/section>/ && prev_gallery { print; print "-->"; prev_gallery=0; next }
  /<section id="gallery"/ { prev_gallery=1 }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# Simpler, reliable approach: wrap using sed markers instead (awk above can be fragile)
# Verify gallery is now inside a comment; if not, fall back:
if ! grep -q "Gallery section hidden" index.html; then
  sed -i '/<section id="gallery" class="gallery reveal">/i <!-- Gallery section hidden until real photos are added:' index.html
  sed -i '/<section id="gallery" class="gallery reveal">/,/<\/section>/{/<\/section>/a -->
  }' index.html
fi

# ---------------------------------------------------------------------------
# 2. Favicon (reuses your existing logo) + social share preview image
# ---------------------------------------------------------------------------
sed -i 's|<link rel="stylesheet" href="style.css">|<link rel="icon" type="image/png" href="images/logo.png">\n<link rel="stylesheet" href="style.css">|' index.html

sed -i 's|<meta property="og:type" content="website">|<meta property="og:type" content="website">\n<meta property="og:image" content="https://emilysmith8555-cyber.github.io/vikanns-ltd/images/team-green.jpg">|' index.html

# ---------------------------------------------------------------------------
# 3. FAQ section (native <details>/<summary> — accessible, no JS needed)
# ---------------------------------------------------------------------------
sed -i 's|<li><a href="#contact">Contact</a></li>|<li><a href="#faq">FAQ</a></li>\n      <li><a href="#contact">Contact</a></li>|' index.html

python3 --version >/dev/null 2>&1 && HAS_PY=1 || HAS_PY=0

awk '
  /<section id="contact" class="contact reveal">/ && !done {
    print "<section id=\"faq\" class=\"faq reveal\">"
    print "  <h2>Frequently Asked Questions</h2>"
    print "  <details><summary>Do I need IELTS to study abroad?</summary><p>Not always — some universities and pathways accept alternative English proficiency proof, or offer foundation years. We help you find the route that fits your situation.</p></details>"
    print "  <details><summary>How much does the process cost?</summary><p>Costs vary by country, program, and pathway. We give you a clear, upfront breakdown before you commit to anything.</p></details>"
    print "  <details><summary>How long does visa processing take?</summary><p>Timelines vary by country and season, but we keep you updated at every stage so there are no surprises.</p></details>"
    print "  <details><summary>Can I get a study loan?</summary><p>Yes — we offer study loan advisory as part of our services. Reach out and we will walk you through your options.</p></details>"
    print "  <details><summary>What if my visa application is refused?</summary><p>We help minimize that risk from the start with thorough preparation, and advise on next steps if a refusal happens.</p></details>"
    print "</section>"
    print ""
    done=1
  }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- FAQ ---------------- */
.faq details {
  background: #f4fbf7;
  border: 1px solid #e0f0e6;
  border-radius: 10px;
  padding: 14px 18px;
  margin-bottom: 12px;
}
.faq summary {
  font-weight: 600;
  color: var(--green-dark);
  cursor: pointer;
}
.faq p {
  margin-top: 10px;
  color: var(--muted);
}
EOF

# ---------------------------------------------------------------------------
# 4. Contact form (Formspree — needs your own form ID, see instructions after)
# ---------------------------------------------------------------------------
python3 - << 'PYEOF' 2>/dev/null || true
PYEOF

sed -i 's|<p>Ready to start your study abroad journey? Reach out today — we respond fast.</p>|<p>Ready to start your study abroad journey? Reach out today — we respond fast.</p>\n  <form class="contact-form" action="https://formspree.io/f/REPLACE_WITH_YOUR_FORM_ID" method="POST">\n    <input type="text" name="name" placeholder="Your name" required>\n    <input type="email" name="email" placeholder="Your email" required>\n    <input type="text" name="country" placeholder="Country you want to study in">\n    <textarea name="message" placeholder="Tell us a bit about your goals" rows="4" required></textarea>\n    <button type="submit" class="btn-primary">Send Message</button>\n  </form>|' index.html

cat >> style.css << 'EOF'

/* ---------------- Contact form ---------------- */
.contact-form {
  max-width: 480px;
  margin: 24px auto 0;
  display: flex;
  flex-direction: column;
  gap: 12px;
  text-align: left;
}
.contact-form input,
.contact-form textarea {
  padding: 12px 14px;
  border: 1px solid #ccc;
  border-radius: 8px;
  font-family: inherit;
  font-size: 1rem;
}
.contact-form .btn-primary {
  align-self: center;
  background: var(--green);
  color: var(--white);
  border: none;
  cursor: pointer;
}
.contact-form .btn-primary:hover { background: var(--green-dark); }
EOF

echo "--- Verifying ---"
grep -n "Gallery section hidden\|rel=\"icon\"\|og:image\|id=\"faq\"\|formspree" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Hide empty gallery, add favicon/OG image, FAQ section, contact form"
git push

echo ""
echo "Done. Live in a minute or two."
echo ""
echo "IMPORTANT: the contact form will not actually deliver messages yet."
echo "Go to https://formspree.io, sign up free, create a form, and send me"
echo "the form ID it gives you (looks like a short code) so I can wire it in."

