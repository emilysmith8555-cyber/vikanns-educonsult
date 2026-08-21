#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

awk '
  /<section id="how-it-works" class="how-it-works reveal">/ {
    print
    print "  <h2>Your Journey. Simplified.</h2>"
    print "  <p class=\"section-lead\">From an idea to a clear pathway.</p>"
    print "  <div class=\"journey-timeline\">"
    print "    <div class=\"journey-step\"><span class=\"journey-num\">01</span><div><h3><i class=\"fa-solid fa-bullseye\"></i> Discover</h3><p>Tell us your goals.</p></div></div>"
    print "    <div class=\"journey-step\"><span class=\"journey-num\">02</span><div><h3><i class=\"fa-solid fa-magnifying-glass\"></i> Choose</h3><p>Explore programmes and destinations.</p></div></div>"
    print "    <div class=\"journey-step\"><span class=\"journey-num\">03</span><div><h3><i class=\"fa-solid fa-clipboard-list\"></i> Apply</h3><p>Prepare and submit your application.</p></div></div>"
    print "    <div class=\"journey-step\"><span class=\"journey-num\">04</span><div><h3><i class=\"fa-solid fa-envelope-circle-check\"></i> Admission</h3><p>Understand your offer and enrolment steps.</p></div></div>"
    print "    <div class=\"journey-step\"><span class=\"journey-num\">05</span><div><h3><i class=\"fa-solid fa-coins\"></i> Fund</h3><p>Explore applicable funding options.</p></div></div>"
    print "    <div class=\"journey-step\"><span class=\"journey-num\">06</span><div><h3><i class=\"fa-solid fa-passport\"></i> Visa</h3><p>Prepare your visa documentation.</p></div></div>"
    print "    <div class=\"journey-step\"><span class=\"journey-num\">07</span><div><h3><i class=\"fa-solid fa-plane-departure\"></i> Depart</h3><p>Prepare for your next chapter.</p></div></div>"
    print "  </div>"
    print "  <div class=\"center-btn\"><a href=\"#eligibility\" class=\"btn-primary\">Start My Journey</a></div>"
    print "</section>"
    skip=1
    next
  }
  skip && /<\/section>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

cat >> style.css << 'EOF'

/* ---------------- Journey Timeline ---------------- */
.journey-timeline { max-width: 600px; margin: 30px auto 0; position: relative; }
.journey-step { display: flex; gap: 20px; position: relative; padding-bottom: 34px; }
.journey-step:last-child { padding-bottom: 0; }
.journey-step::before {
  content: ""; position: absolute; left: 22px; top: 46px; bottom: 0; width: 2px; background: #d9ecdf;
}
.journey-step:last-child::before { display: none; }
.journey-num {
  flex-shrink: 0; width: 44px; height: 44px; border-radius: 50%;
  background: var(--green); color: var(--white); font-weight: 800;
  display: flex; align-items: center; justify-content: center; z-index: 1;
}
.journey-step h3 { color: var(--green-dark); font-size: 1.05rem; margin-bottom: 4px; }
.journey-step h3 i { margin-right: 6px; color: var(--green); }
.journey-step p { color: var(--muted); font-size: 0.92rem; }
EOF

echo "--- Verifying ---"
grep -n "journey-timeline\|journey-step\|>Discover<\|>Fund<\|>Visa<\|>Depart<\|Start My Journey" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Rebuild How It Works as a 7-step visual Journey Timeline (Section 10)"
git push

echo "Done. Live in a minute or two."

