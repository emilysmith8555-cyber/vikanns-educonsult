#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

echo "==> Checking current state..."
grep -c "scroll-strip" index.html || echo "0"
grep -c "services-layout" index.html || echo "0"

# ---------------------------------------------------------------------------
# Fix Services: add sticky image + wrap the 6 service blocks, properly
# tracking when we're inside the services section so we close at the right spot.
# ---------------------------------------------------------------------------
if ! grep -q "services-layout" index.html; then
  awk '
    /<section id="services" class="services reveal">/ { in_services=1; print; next }

    in_services && /<p class="section-lead">Solutions designed around your goals\. Vikanns provides practical support across education, international opportunities and advisory services\.<\/p>/ {
      print
      print "  <div class=\"services-layout\">"
      print "    <div class=\"services-sticky-img\"><img src=\"images/hero-empower.jpg\" alt=\"Vikanns consultation\" class=\"sticky-img\"></div>"
      print "    <div class=\"services-blocks\">"
      next
    }

    in_services && /<\/section>/ {
      print "    </div>"
      print "  </div>"
      print
      in_services=0
      next
    }

    { print }
  ' index.html > index_tmp.html && mv index_tmp.html index.html
  echo "Services restructured."
else
  echo "Services already restructured, skipped."
fi

echo "--- Verifying Services ---"
grep -n "services-layout\|services-sticky-img\|services-blocks" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Fix: actually apply Services sticky-image layout, correctly nested"
git push

echo "Done. Live in a minute or two."

