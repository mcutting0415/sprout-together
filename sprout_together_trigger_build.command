#!/bin/bash
echo "========================================"
echo "  BUILD 42 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 42:"
echo "  1. Sign-up page: keyboard Next goes Name → Email → Password → Confirm (explicit focus)"
echo "  2. Garden builder: assigning a plant auto-creates Plant / Water (schedule) / Harvest / Weed tasks"
echo "  3. All pages: removed all underlined text (TextDecoration.underline → none)"
echo "  4. Garden journal: filter chips fit evenly (no scroll)"
echo "  5. Garden journal: entries are clickable — opens view/edit sheet"
echo "  6. Garden journal: back button only shows when navigating from garden insights"
echo "  7. Profile goals: renamed to Garden Goals / Overall Goals / Personal Goals"
echo "  8. Side menu: added Current Gardens, Growing Calendar, Previous Gardens"
echo "  9. Growing calendar: Upcoming Tasks section (next 7 days) below selected day's tasks"
echo " 10. Growing calendar: water schedule (every 3 days) + weekly weed reminders auto-generated on plant assignment"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 42: auto-schedule + upcoming tasks + full calendar generation" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
