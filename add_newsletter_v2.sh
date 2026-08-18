#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Remove the "Intake Updates" card from Resources
# ---------------------------------------------------------------------------
awk '
  /<div class="resource-card"><i class="fa-solid fa-calendar-days resource-icon"><\/i><h3>Intake Updates<\/h3>/ { skip=1 }
  skip && /<\/div>$/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# ---------------------------------------------------------------------------
# 2. Add the newsletter section, right before the footer
# ---------------------------------------------------------------------------
NEWSLETTER=$(cat << 'EOF'
<section id="newsletter" class="newsletter reveal">
  <h2>Get Intake Update and Study Abroad Opportunities</h2>
  <p class="section-lead">Join our mailing list for scholarship alerts, intake updates, and study abroad opportunities.</p>
  <form class="newsletter-form" action="https://formspree.io/f/xqpzlewe" method="POST">
    <input type="hidden" name="_subject" value="New newsletter signup">
    <input type="email" name="email" placeholder="Your email address" required>
    <input type="text" name="_gotcha" style="display:none" tabindex="-1" autocomplete="off">
    <button type="submit" class="btn-primary">Get Updates Now</button>
  </form>
  <p class="newsletter-note">No spam, unsubscribe anytime. We respect your privacy.</p>
</section>
EOF
)

awk -v repl="$NEWSLETTER" '
  /<footer>/ && !done { print repl; print ""; print; done=1; next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

# ---------------------------------------------------------------------------
# 3. Remove the numbers from How It Works swipe cards, keep only the icon
# ---------------------------------------------------------------------------
sed -i '/<span class="step-num-lg">0[1-6]<\/span>/d' index.html

# ---------------------------------------------------------------------------
# 4. Styling
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Newsletter ---------------- */
.newsletter { text-align: center; }
.newsletter-form {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 12px;
  max-width: 460px;
  margin: 0 auto;
}
.newsletter-form input[type="email"] {
  flex: 1;
  min-width: 220px;
  padding: 13px 16px;
  border: 1px solid #ccc;
  border-radius: 30px;
  font-size: 1rem;
}
.newsletter-note {
  margin-top: 14px;
  font-size: 0.82rem;
  color: var(--muted);
}
EOF

echo "--- Verifying ---"
grep -c "Intake Updates" index.html || echo "0 (correctly removed)"
grep -n "Get Intake Update and Study Abroad Opportunities\|Get Updates Now" index.html
grep -c "step-num-lg" index.html || echo "0 (correctly removed)"

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add newsletter section with correct wording, remove Intake Updates card, remove numbers from How It Works cards"
git push

echo "Done. Live in a minute or two."

