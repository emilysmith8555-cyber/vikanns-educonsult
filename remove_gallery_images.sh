#!/usr/bin/env bash
set -e
cd ~/VikannsWebsite

python3 - << 'PYEOF'
path = "index.html"
with open(path) as f:
    content = f.read()

old = '''  <div class="gallery-grid">
    <img src="https://picsum.photos/id/1027/500/400" alt="Student abroad on campus" loading="lazy">
    <img src="https://picsum.photos/id/1035/500/400" alt="Student studying abroad in a library" loading="lazy">
    <img src="https://picsum.photos/id/1041/500/400" alt="Graduation abroad" loading="lazy">
    <img src="https://picsum.photos/id/1043/500/400" alt="International student campus life" loading="lazy">
    <img src="https://picsum.photos/id/1050/500/400" alt="Student traveling abroad for studies" loading="lazy">
    <img src="https://picsum.photos/id/1059/500/400" alt="Student abroad exploring a new city" loading="lazy">
  </div>
  <p class="gallery-note">Photos shown are illustrative placeholders — real student photos coming soon.</p>'''

new = '''  <div class="gallery-grid">
    <!-- Real photos will go here, and eventually be spread across other sections too. -->
  </div>
  <p class="gallery-note">Photos coming soon.</p>'''

if old in content:
    content = content.replace(old, new)
    with open(path, "w") as f:
        f.write(content)
    print("Gallery images removed.")
else:
    print("Pattern not found, checking current gallery section...")
    import re
    match = re.search(r'<div class="gallery-grid">.*?</div>', content, re.DOTALL)
    if match:
        print("Found gallery-grid block:")
        print(match.group(0)[:500])
    else:
        print("No gallery-grid found at all.")
PYEOF

git add -A
git -c user.email="site@vikanns.local" -c user.name="Vikanns Site Bot" commit -q -m "Remove placeholder gallery images"
git push

echo "Done. Changes will be live on the site within a minute or two."

