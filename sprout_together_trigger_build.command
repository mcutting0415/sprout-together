#!/bin/bash
echo "========================================"
echo "  BUILD 37 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 37:"
echo "  1. Planner — delete plants from 'I Want to Grow' list"
echo "     → Trash icon on each plant row to remove it"
echo "  2. Planner — 'Mark as Planted' button"
echo "     → Checkmark icon moves a plant to 'Plants I've Planted' section"
echo "     → Undo arrow to move it back to want-to-grow"
echo "     → Trash icon to remove from planted list permanently"
echo "  3. Add Plants flow — Done button + unselect (from Build 36)"
echo "     → Done button shows count and navigates back to planner"
echo "     → X icon removes a plant from selection"
echo "  4. Plant Library — back-to-top button"
echo "     → Floating button appears after scrolling down 300px"
echo "     → Tapping scrolls back to top"
echo "  5. Companion planting page redesign (from Build 35)"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 37: plant list delete/mark-as-planted, back-to-top button, done flow" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
