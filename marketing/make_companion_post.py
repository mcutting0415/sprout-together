#!/usr/bin/env python3
"""Post #2 — companion planting. Pairs come from the app's own dataset
(lib/services/companion_planting_service.dart), so the post and the app agree.

Instagram : marketing/companion-post/ig-1.png .. ig-7.png  (1080x1350)
Pinterest : marketing/companion-post/pin.png               (1000x1500)
"""
import os
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "companion-post")
os.makedirs(OUT, exist_ok=True)

CREAM, CREAM_D = (248, 245, 238), (238, 233, 222)
INK, SAGE = (32, 54, 37), (122, 148, 126)
GREEN_TOP, GREEN_BOT = (60, 111, 69), (37, 61, 42)
MINT, MINT_BG = (174, 214, 177), (223, 236, 224)
CLAY, CLAY_BG = (166, 92, 70), (241, 224, 218)
WHITE = (255, 255, 255)

FDIR = os.path.join(HERE, "..", "assets", "fonts")
BOLD, SEMI, REG = (os.path.join(FDIR, f"Poppins-{n}.ttf") for n in ("Bold", "SemiBold", "Regular"))
BASK = "/System/Library/Fonts/Supplemental/Baskerville.ttc"
EMOJI = "/System/Library/Fonts/Apple Color Emoji.ttc"
f = lambda p, s: ImageFont.truetype(p, s)
serif = lambda s, i=0: ImageFont.truetype(BASK, s, index=i)


