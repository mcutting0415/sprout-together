#!/bin/bash
echo "========================================"
echo "  BUILD 34 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 34:"
echo "  1. Companion planting expanded to 50+ plants"
echo "     → Long-press any plot square in Garden Builder"
echo "     → Now covers: eggplant, cabbage, potato, cauliflower, beet,"
echo "       celery, dill, cilantro, parsley, sage, chive, oregano,"
echo "       chamomile, nasturtium, zinnia, echinacea, lemon balm,"
echo "       blueberry, raspberry, artichoke, okra, pumpkin,"
echo "       watermelon, cantaloupe, asparagus, sweet potato, and more"
echo "  2. Profile page cleanup"
echo "     → Removed duplicate Privacy Settings button"
echo "     → Removed duplicate red Logout button"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 34: expanded companion planting (50+ plants), profile page cleanup" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
