#!/usr/bin/env python3
"""Per-plant imagery for the site and for Pinterest.

For every plant guide on sprouttogether.app this writes:

  site-deploy/img/plants/<slug>.jpg   1200x675  page hero + per-page og:image
  plant-pins/<slug>.png               1000x1500 Pinterest pin

Photos come from the app's verified Unsplash maps (see plant_photos.py). The
seven plants with no verified photo get a text-only pin in the brand palette
rather than a picture of the wrong plant.

Run:  python3 make_plant_pins.py [slug ...]      (no args = all plants)
"""
import os, re, sys, json, urllib.request
from PIL import Image, ImageDraw, ImageFont, ImageFilter

from build_plant_guides import load_knowledge, load_companions
from plant_photos import photo_urls

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..")
SITE_IMG = os.path.join(ROOT, "site-deploy", "img", "plants")
PINS = os.path.join(HERE, "plant-pins")
CACHE = os.path.join(HERE, ".photo-cache")

GREEN_DARK, GREEN, MINT = (47, 74, 52), (60, 111, 69), (174, 214, 177)
CREAM, INK, MUTED, WHITE = (244, 248, 242), (30, 44, 34), (92, 107, 98), (255, 255, 255)

FDIR = os.path.join(ROOT, "assets", "fonts")
BOLD = os.path.join(FDIR, "Poppins-Bold.ttf")
SEMI = os.path.join(FDIR, "Poppins-SemiBold.ttf")
REG = os.path.join(FDIR, "Poppins-Regular.ttf")
BASK = "/System/Library/Fonts/Supplemental/Baskerville.ttc"
f = lambda p, s: ImageFont.truetype(p, s)


# ── text helpers ─────────────────────────────────────────────────────────────
def wrap(draw, text, font, width):
    lines, line = [], ""
    for word in text.split():
        trial = (line + " " + word).strip()
        if draw.textlength(trial, font=font) <= width:
            line = trial
        else:
            if line:
                lines.append(line)
            line = word
    if line:
        lines.append(line)
    return lines


def first_sentence(s, limit=95):
    """First clause of a guide field, short enough to read on a pin."""
    s = re.sub(r"\s+", " ", s).strip()
    m = re.match(r"(.+?[.!?])(\s|$)", s)
    s = m.group(1) if m else s
    if len(s) > limit:
        cut = s[:limit].rsplit(" ", 1)[0]
        s = cut.rstrip(" ,;—-") + "…"
    return s


def tracked(draw, xy, text, font, fill, space=3):
    x, y = xy
    for ch in text:
        draw.text((x, y), ch, font=font, fill=fill)
        x += draw.textlength(ch, font=font) + space
    return x


# ── photo ────────────────────────────────────────────────────────────────────
def fetch(slug, url):
    os.makedirs(CACHE, exist_ok=True)
    path = os.path.join(CACHE, slug + ".jpg")
    if os.path.exists(path) and os.path.getsize(path) > 10_000:
        return path
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
    with urllib.request.urlopen(req, timeout=45) as r, open(path, "wb") as out:
        out.write(r.read())
    return path


