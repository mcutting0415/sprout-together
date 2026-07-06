#!/bin/bash
echo "========================================"
echo "  BUILD 41 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 41:"
echo "  1. BUGFIX: Garden template type chip crash (setValue -> .value)"
echo "  2. Garden Builder — direction text green/italic"
echo "  3. Garden Builder — Combine Squares button teal-blue"
echo "  4. Garden Builder — Add Container panel with name, size, plant search"
echo "  5. Plant picker — search added in all pickers"
echo "  6. Side menu — Growing Calendar, Current Gardens, Archive added"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 41: fix template chip crash + garden builder UX + side menu nav" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
