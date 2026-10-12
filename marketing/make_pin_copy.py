#!/usr/bin/env python3
"""Copy-paste Pinterest text for every plant pin -> plant-pins/PINS.md.

One section per plant: title, description and destination link, ready to paste
into Pinterest's create form. Descriptions are built from each plant's own
guide data rather than a template, because Pinterest suppresses pins whose
descriptions are near-duplicates of each other.

Ordered for posting: the plants people actually search for in autumn first,
then everything else alphabetically.

Run:  python3 make_pin_copy.py
"""
import os, re

from build_plant_guides import load_knowledge, load_companions

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "plant-pins", "PINS.md")
BASE = "https://sprouttogether.app/plants"

# Autumn search order: what Pinterest is actually being asked in Oct-Nov.
FALL_FIRST = """garlic spinach kale winter-rye clover arugula lettuce radish
bok-choy turnip beet carrot chard onion leek pea broccoli cauliflower cabbage
buckwheat""".split()

TITLE_MAX, DESC_MAX = 100, 500
slugify = lambda n: re.sub(r"[^a-z0-9]+", "-", n.lower()).strip("-")


def clause(s, limit):
    """Opening of a guide field, trimmed to fit.

    Takes a second sentence when the first is a fragment like "Strictly
    cool-season" - on its own that reads as a cut-off description.
    """
    s = re.sub(r"\s+", " ", s).strip()
    sentences = re.findall(r".+?(?:[.!?]|$)", s)
    out = ""
    for sent in sentences:
        cand = (out + " " + sent).strip()
        if out and len(cand) > limit:
            break
        out = cand
        if len(out) >= 45:
            break
    out = out.rstrip(".").strip()
    if len(out) > limit:
        out = out[:limit].rsplit(" ", 1)[0].rstrip(" ,;—-")
    return out


def title_for(disp):
    for cand in (f"How to Grow {disp}: When to Plant, Care & Harvest",
                 f"How to Grow {disp}: When to Plant & Harvest",
                 f"How to Grow {disp}"):
        if len(cand) <= TITLE_MAX:
            return cand
    return f"Growing {disp}"[:TITLE_MAX]


OPENERS = [
    "Everything you need to grow {low}:",
    "Growing {low}, start to finish.",
    "How to grow {low} and actually get a crop.",
    "A straightforward guide to growing {low}.",
]


def description_for(disp, rec, comp, n=0):
    low = disp.lower()
    opener = OPENERS[n % len(OPENERS)].format(low=low)
    fact = clause(rec["bestSeason"], 150)
    fact = fact[0].lower() + fact[1:] if opener.endswith(":") else fact
    parts = [f"{opener} {fact}."]
    good = comp.get("good", []) if comp else []
    if good:
        parts.append(
            f"Plant it near {', '.join(g.lower() for g in good[:3])}"
            + (f", and keep it away from {comp['bad'][0].lower()}." if comp.get("bad") else "."))
    parts.append("Includes soil and feeding, what usually goes wrong, "
                 "and how to know when it's ready.")
    parts.append("Free growing guide from Sprout Together.")

    tidy = lambda ps: re.sub(r"\s+", " ", " ".join(ps)).strip()
    out = tidy(parts)
    while len(out) > DESC_MAX and len(parts) > 2:
        parts.pop(-2)
        out = tidy(parts)
    return out[:DESC_MAX]


def main():
    kb, comps = load_knowledge(), load_companions()
    by_slug = {slugify(n): n for n in kb}

    ordered = [s for s in FALL_FIRST if s in by_slug]
    ordered += [s for s in sorted(by_slug) if s not in ordered]

    out = [
        "# Pinterest copy for the plant pins",
        "",
        f"One section per pin, {len(ordered)} in total. Images are the `.png` files",
        "beside this file. Paste the title and description into Pinterest's create",
        "form and set the destination to the link given.",
        "",
        "**Post about five a day, not all at once** - a young account publishing in",
        "bursts gets read as spam and throttled. The order below is deliberate: autumn",
        "searches first, because nobody is looking up tomatoes in October.",
        "",
        "Link each pin to its **plant guide**, never straight to the App Store. The",
        "guide carries the same photo as the pin, so Pinterest can see the image",
        "really lives at the destination, and the App Store button is already on it.",
        "",
        "---",
        "",
    ]

    for i, slug in enumerate(ordered, 1):
        name = by_slug[slug]
        disp = name.title().replace("'S", "'s")
        t = title_for(disp)
        d = description_for(disp, kb[name], comps.get(name), i)
        marker = "  *(autumn)*" if slug in FALL_FIRST else ""
        out += [
            f"## {i}. {disp}{marker}",
            "",
            f"**Image:** `{slug}.png`  ",
            f"**Link:** {BASE}/{slug}/",
            "",
            f"**Title** ({len(t)}/{TITLE_MAX})",
            "```", t, "```",
            "",
            f"**Description** ({len(d)}/{DESC_MAX})",
            "```", d, "```",
            "",
        ]

    open(OUT, "w").write("\n".join(out))
    print(f"{len(ordered)} pins -> {os.path.relpath(OUT, HERE)}")
    print(f"first ten: {', '.join(ordered[:10])}")


if __name__ == "__main__":
    main()
