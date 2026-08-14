#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

sed -i 's|<form class="contact-form" action="https://formspree.io/f/xqpzlewe" method="POST">|<p class="form-label">Start Your Journey</p>\n  <form class="contact-form" action="https://formspree.io/f/xqpzlewe" method="POST">|' index.html

cat >> style.css << 'EOF'

/* ---------------- Contact form label ---------------- */
.form-label {
  text-align: center;
  font-weight: 800;
  letter-spacing: 1px;
  color: var(--green-dark);
  margin-bottom: 10px;
  text-transform: uppercase;
  font-size: 0.95rem;
}
EOF

echo "--- Verifying ---"
grep -n "form-label" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add missing Start Your Journey label above contact form"
git push

echo "Done. Live in a minute or two."

