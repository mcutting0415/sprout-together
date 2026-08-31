#!/usr/bin/env python3
"""Post #3 — what to plant in September (northern hemisphere fall sowing).
Crops and timing come from the app's own knowledge base.

Instagram : marketing/september-post/ig-1.png .. ig-7.png  (1080x1350)
Pinterest : marketing/september-post/pin.png               (1000x1500)
"""
import os
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "september-post")
os.makedirs(OUT, exist_ok=True)

CREAM, CREAM_D = (248, 245, 238), (238, 233, 222)
INK, SAGE = (32, 54, 37), (122, 148, 126)
GREEN_TOP, GREEN_BOT = (60, 111, 69), (37, 61, 42)
MINT, MINT_BG = (174, 214, 177), (223, 236, 224)
AMBER, AMBER_BG = (170, 116, 48), (243, 231, 212)
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


def chip(d, xy, text, fg, bg, size=32):
    x, y = xy
    fo = f(SEMI, size)
    tw = d.textlength(text, font=fo)
    h = size + 30
    d.rounded_rectangle([x, y, x + tw + 48, y + h], radius=h // 2, fill=bg)
    d.text((x + 24, y + 14), text, font=fo, fill=fg)
    return x + tw + 48


def footer(im, d, w, h, pad, light=True):
    col = SAGE if light else MINT
    cy = h - pad - 18
    d.ellipse([pad, cy - 9, pad + 18, cy + 9], fill=col)
    d.text((pad + 34, h - pad - 36), "@sprouttogether.app", font=f(SEMI, 28), fill=col)


# timing + notes taken from the app's own bestSeason text
CROPS = [
    ("🧄", "Garlic", "Plant now, harvest next summer",
     "Fall-planted cloves build roots over winter and make much bigger bulbs than spring-planted ones.",
     "Harvest: next July"),
    ("🍃", "Spinach", "8–10 weeks before first frost",
     "Handles frost down to -4°C — and actually tastes sweeter after one.",
     "Ready in ~40 days"),
    ("🌱", "Radish", "6 weeks before first frost",
     "The fastest thing in the garden. Sow a fresh row every two weeks.",
     "Ready in 25–30 days"),
    ("🌿", "Arugula", "Late summer into early fall",
     "Germinates in cool soil and grows best at 45–65°F. Peppery and quick.",
     "Ready in ~30 days"),
    ("🥬", "Kale", "Midsummer to early fall",
     "Survives down to -7°C. Frost converts its starches to sugar, so it sweetens as it gets colder.",
     "Harvest into winter"),
]

W, H, PAD = 1080, 1350, 88

# ---- cover
im = Image.new("RGB", (W, H), CREAM)
d = ImageDraw.Draw(im)
e = emoji("\U0001f342", 96)
im.paste(e, ((W - 96) // 2, 236), e)
tw = tracked_w(d, "SEASONAL GUIDE", f(SEMI, 26), 9)
tracked(d, ((W - tw) / 2, 386), "SEASONAL GUIDE", f(SEMI, 26), SAGE, 9)
y = 466
for line, idx in [("What to plant", 0), ("in September.", 2)]:
    fo = serif(104, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=INK)
    y += 122
d.line([(W / 2 - 46, y + 40), (W / 2 + 46, y + 40)], fill=SAGE, width=3)
draw_wrapped(d, (0, y + 100), "The season isn't over. Five things worth sowing right now.",
             f(REG, 42), (94, 116, 97), W - PAD * 2 - 60, 60, center_w=W)
sy = H - PAD - 128
sw_ = d.textlength("swipe", font=f(SEMI, 30))
d.text(((W - sw_ - 54) / 2, sy), "swipe", font=f(SEMI, 30), fill=SAGE)
ax = (W - sw_ - 54) / 2 + sw_ + 20
d.line([(ax, sy + 21), (ax + 30, sy + 21)], fill=SAGE, width=4)
d.polygon([(ax + 26, sy + 12), (ax + 40, sy + 21), (ax + 26, sy + 30)], fill=SAGE)
footer(im, d, W, H, PAD)
im.save(os.path.join(OUT, "ig-1.png"))

# ---- crop cards
for i, (ch, name, when, why, ready) in enumerate(CROPS, start=2):
    im = Image.new("RGB", (W, H), CREAM if i % 2 == 0 else CREAM_D)
    d = ImageDraw.Draw(im)
    e = emoji(ch, 150)
    im.paste(e, (W - PAD - 150, 224), e)
    d.text((PAD, 218), f"0{i-1}", font=f(BOLD, 54), fill=MINT)
    d.text((PAD, 296), name, font=serif(96, 0), fill=INK)
    y = 452
    tracked(d, (PAD, y), "SOW", f(SEMI, 26), SAGE, 7)
    y = draw_wrapped(d, (PAD, y + 48), when, f(SEMI, 46), (36, 74, 43), W - PAD * 2, 60)
    y = draw_wrapped(d, (PAD, y + 40), why, f(REG, 40), (100, 122, 103), W - PAD * 2 - 30, 56)
    chip(d, (PAD, y + 40), ready, (120, 78, 30), AMBER_BG)
    footer(im, d, W, H, PAD)
    im.save(os.path.join(OUT, f"ig-{i}.png"))

# ---- CTA
im = gradient(W, H)
d = ImageDraw.Draw(im)
av = Image.open(os.path.join(HERE, "sprout-avatar.png")).convert("RGBA").resize((186, 186), Image.LANCZOS)
m = Image.new("L", (186, 186), 0)
ImageDraw.Draw(m).rounded_rectangle([0, 0, 185, 185], radius=44, fill=255)
av.putalpha(m)
im.paste(av, ((W - 186) // 2, 300), av)
y = 556
for line, idx, col in [("Your frost date", 0, WHITE), ("decides everything.", 2, MINT)]:
    fo = serif(84, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 100
draw_wrapped(d, (0, y + 46), "Sprout Together works out planting windows for where you live — so \"6 weeks before frost\" becomes an actual date.",
             f(REG, 38), (214, 231, 215), W - PAD * 2 - 30, 54, center_w=W)
label, fo = "Free on the App Store — link in bio", f(SEMI, 38)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(W - tw - 88) / 2, 1002, (W + tw + 88) / 2, 1092], radius=45, fill=MINT)
d.text(((W - tw) / 2, 1024), label, font=fo, fill=(28, 52, 33))
footer(im, d, W, H, PAD, light=False)
im.save(os.path.join(OUT, "ig-7.png"))

# ---- Pinterest
PW, PH, PP = 1000, 1500, 66
im = Image.new("RGB", (PW, PH), CREAM)
d = ImageDraw.Draw(im)
for yy in range(316):
    t = yy / 316
    d.line([(0, yy), (PW, yy)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
tw = tracked_w(d, "FALL GARDEN GUIDE", f(SEMI, 22), 7)
tracked(d, ((PW - tw) / 2, 62), "FALL GARDEN GUIDE", f(SEMI, 22), MINT, 7)
y = 110
for line, col in [("What to Plant in", WHITE), ("September", MINT)]:
    fo = serif(66, 0)
    d.text(((PW - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 80
fo = f(REG, 27)
sub = "Five cool-season crops to sow before the first frost"
d.text(((PW - d.textlength(sub, font=fo)) / 2, 272), sub, font=fo, fill=(206, 226, 208))

ry = 366
for i, (ch, name, when, why, ready) in enumerate(CROPS):
    rh = 186
    if i % 2 == 0:
        d.rectangle([0, ry - 16, PW, ry + rh - 16], fill=CREAM_D)
    e = emoji(ch, 74)
    im.paste(e, (PP, ry + 24), e)
    d.text((PP + 100, ry + 6), name, font=f(BOLD, 40), fill=INK)
    d.text((PP + 100, ry + 60), when, font=f(SEMI, 28), fill=(64, 126, 76))
    draw_wrapped(d, (PP + 100, ry + 100), why, f(REG, 25), (110, 128, 112), PW - PP * 2 - 110, 32)
    ry += rh

fo = f(SEMI, 34)
line = "Planting windows for 154 plants — free."
d.text(((PW - d.textlength(line, font=fo)) / 2, 1322), line, font=fo, fill=INK)
label, fo = "sprouttogether.app", f(SEMI, 32)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(PW - tw - 80) / 2, 1382, (PW + tw + 80) / 2, 1458], radius=38, fill=(60, 111, 69))
d.text(((PW - tw) / 2, 1401), label, font=fo, fill=WHITE)
im.save(os.path.join(OUT, "pin.png"))

print("wrote", sorted(os.listdir(OUT)))
