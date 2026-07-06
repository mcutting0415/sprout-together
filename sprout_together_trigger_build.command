#!/bin/bash
echo "========================================"
echo "  BUILD 42 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 42:"
echo "  1. Sign-up page: keyboard Next goes Name → Email → Password → Confirm (explicit focus)"
echo "  2. Garden builder: assigning a plant auto-creates Plant / Water / Harvest tasks in calendar"
echo "  3. All pages: removed all underlined text (TextDecoration.underline → none)"
echo "  4. Garden journal: filter chips fit evenly (no scroll)"
echo "  5. Garden journal: entries are clickable — opens view/edit sheet"
echo "  6. Garden journal: back button only shows when navigating from garden insights"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 42: keyboard focus fix + auto-tasks + no underlines + journal UX" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
