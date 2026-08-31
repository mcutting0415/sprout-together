#!/usr/bin/env python3
"""Parse the app's curated affiliate products out of shop_page_widget.dart."""
import os, re

HERE = os.path.dirname(os.path.abspath(__file__))
SRC = os.path.join(HERE, "..", "lib/final_app_pages/shop_page/shop_page_widget.dart")

# category -> which plants it is genuinely useful for
UNIVERSAL = {"Seeds", "Soil & Amendments", "Fertilizers", "Watering", "Tools"}
CLIMBERS = {"tomato", "cherry tomato", "bean", "pea", "cucumber", "squash", "zucchini",
            "melon", "watermelon", "cantaloupe", "pumpkin", "grape", "hops", "malabar spinach"}
INDOOR = {"basil", "mint", "chive", "parsley", "cilantro", "oregano", "thyme", "rosemary",
          "sage", "lemon balm", "dill", "microgreen", "lettuce", "arugula"}
PEST_PRONE = {"tomato", "cabbage", "kale", "broccoli", "cauliflower", "potato", "eggplant",
              "cucumber", "squash", "zucchini", "rose", "strawberry", "collard", "bok choy"}


def load_products():
    src = open(SRC).read()
    block = src[src.index("_curatedProducts"):]
    out = []
    for m in re.finditer(r"\{\s*'name':\s*'((?:[^'\\]|\\.)*)'(.*?)\},", block, re.S):
        name, rest = m.group(1), m.group(2)
        g = lambda k: (re.search(k + r"':\s*r?'((?:[^'\\]|\\.)*)'", rest) or [None, None])[1]
        p = {
            "name": name.replace("\\'", "'"),
            "category": g("'category"),
            "store": g("'store_name"),
            "price": g("'price_estimate"),
            "url": g("'affiliate_url"),
            "featured": "'is_featured': true" in rest,
        }
        if p["url"] and p["category"]:
            out.append(p)
    return out


# Plant-specific SKUs (a named seed packet, a tomato pod) must never appear on an
# unrelated plant's page — recommending tomato pods on the basil guide reads as spam.
SPECIFIC = {"Seeds", "Smart Gardens"}
GENERIC = {"Soil & Amendments", "Fertilizers", "Watering", "Tools"}


def _matches_plant(product, plant):
    """True only if the product actually names this plant."""
    n = product["name"].lower()
    stem = plant.rstrip("s")
    return stem in n or plant in n


def products_for_plant(plant, products, n=3):
    """Pick products genuinely relevant to this plant, varied so the block
    isn't byte-identical across 112 pages (which reads as boilerplate)."""
    wanted = set(GENERIC)
    if plant in CLIMBERS:
        wanted.add("Trellises & Supports")
    if plant in INDOOR:
        wanted |= {"Grow Lights", "Smart Gardens", "Pots & Containers"}
    if plant in PEST_PRONE:
        wanted.add("Pest Control")
    # generic gear, plus any plant-specific SKU that actually names this plant
    pool = [p for p in products
            if (p["category"] in wanted and p["category"] not in SPECIFIC)
            or (p["category"] in SPECIFIC and _matches_plant(p, plant))]
    if not pool:
        pool = [p for p in products if p["category"] in GENERIC]
    seed = sum(ord(c) for c in plant)
    picked, seen_cat = [], set()
    for i in range(len(pool)):
        p = pool[(seed + i * 7) % len(pool)]
        if p["category"] in seen_cat:
            continue
        seen_cat.add(p["category"])
        picked.append(p)
        if len(picked) == n:
            break
    return picked


if __name__ == "__main__":
    ps = load_products()
    print(len(ps), "products")
    cats = {}
    for p in ps:
        cats[p["category"]] = cats.get(p["category"], 0) + 1
    print(cats)
    for plant in ["tomato", "basil", "garlic", "carrot"]:
        print(f"\n{plant}:")
        for p in products_for_plant(plant, ps):
            print(f"   [{p['category']}] {p['name'][:52]} — {p['store']} {p['price']}")
