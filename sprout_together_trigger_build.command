#!/bin/bash
echo "========================================"
echo "  BUILD 35 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 35:"
echo "  1. Companion planting page redesigned"
echo "     → Browse all plants in a grid (same as plant library)"
echo "     → Search any plant by name"
echo "     → Tap a plant to see Good Companions and Plants to Avoid"
echo "     → Companion chips are tappable — tap one to see its companions"
echo "     → Gardener's tip shown for each plant"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 35: companion planting lookup — full plant grid, search, good/bad companions" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
