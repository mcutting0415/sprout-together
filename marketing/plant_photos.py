#!/usr/bin/env python3
"""Slug -> verified plant photo URL, shared by the pin builder and the site builder.

Photos come from the app's own verified Unsplash maps in
`lib/final_app_pages/plant_library_page/plant_images.dart`, so the site and the
app show the same picture for the same plant and can't drift apart.

Site slugs that have no key of their own in those maps are mapped by hand in
ALIASES below. A handful of plants have no verified photo at all; they are
returned as misses and the pin builder gives them a text-only design rather
than a wrong picture.
"""
import os, re

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..")
DART = os.path.join(ROOT, "lib/final_app_pages/plant_library_page/plant_images.dart")
UNSPLASH = "https://images.unsplash.com/photo-"

# Site slug -> key in the app's image maps.
ALIASES = {
    "arugula":              "arugula (wild/rocket)",
    "bean":                 "green bean",
    "buckwheat":            "buckwheat (cover crop)",
    "chard":                "swiss chard",
    "clover":               "crimson clover",
    "currant":              "currant (red)",
    "jerusalem-artichoke":  "jerusalem artichoke / sunchoke",
    "microgreens":          "microgreens mix",
    "nigella":              "nigella / love-in-a-mist",
    "passionflower":        "passionflower (medicinal)",
    "pea":                  "sugar snap pea",
    "squash":               "winter squash",
    "winter-rye":           "winter rye (cover crop)",
}


def _parse_map(src, name, quality):
    m = re.search(r"const Map<String, String> " + name + r" = \{(.*?)\n\};", src, re.S)
    if not m:
        return {}
    out = {}
    for k, v in re.findall(r"'([^']+)':\s*'((?:[^'\\]|\\.)*)'", m.group(1)):
        v = v.replace("${_u}", UNSPLASH).replace("$_q", quality)
        if v.startswith("http"):
            out[k] = v
    return out


def photo_urls(quality="?w=1600&auto=format&fit=crop&q=85"):
    """Returns {slug: url} for every plant that has a verified photo."""
    src = open(DART).read()
    # Verified wins over the older fallback map, same precedence as the app.
    merged = {**_parse_map(src, "kPlantImageFallbacks", quality),
              **_parse_map(src, "kPlantImageVerified", quality)}
    slugify = lambda n: re.sub(r"[^a-z0-9]+", "-", n.lower()).strip("-")

    by_slug = {slugify(k): v for k, v in merged.items()}
    for slug, key in ALIASES.items():
        if key in merged:
            by_slug[slug] = merged[key]
    return by_slug


if __name__ == "__main__":
    urls = photo_urls()
    site = os.path.join(ROOT, "site-deploy", "plants")
    slugs = sorted(d for d in os.listdir(site) if os.path.isdir(os.path.join(site, d)))
    missing = [s for s in slugs if s not in urls]
    print(f"{len(slugs) - len(missing)}/{len(slugs)} slugs have a verified photo")
    print("no photo:", ", ".join(missing) or "none")