def cover(path, w, h):
    im = Image.open(path).convert("RGB")
    sw, sh = im.size
    scale = max(w / sw, h / sh)
    im = im.resize((max(w, int(sw * scale)), max(h, int(sh * scale))), Image.LANCZOS)
    nw, nh = im.size
    # Bias the crop slightly above centre - plants sit in the top of the frame.
    return im.crop(((nw - w) // 2, max(0, int((nh - h) * 0.40)),
                    (nw - w) // 2 + w, max(0, int((nh - h) * 0.40)) + h))


def gradient(size, top_alpha, bottom_alpha, colour):
    w, h = size
    layer = Image.new("RGBA", size, colour + (0,))
    d = ImageDraw.Draw(layer)
    for y in range(h):
        t = y / max(1, h - 1)
        t = t * t * (3 - 2 * t)   # smoothstep: no visible edge where it starts
        d.line([(0, y), (w, y)],
               fill=colour + (int(top_alpha + (bottom_alpha - top_alpha) * t),))
    return layer


# ── outputs ──────────────────────────────────────────────────────────────────
def build_hero(slug, title, photo):
    """1200x675 - the guide page hero and that page's og:image."""
    W, H = 1200, 675
    im = (cover(photo, W, H) if photo else Image.new("RGB", (W, H), GREEN)).convert("RGBA")
    if not photo:
        im.alpha_composite(gradient((W, H), 0, 90, GREEN_DARK))
    im.alpha_composite(gradient((W, int(H * 0.55)), 150, 0, (12, 24, 15)).transpose(
        Image.FLIP_TOP_BOTTOM), (0, H - int(H * 0.55)))
    d = ImageDraw.Draw(im)
    tracked(d, (56, H - 168), "HOW TO GROW", f(SEMI, 22), MINT, 5)
    d.text((52, H - 130), title, font=f(BASK, 74), fill=WHITE)
    d.text((56, H - 46), "sprouttogether.app", font=f(REG, 22), fill=(255, 255, 255, 200))
    os.makedirs(SITE_IMG, exist_ok=True)
    im.convert("RGB").save(os.path.join(SITE_IMG, slug + ".jpg"), quality=86, optimize=True)


def build_pin(slug, name, title, photo, facts):
    """1000x1500 - Pinterest's 2:3. Photo on top, the useful bit underneath."""
    W, H = 1000, 1500
    # Without a photo there is nothing to look at, so the brand band is kept
    # short and carries the mark rather than 790px of flat green.
    PHOTO_H = 790 if photo else 470
    im = Image.new("RGBA", (W, H), CREAM + (255,))

    if photo:
        im.paste(cover(photo, W, PHOTO_H).convert("RGBA"), (0, 0))
    else:
        band = Image.new("RGBA", (W, PHOTO_H), GREEN + (255,))
        band.alpha_composite(gradient((W, PHOTO_H), 0, 120, GREEN_DARK))
        im.paste(band, (0, 0))
        mark = Image.open(os.path.join(ROOT, "site-deploy", "img", "logo.png")).convert("RGBA")
        mark.thumbnail((190, 190), Image.LANCZOS)
        im.alpha_composite(mark, ((W - mark.size[0]) // 2, 130))
    im.alpha_composite(gradient((W, 230), 0, 255, CREAM), (0, PHOTO_H - 230))

    d = ImageDraw.Draw(im)
    y = PHOTO_H - 40

    tracked(d, (72, y), "HOW TO GROW", f(SEMI, 26), GREEN, 6)
    y += 52

    for line in wrap(d, title, f(BASK, 104), W - 144):
        d.text((68, y), line, font=f(BASK, 104), fill=GREEN_DARK)
        y += 108
    y += 18

    d.line([(72, y), (152, y)], fill=MINT, width=6)
    y += 44

    for label, value in facts:
        if not value:
            continue
        tracked(d, (72, y), label.upper(), f(SEMI, 22), GREEN, 4)
        y += 40
        for line in wrap(d, value, f(REG, 31), W - 150):
            d.text((72, y), line, font=f(REG, 31), fill=INK)
            y += 43
        y += 26

    d.rectangle([0, H - 96, W, H], fill=GREEN_DARK)
    d.text((72, H - 68), "sprouttogether.app", font=f(SEMI, 30), fill=WHITE)
    tracked(d, (W - 232, H - 62), "FREE APP", f(SEMI, 26), MINT, 4)

    os.makedirs(PINS, exist_ok=True)
    im.convert("RGB").save(os.path.join(PINS, slug + ".png"))


# ── driver ───────────────────────────────────────────────────────────────────
def main(only=None):
    knowledge, companions, urls = load_knowledge(), load_companions(), photo_urls()
    slugify = lambda n: re.sub(r"[^a-z0-9]+", "-", n.lower()).strip("-")

    made, no_photo, failed = 0, [], []
    index = {}
    for name in sorted(knowledge):
        slug = slugify(name)
        if only and slug not in only:
            continue
        title = name.title().replace("'S", "'s")

        photo = None
        if slug in urls:
            try:
                photo = fetch(slug, urls[slug])
            except Exception as e:
                failed.append(f"{slug} ({e})")
        else:
            no_photo.append(slug)

        good = companions.get(name, {}).get("good", [])
        facts = [
            ("When to plant", first_sentence(knowledge[name]["bestSeason"])),
            ("Plant it with", ", ".join(g.title() for g in good[:3]) if good else ""),
            ("Know it's ready", first_sentence(knowledge[name]["harvestSigns"], 88)),
        ]

        build_hero(slug, title, photo)
        build_pin(slug, name, f"How to Grow {title}", photo, facts)
        index[slug] = {"title": title, "has_photo": bool(photo)}
        made += 1

    json.dump(index, open(os.path.join(HERE, "plant-pins", "index.json"), "w"), indent=1)
    print(f"{made} heroes -> site-deploy/img/plants/, {made} pins -> marketing/plant-pins/")
    if no_photo:
        print(f"text-only (no verified photo): {', '.join(no_photo)}")
    if failed:
        print(f"download failed: {', '.join(failed)}")


if __name__ == "__main__":
    main(set(sys.argv[1:]) or None)
