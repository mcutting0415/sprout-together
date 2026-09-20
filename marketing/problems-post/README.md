# Post #4 — "What's wrong with my plant?"

Every symptom, cause and fix comes from the app's own `commonProblems` data
(`lib/final_app_pages/plant_details_page/plant_knowledge_base.dart`).

| File | Where | Size |
|---|---|---|
| `ig-1.png` … `ig-8.png` | Instagram carousel, in order | 1080×1350 (4:5) |
| `pin.png` | Pinterest, single pin | 1000×1500 (2:3) |

This one is deliberately problem-first. It also sets up the scanner
announcement later — people who saved this are exactly the people who want a
camera that does it for them.

---

## Instagram caption

```
Six things your garden is trying to tell you 🔍

Most plant problems look alike until you know what to look for. Here's how to read them:

🍅 Dark sunken patch on the tomato → blossom end rot. Not a disease — uneven watering. Water consistently and it stops.
🌿 Brown spots with yellow halos → early blight. Remove those leaves, water the soil not the foliage.
🥒 White powdery coating → powdery mildew. More airflow. Late in the season it's normal.
🥬 Holes chewed through leaves → slugs. Copper tape or a beer trap. Go look after dark.
🪴 Sudden wilt + sawdust at the stem → squash vine borer. Foil-wrap the stems next season.
🍂 Brown crispy leaf edges → tip burn. Calcium isn't reaching the edges. Keep moisture steady.

Save this for the next time something looks off 📌

Every plant in Sprout Together has its own pest and disease notes — free, link in bio 🌱

What's the one you can never diagnose? 👇

#gardenproblems #plantcare #vegetablegarden #gardeningtips #growyourown
#plantdisease #organicgardening #beginnergardener
```

**Alt text:** "Guide to six common vegetable garden problems — blossom end rot, early blight, powdery mildew, slugs, squash vine borer and tip burn — with causes and fixes."

---

## Pinterest pin

- **Title:** `What's Wrong With My Plant? Garden Problem Chart`
- **Description:**
```
A quick troubleshooting chart for common vegetable garden problems. Learn what
blossom end rot, early blight, powdery mildew, slug damage, squash vine borer
and tip burn look like — what causes each one, and how to fix it. Save this
garden problem guide for the growing season.
```
- **Link:** `https://sprouttogether.app`
- **Board:** Harvest Tips & Timing (or make a "Plant Problems" board — it's a
  high-search topic and worth its own)

"What's wrong with my plant" is a phrase people genuinely search, year after
year. Expect this to be your best-performing pin over time.

---

## Regenerating

```
python3 marketing/make_problems_post.py
```

Edit `PROBLEMS` at the top to swap symptoms.
