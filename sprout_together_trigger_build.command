#!/bin/bash
echo "========================================"
echo "  BUILD 38 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 38:"
echo "  1. Companion Plants page — instruction card"
echo "     → Decorative guide card with 3 numbered steps"
echo "     → Explains how to use the feature before the plant grid"
echo "  2. Companion Plants — expanded plant data"
echo "     → Added: rose, borage, horseradish, anise, tarragon, geranium,"
echo "       hyssop, lemon grass, bok choy, collard, mustard, melon"
echo "     → Pepper updated with more companions"
echo "     → All duplicates removed"
echo "  3. Planner — delete + mark-as-planted (from Build 37)"
echo "  4. Plant Library — back-to-top button (from Build 37)"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 38: companion page instruction card, expanded companion data" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
