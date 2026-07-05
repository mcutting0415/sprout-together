#!/bin/bash
echo "========================================"
echo "  BUILD 33 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 33:"
echo "  1. Push notifications for task due dates"
echo "     → Notifies you 1 day before any garden task is due"
echo "     → Works for manual tasks and auto-scheduled planting tasks"
echo "  2. Weather-based planting suggestions"
echo "     → 'Good week to plant tomatoes' based on today's temp"
echo "     → Rainy day tips, frost warnings, heat wave advice"
echo "     → Appears in the weather card on your Planner"
echo "  3. Companion plant compatibility checker"
echo "     → Long-press any plot square in the Garden Builder"
echo "     → See which plants help or hurt each other"
echo "     → Cross-checks plants already in your garden"
echo "     → 60+ plant relationships included"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 33: push notifications, weather planting suggestions, companion plant checker" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
