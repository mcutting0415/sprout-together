#!/bin/bash
cd "$(dirname "$0")" || { echo "ERROR: cd failed"; read -p "Press Enter..."; exit 1; }

echo "=== Removing stale git lock ==="
rm -f .git/index.lock && echo "Lock removed" || echo "No lock found (OK)"

echo ""
echo "=== Bumping version to 1.0.0+61 ==="
sed -i '' 's/^version: 1\.0\.0+60$/version: 1.0.0+61/' pubspec.yaml
grep "^version:" pubspec.yaml

echo ""
echo "=== Staging files ==="
git add lib/final_app_pages/shop_page/shop_page_widget.dart pubspec.yaml

echo ""
echo "=== Committing ==="
git commit -m "fix: correct mismatched shop product images; bump to build 61"

echo ""
echo "=== Pushing to GitHub ==="
git push origin main

if [ $? -eq 0 ]; then
  echo ""
  echo "✅ Push successful! Build 61 triggered on Codemagic."
else
  echo ""
  echo "❌ Push failed. Check credentials."
fi
read -p "Press Enter to close..."
