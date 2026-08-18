#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Scroll-to-top arrow button
# ---------------------------------------------------------------------------
if ! grep -q "scroll-top-btn" index.html; then
  sed -i 's|<script src="script.js"></script>|<a href="#home" id="scrollTopBtn" class="scroll-top-btn" aria-label="Back to top"><i class="fa-solid fa-arrow-up"></i></a>\n<script src="script.js"></script>|' index.html
  echo "Scroll-to-top button added."
else
  echo "Already present, skipped."
fi

cat >> script.js << 'EOF'

// Show/hide the "back to top" button based on scroll position
(function () {
  const btn = document.getElementById('scrollTopBtn');
  if (!btn) return;
  window.addEventListener('scroll', () => {
    if (window.scrollY > 500) {
      btn.classList.add('visible');
    } else {
      btn.classList.remove('visible');
    }
  });
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
})();
EOF

cat >> style.css << 'EOF'

/* ---------------- Back-to-top button ---------------- */
.scroll-top-btn {
  position: fixed;
  bottom: 24px;
  left: 24px;
  background: var(--green);
  color: var(--white);
  width: 50px;
  height: 50px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2rem;
  box-shadow: 0 6px 16px rgba(0,0,0,0.25);
  z-index: 200;
  opacity: 0;
  visibility: hidden;
  transform: translateY(10px);
  transition: opacity 0.3s, transform 0.3s, visibility 0.3s;
}
.scroll-top-btn.visible {
  opacity: 1;
  visibility: visible;
  transform: translateY(0);
}
EOF

# ---------------------------------------------------------------------------
# 2. Footer layout: Quick Links + Services side by side, Contact below
# ---------------------------------------------------------------------------
cat >> style.css << 'EOF'

/* ---------------- Footer layout: horizontal pairing ---------------- */
.footer-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px 30px;
}
.footer-col:nth-child(1) { grid-column: 1 / -1; }
.footer-col:nth-child(2) { grid-column: 1; }
.footer-col:nth-child(3) { grid-column: 2; }
.footer-col:nth-child(4) { grid-column: 1 / -1; }
EOF

echo "--- Verifying ---"
grep -n "scroll-top-btn\|footer-col:nth-child" index.html style.css | head -10

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add back-to-top button, restructure footer to pair Quick Links + Services horizontally"
git push

echo "Done. Live in a minute or two."

