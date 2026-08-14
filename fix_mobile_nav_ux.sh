#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

# ---------------------------------------------------------------------------
# 1. Mobile nav: horizontal wrap layout instead of a tall vertical stack
# ---------------------------------------------------------------------------
python3 --version >/dev/null 2>&1 || true

sed -i '/\.nav-links\.open { display: flex; }/c\  .nav-links.open { display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; gap: 10px 18px; }' style.css

# Make sure the base .nav-links rule (desktop) does not force column on mobile override conflicts
sed -i '/@media (max-width: 760px) {/,/^}/ s/flex-direction: column;//' style.css

# ---------------------------------------------------------------------------
# 2. Tap anywhere outside the open menu to close it
# ---------------------------------------------------------------------------
cat >> script.js << 'EOF'

// Close the mobile menu when tapping anywhere outside it
document.addEventListener('click', function (event) {
  const navLinks = document.getElementById('navLinks');
  const toggleBtn = document.querySelector('.menu-toggle');
  if (!navLinks || !toggleBtn) return;
  const isOpen = navLinks.classList.contains('open');
  const clickedInsideNav = navLinks.contains(event.target);
  const clickedToggle = toggleBtn.contains(event.target);
  if (isOpen && !clickedInsideNav && !clickedToggle) {
    navLinks.classList.remove('open');
  }
});
EOF

echo "--- Verifying ---"
grep -n "nav-links.open\|Close the mobile menu" style.css script.js

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Mobile nav: horizontal wrap layout + tap-outside-to-close"
git push

echo "Done. Live in a minute or two."

