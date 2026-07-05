#!/bin/bash
echo "========================================"
echo "  BUILD 39 — Pushing now"
echo "========================================"
echo ""
echo "WHAT'S IN BUILD 39:"
echo "  1. Settings — Garden Templates removed"
echo "     → No more accidentally creating gardens from Settings"
echo "     → My Gardens section now shows: Current Gardens, Per-Garden Settings, Past Gardens"
echo "  2. Create Garden page — Quick Start templates"
echo "     → Horizontally scrollable template cards at the top"
echo "     → Herb Garden (3×3), Raised Bed (4×8), Veggie Patch (6×6),"
echo "       Salad Garden (3×6), Large Garden (10×10)"
echo "     → Tapping a template pre-fills the name, width, length, and type fields"
echo "     → You still review and click 'Create Garden' to actually create it"
echo "     → No accidental garden creation"
echo ""
echo "Pushing to GitHub..."
cd ~/Downloads/sprout_together
rm -f .git/HEAD.lock .git/index.lock .git/refs/heads/main.lock
git add -A
git commit -m "Build 39: templates moved to Create Garden page, removed from Settings" --allow-empty
git push origin main
echo ""
echo "✅ Pushed! iOS TestFlight build will start automatically."
echo "Check https://codemagic.io/builds"
read -p "Press Enter to close..."
