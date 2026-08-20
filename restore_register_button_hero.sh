#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

REG_URL='https://app.coursefinder.ai/student-platform/471d93c9/sign-up?fbclid=IwRlRTSATrw59wZG9mAWZkaWQWUMdmhclQ7GO9vM-ND-LG_0B2MfiGwmV4dG4DYWVtAjEwAHNydGMGYXBwX2lkCjY2Mjg1NjgzNzkAAR4h8rkDlUflobKek0WVAVY5FFrAP6qHoqMx7nfuUKllVlG0pQ3Ny8dTJ0-eRQ_aem_fXly7G1NQUR6cUaHfCYm7w'

if ! grep -q "Register Now" index.html; then
  sed -i "s|<a href=\"#services\" class=\"btn-outline\">Explore Study Options</a>|<a href=\"#services\" class=\"btn-outline\">Explore Study Options</a>\n      <a href=\"${REG_URL}\" target=\"_blank\" rel=\"noopener\" class=\"btn-register\">Register Now</a>|" index.html
  echo "Register Now button restored in hero."
else
  echo "Already present, skipped."
fi

echo "--- Verifying ---"
grep -n "Register Now" index.html

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Restore Register Now button in hero after rewrite"
git push

echo "Done. Live in a minute or two."

