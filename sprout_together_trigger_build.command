#!/bin/bash
echo "========================================"
echo "  BUILD 41 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 41:"
echo "  1. Garden Builder — direction text now green/italic"
echo "  2. Garden Builder — Combine Squares button now teal-blue"
echo "  3. Garden Builder — containers use Add Container button + slide-up panel with size, name, plant search"
echo "  4. Plant picker — search added in all pickers (grid squares, combine, containers)"
echo "  5. Side menu — Growing Calendar, Current Gardens, Archive nav items added"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 41: garden builder UX + side menu nav additions" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
