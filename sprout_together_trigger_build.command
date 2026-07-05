#!/bin/bash
echo "========================================"
echo "  BUILD 40 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 40:"
echo "  1. Settings — Contact Support removed from Support section"
echo "  2. Settings — Garden Templates removed, Create Garden templates added (Build 39)"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 40: remove Contact Support from settings" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
