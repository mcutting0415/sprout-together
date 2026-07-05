#!/bin/bash
echo "========================================"
echo "  BUILD 31 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 31:"
echo "  1. Edit Account button on Settings page"
echo "     → tap to edit name, email, password"
echo "  2. Zone auto-generates from zip (no dropdown)"
echo "  3. Appearance dropdown is now visible"
echo "  4. Sign up page fits on one screen (no scrolling)"
echo "  5. Keyboard shows 'Next' between signup fields"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 31: edit account, auto zone, appearance fix, signup layout, keyboard next" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
