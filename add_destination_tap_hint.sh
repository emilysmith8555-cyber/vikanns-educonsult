#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# 1. Add an instructional line right after the section lead
sed -i 's|<p class="section-lead">One goal. Many possible destinations. Choosing where to study is just as important as choosing what to study.</p>|<p class="section-lead">One goal. Many possible destinations. Choosing where to study is just as important as choosing what to study.</p>\n  <p class="tap-hint">Tap any destination below to learn more.</p>|' index.html

# 2. Add a "Learn More" label inside each destination tile
sed -i 's|<span class="fi fi-gb flag-icon-lg"></span><span>United Kingdom</span></a>|<span class="fi fi-gb flag-icon-lg"></span><span>United Kingdom</span><span class="dest-tile-cta">Learn More \&rarr;</span></a>|' index.html
sed -i 's|<span class="fi fi-ca flag-icon-lg"></span><span>Canada</span></a>|<span class="fi fi-ca flag-icon-lg"></span><span>Canada</span><span class="dest-tile-cta">Learn More \&rarr;</span></a>|' index.html
sed -i 's|<span class="fi fi-nl flag-icon-lg"></span><span>Netherlands</span></a>|<span class="fi fi-nl flag-icon-lg"></span><span>Netherlands</span><span class="dest-tile-cta">Learn More \&rarr;</span></a>|' index.html
sed -i 's|<span class="fi fi-nz flag-icon-lg"></span><span>New Zealand</span></a>|<span class="fi fi-nz flag-icon-lg"></span><span>New Zealand</span><span class="dest-tile-cta">Learn More \&rarr;</span></a>|' index.html
sed -i 's|<span class="fi fi-eu flag-icon-lg"></span><span>Europe \&amp; Beyond</span></a>|<span class="fi fi-eu flag-icon-lg"></span><span>Europe \&amp; Beyond</span><span class="dest-tile-cta">Learn More \&rarr;</span></a>|' index.html

cat >> style.css << 'EOF'

/* ---------------- Destination tap hint + learn-more label ---------------- */
.tap-hint {
  text-align: center;
  font-size: 0.85rem;
  color: var(--green-dark);
  font-weight: 600;
  margin-top: -18px;
  margin-bottom: 24px;
}
.dest-tile-cta {
  display: block;
  font-size: 0.75rem;
  font-weight: 700;
  color: var(--green);
  margin-top: 6px;
}
EOF

echo "--- Verifying ---"
grep -n "tap-hint\|dest-tile-cta" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add tap-to-learn-more hint and label to destination tiles"
git push

echo "Done. Live in a minute or two."