def gradient(w, h):
    im = Image.new("RGB", (w, h), GREEN_TOP)
    d = ImageDraw.Draw(im)
    for y in range(h):
        t = y / h
        d.line([(0, y), (w, y)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
    return im


def emoji(ch, size):
    src = Image.new("RGBA", (200, 200), (0, 0, 0, 0))
    ImageDraw.Draw(src).text((10, 10), ch, font=f(EMOJI, 160), embedded_color=True)
    return src.crop(src.getbbox()).resize((size, size), Image.LANCZOS)


def tracked(d, xy, text, font, fill, track):
    x, y = xy
    for ch in text:
        d.text((x, y), ch, font=font, fill=fill)
        x += d.textlength(ch, font=font) + track
    return x


def tracked_w(d, text, font, track):
    return sum(d.textlength(c, font=font) + track for c in text) - track


def chips(d, x, y, items, fg, bg, maxx, size=34):
    """Flow-wrap rounded pills."""
    fo, cx, cy, h = f(SEMI, size), x, y, size + 30
    for it in items:
        w = d.textlength(it, font=fo) + 46
        if cx + w > maxx:
            cx, cy = x, cy + h + 16
        d.rounded_rectangle([cx, cy, cx + w, cy + h], radius=(h // 2), fill=bg)
        d.text((cx + 23, cy + 14), it, font=fo, fill=fg)
        cx += w + 14
    return cy + h


def wrap(d, text, font, maxw):
    lines, cur = [], ""
    for w in text.split():
        t = (cur + " " + w).strip()
        if d.textlength(t, font=font) <= maxw:
            cur = t
        else:
            lines.append(cur); cur = w
    if cur: lines.append(cur)
    return lines


def draw_wrapped(d, xy, text, font, fill, maxw, leading, center_w=None):
    x, y = xy
    for line in wrap(d, text, font, maxw):
        px = (center_w - d.textlength(line, font=font)) / 2 if center_w else x
        d.text((px, y), line, font=font, fill=fill)
        y += leading
    return y


def tick(d, x, y, col):
    d.line([(x, y + 10), (x + 9, y + 19), (x + 25, y - 2)], fill=col, width=5, joint="curve")


def cross(d, x, y, col):
    d.line([(x + 2, y - 1), (x + 21, y + 18)], fill=col, width=5)
    d.line([(x + 21, y - 1), (x + 2, y + 18)], fill=col, width=5)


def footer(im, d, w, h, pad, light=True):
    col = SAGE if light else MINT
    cy = h - pad - 18
    d.ellipse([pad, cy - 9, pad + 18, cy + 9], fill=col)
    d.text((pad + 34, h - pad - 36), "@sprouttogether.app", font=f(SEMI, 28), fill=col)


# straight from the app's companion dataset
PAIRS = [
    ("🍅", "Tomato",   ["Basil", "Marigold", "Carrot", "Parsley", "Borage"],
                       ["Fennel", "Corn", "Cabbage"],
                       "Basil repels aphids and improves flavor. Marigolds deter nematodes."),
    ("🥕", "Carrot",   ["Onion", "Leek", "Lettuce", "Rosemary", "Sage"],
                       ["Dill", "Parsnip"],
                       "Onions and leeks repel carrot fly. Dill stunts carrot growth."),
    ("🥬", "Lettuce",  ["Carrot", "Radish", "Strawberry", "Onion", "Garlic"],
                       ["Celery", "Parsley"],
                       "Radishes act as a trap crop, luring flea beetles away from lettuce."),
    ("🥒", "Cucumber", ["Beans", "Peas", "Radish", "Sunflower", "Nasturtium"],
                       ["Potato", "Sage", "Fennel"],
                       "Nasturtiums repel aphids and cucumber beetles. Sunflowers give shade."),
]

# ================================================================ INSTAGRAM
W, H, PAD = 1080, 1350, 88

# ---- cover
im = Image.new("RGB", (W, H), CREAM)
d = ImageDraw.Draw(im)
e = emoji("\U0001f91d", 96)
im.paste(e, ((W - 96) // 2, 236), e)
tw = tracked_w(d, "COMPANION PLANTING", f(SEMI, 26), 9)
tracked(d, ((W - tw) / 2, 386), "COMPANION PLANTING", f(SEMI, 26), SAGE, 9)
y = 466
for line, idx in [("Plant these", 0), ("together.", 2)]:
    fo = serif(114, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=INK)
    y += 130
d.line([(W / 2 - 46, y + 40), (W / 2 + 46, y + 40)], fill=SAGE, width=3)
draw_wrapped(d, (0, y + 100), "The right neighbors mean fewer pests and a bigger harvest — for free.",
             f(REG, 42), (94, 116, 97), W - PAD * 2 - 60, 60, center_w=W)
sy = H - PAD - 128
sw_ = d.textlength("swipe", font=f(SEMI, 30))
d.text(((W - sw_ - 54) / 2, sy), "swipe", font=f(SEMI, 30), fill=SAGE)
ax = (W - sw_ - 54) / 2 + sw_ + 20
d.line([(ax, sy + 21), (ax + 30, sy + 21)], fill=SAGE, width=4)
d.polygon([(ax + 26, sy + 12), (ax + 40, sy + 21), (ax + 26, sy + 30)], fill=SAGE)
footer(im, d, W, H, PAD)
im.save(os.path.join(OUT, "ig-1.png"))

# ---- pair cards
for i, (ch, name, good, bad, tip) in enumerate(PAIRS, start=2):
    im = Image.new("RGB", (W, H), CREAM if i % 2 == 0 else CREAM_D)
    d = ImageDraw.Draw(im)
    e = emoji(ch, 150)
    im.paste(e, (W - PAD - 150, 212), e)
    d.text((PAD, 248), name, font=serif(96, 0), fill=INK)

    y = 452
    tracked(d, (PAD, y), "PLANT WITH", f(SEMI, 26), SAGE, 7)
    y = chips(d, PAD, y + 52, good, (36, 74, 43), MINT_BG, W - PAD)

    y += 74
    tracked(d, (PAD, y), "KEEP APART", f(SEMI, 26), CLAY, 7)
    y = chips(d, PAD, y + 52, bad, (122, 58, 40), CLAY_BG, W - PAD)

    d.line([(PAD, y + 82), (W - PAD, y + 82)], fill=(216, 210, 196), width=2)
    draw_wrapped(d, (PAD, y + 118), tip, serif(40, 2), (94, 116, 97), W - PAD * 2, 54)
    footer(im, d, W, H, PAD)
    im.save(os.path.join(OUT, f"ig-{i}.png"))

# ---- fennel warning
im = Image.new("RGB", (W, H), (247, 238, 234))
d = ImageDraw.Draw(im)
e = emoji("\U0001f6ab", 110)
im.paste(e, ((W - 110) // 2, 244), e)
y = 416
for line, idx in [("The one plant", 0), ("nobody wants.", 2)]:
    fo = serif(96, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=(104, 48, 32))
    y += 112
fo = f(BOLD, 148)
d.text(((W - d.textlength("Fennel", font=fo)) / 2, y + 54), "Fennel", font=fo, fill=CLAY)
draw_wrapped(d, (0, y + 250),
             "37 of the 68 plants in Sprout Together list fennel as one to keep away from. Give it a pot of its own.",
             f(REG, 42), (126, 88, 76), W - PAD * 2 - 40, 58, center_w=W)
footer(im, d, W, H, PAD)
im.save(os.path.join(OUT, "ig-6.png"))

# ---- CTA
im = gradient(W, H)
d = ImageDraw.Draw(im)
av = Image.open(os.path.join(HERE, "sprout-avatar.png")).convert("RGBA").resize((186, 186), Image.LANCZOS)
m = Image.new("L", (186, 186), 0)
ImageDraw.Draw(m).rounded_rectangle([0, 0, 185, 185], radius=44, fill=255)
av.putalpha(m)
im.paste(av, ((W - 186) // 2, 300), av)
y = 556
for line, idx, col in [("Check any pair", 0, WHITE), ("before you plant.", 2, MINT)]:
    fo = serif(88, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 104
draw_wrapped(d, (0, y + 46), "Tap any plant in Sprout Together to see its companions — all 68, free.",
             f(REG, 40), (214, 231, 215), W - PAD * 2 - 40, 56, center_w=W)
label, fo = "Free on the App Store — link in bio", f(SEMI, 38)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(W - tw - 88) / 2, 1000, (W + tw + 88) / 2, 1090], radius=45, fill=MINT)
d.text(((W - tw) / 2, 1022), label, font=fo, fill=(28, 52, 33))
footer(im, d, W, H, PAD, light=False)
im.save(os.path.join(OUT, "ig-7.png"))

# ================================================================ PINTEREST — cheat sheet
PW, PH, PP = 1000, 1500, 64
im = Image.new("RGB", (PW, PH), CREAM)
d = ImageDraw.Draw(im)
for yy in range(300):
    t = yy / 300
    d.line([(0, yy), (PW, yy)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
tw = tracked_w(d, "SAVE FOR PLANTING SEASON", f(SEMI, 22), 7)
tracked(d, ((PW - tw) / 2, 56), "SAVE FOR PLANTING SEASON", f(SEMI, 22), MINT, 7)
y = 100
for line, idx, col in [("Companion Planting", 0, WHITE), ("Cheat Sheet", 0, MINT)]:
    fo = serif(66, idx)
    d.text(((PW - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 78
fo = f(REG, 27)
sub = "What to plant together — and what to keep apart"
d.text(((PW - d.textlength(sub, font=fo)) / 2, 262), sub, font=fo, fill=(206, 226, 208))

ROWS = [(n, g[:4], b[:3]) for _, n, g, b, _ in PAIRS] + [
    ("Beans", ["Carrot", "Corn", "Cucumber", "Radish"], ["Onion", "Garlic", "Fennel"]),
    ("Strawberry", ["Lettuce", "Spinach", "Thyme", "Borage"], ["Cabbage", "Fennel", "Garlic"]),
]
ry = 348
for i, (name, good, bad) in enumerate(ROWS):
    rh = 158
    if i % 2 == 0:
        d.rectangle([0, ry - 14, PW, ry + rh - 14], fill=CREAM_D)
    d.text((PP, ry + 4), name, font=f(BOLD, 38), fill=INK)
    tick(d, PP, ry + 70, (64, 126, 76))
    d.text((PP + 44, ry + 60), ", ".join(good), font=f(REG, 29), fill=(70, 96, 74))
    cross(d, PP, ry + 112, CLAY)
    d.text((PP + 44, ry + 104), ", ".join(bad), font=f(REG, 29), fill=(150, 96, 78))
    ry += rh

fo = f(SEMI, 36)
line = "68 plants, all their pairings — free."
d.text(((PW - d.textlength(line, font=fo)) / 2, 1320), line, font=fo, fill=INK)
label, fo = "sprouttogether.app", f(SEMI, 32)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(PW - tw - 80) / 2, 1382, (PW + tw + 80) / 2, 1458], radius=38, fill=(60, 111, 69))
d.text(((PW - tw) / 2, 1401), label, font=fo, fill=WHITE)
im.save(os.path.join(OUT, "pin.png"))

print("wrote", sorted(os.listdir(OUT)))
