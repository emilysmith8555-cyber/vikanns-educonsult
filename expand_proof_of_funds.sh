#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

awk '
  /<h3>Proof of Funds Solutions<\/h3>/ {
    print "      <h3>Proof of Funds Guidance</h3>"
    print "      <p class=\"service-tagline\">Make your financial documentation part of the plan.</p>"
    print "      <p>Proof of funds is evidence that you (or your sponsor) can cover your tuition and living costs \u2014 many institutions and immigration authorities require this before approving your application.</p>"
    print "      <ul>"
    print "        <li>What proof of funds means for your destination</li>"
    print "        <li>Why institutions and authorities may require it</li>"
    print "        <li>Legitimate documentation and financial evidence</li>"
    print "        <li>Common mistakes applicants make</li>"
    print "        <li>Destination-specific considerations</li>"
    print "      </ul>"
    print "      <p class=\"service-tagline\">Legitimate documentation. Transparent process. Compliance with applicable requirements.</p>"
    print "      <a href=\"#contact\" class=\"btn-outline\">Speak With an Adviser</a>"
    skip=1
    next
  }
  skip && /<a href="#contact" class="btn-outline">Speak With an Adviser<\/a>/ { skip=0; next }
  skip { next }
  { print }
' index.html > index_tmp.html && mv index_tmp.html index.html

echo "--- Verifying ---"
grep -n "Proof of Funds Guidance\|What proof of funds means\|Legitimate documentation. Transparent process" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Expand Proof of Funds section per upgrade brief (Section 9)"
git push

echo "Done. Live in a minute or two."

