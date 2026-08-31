# Post #2 — Companion planting

Pairings pulled from the app's own dataset (`lib/services/companion_planting_service.dart`),
so the post and the app never contradict each other.

| File | Where | Size |
|---|---|---|
| `ig-1.png` … `ig-7.png` | Instagram carousel, in order | 1080×1350 (4:5) |
| `pin.png` | Pinterest, single pin | 1000×1500 (2:3) |

---

## Instagram caption

```
Some plants make each other better. Some quietly ruin each other 🌱

Companion planting is the closest thing gardening has to a free upgrade
— fewer pests, better pollination, more harvest, no extra work.

The pairings worth knowing:

🍅 Tomato → basil, marigold, carrot · keep from fennel + corn
🥕 Carrot → onion, leek, lettuce · keep from dill
🥬 Lettuce → carrot, radish, strawberry · keep from celery
🥒 Cucumber → beans, radish, sunflower · keep from potato + sage

And one troublemaker: fennel. 37 of the 68 plants in our guide list it
as one to keep away from. Give it a pot of its own 😅

Save this before you plan your beds 📌

Tap any plant in Sprout Together to see its full companion list — free,
link in bio.

Which pairing surprised you? 👇

#companionplanting #vegetablegarden #gardeningtips #growyourown
#gardenplanner #raisedbedgarden #organicgardening #beginnergardener
```

**Alt text:** "Companion planting carousel showing which plants to grow beside tomato, carrot, lettuce and cucumber, and which to keep apart."

---

## Pinterest pin

- **Title:** `Companion Planting Cheat Sheet — What to Plant Together`
- **Description:**
```
A simple companion planting chart for your vegetable garden. See what to plant
next to tomatoes, carrots, lettuce, cucumber, beans and strawberries — and which
plants to keep apart. Save this before you plan your raised beds. Free companion
planting guide for 68 plants in the Sprout Together app.
```
- **Link:** `https://sprouttogether.app`
- **Board:** Companion Planting Charts

This is the pin format that actually gets saved on Pinterest — a reference chart
someone wants back later. Expect it to outperform the welcome pin over time.

---

## Regenerating

```
python3 marketing/make_companion_post.py
```

Edit `PAIRS` (Instagram) or `ROWS` (Pinterest) at the top of the script to change plants.
