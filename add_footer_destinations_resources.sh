#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

awk 'NR==487 {
  print "    <div class=\"footer-col\">"
  print "      <h4>Destinations</h4>"
  print "      <a href=\"uk.html\">United Kingdom</a>"
  print "      <a href=\"canada.html\">Canada</a>"
  print "      <a href=\"new-zealand.html\">New Zealand</a>"
  print "      <a href=\"netherlands.html\">Netherlands</a>"
  print "      <a href=\"europe.html\">Europe &amp; Beyond</a>"
  print "    </div>"
  print "    <div class=\"footer-col\">"
  print "      <h4>Resources</h4>"
  print "      <a href=\"how-to-choose-country.html\">Choosing a Country</a>"
  print "      <a href=\"uk-vs-new-zealand.html\">UK vs New Zealand</a>"
  print "      <a href=\"how-education-funding-works.html\">How Funding Works</a>"
  print "      <a href=\"understanding-proof-of-funds.html\">Proof of Funds</a>"
  print "      <a href=\"how-to-prepare-for-student-visa.html\">Visa Preparation</a>"
  print "      <a href=\"how-to-choose-the-right-course.html\">Choosing a Course</a>"
  print "    </div>"
}
{ print }' index.html > index_tmp.html && mv index_tmp.html index.html

echo "--- Verifying ---"
grep -n "footer-col\|<h4>" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Add Destinations and Resources columns to footer (Section 17)"
git push

echo "Done. Live in a minute or two."

