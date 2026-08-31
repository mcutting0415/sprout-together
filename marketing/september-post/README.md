# Post #3 — What to plant in September

Crops and timing pulled from the app's `bestSeason` data, so the post matches the app.
**Northern hemisphere.** Say so in the caption — southern-hemisphere followers are heading into spring.

| File | Where | Size |
|---|---|---|
| `ig-1.png` … `ig-7.png` | Instagram carousel, in order | 1080×1350 (4:5) |
| `pin.png` | Pinterest, single pin | 1000×1500 (2:3) |

**Post this one soon** — seasonal content decays. It's worth the most in the last days of August
and the first week of September, and close to nothing by October.

---

## Instagram caption

```
The season isn't over 🍂

September is one of the best sowing windows of the year — cool soil,
fewer pests, and crops that actually taste better for the cold.

Worth planting now (northern hemisphere 🌎):

🧄 Garlic — plant now, harvest next July. Fall-planted cloves build
roots over winter and make far bigger bulbs.
🍃 Spinach — 8–10 weeks before your first frost. Handles -4°C and
tastes sweeter after a frost.
🌱 Radish — 6 weeks before frost. Ready in under a month. Sow a fresh
row every two weeks.
🌿 Arugula — germinates in cool soil, best at 45–65°F. Peppery, fast.
🥬 Kale — survives -7°C. Frost turns its starch to sugar, so it gets
sweeter as it gets colder.

The catch: every one of these is timed off your FIRST FROST DATE, and
that's different everywhere. Sprout Together turns "6 weeks before
frost" into an actual date for where you live — free, link in bio 🌱

Save this before the weekend 📌 What are you sowing? 👇

#fallgarden #septembergarden #vegetablegarden #gardeningtips
#growyourown #coolseasoncrops #gardenplanner #falllplanting
```

**Alt text:** "Carousel listing five crops to plant in September — garlic, spinach, radish, arugula and kale — with sowing timing for each."

---

## Pinterest pin

- **Title:** `What to Plant in September — Fall Vegetable Garden Guide`
- **Description:**
```
Five cool-season crops to sow in September before your first frost: garlic,
spinach, radish, arugula and kale. Includes how many weeks before frost to
plant each one and why fall crops taste sweeter. Free fall garden planting
guide with planting windows for your area.
```
- **Link:** `https://sprouttogether.app`
- **Board:** When to Plant (Seasonal Guides)

Seasonal pins do well on Pinterest and resurface every year at the same time —
this one keeps earning long after the Instagram post is gone.

---

## Regenerating

```
python3 marketing/make_september_post.py
```

Edit `CROPS` at the top to swap plants. For an October version, change the month
strings and swap in overwintering crops.
