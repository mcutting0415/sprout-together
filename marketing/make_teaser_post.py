#!/usr/bin/env python3
"""Coming-soon teaser for the plant scanner. Instagram only — Pinterest is a
search engine and nobody searches for something that doesn't exist yet.

marketing/teaser-post/ig-1.png .. ig-3.png  (1080x1350)
"""
import os
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "teaser-post")
os.makedirs(OUT, exist_ok=True)

CREAM = (248, 245, 238)
INK, SAGE = (32, 54, 37), (122, 148, 126)
GREEN_TOP, GREEN_BOT = (60, 111, 69), (30, 50, 34)
MINT = (174, 214, 177)
WHITE = (255, 255, 255)

FDIR = os.path.join(HERE, "..", "assets", "fonts")
BOLD, SEMI, REG = (os.path.join(FDIR, f"Poppins-{n}.ttf") for n in ("Bold", "SemiBold", "Regular"))
BASK = "/System/Library/Fonts/Supplemental/Baskerville.ttc"
EMOJI = "/System/Library/Fonts/Apple Color Emoji.ttc"
f = lambda p, s: ImageFont.truetype(p, s)
serif = lambda s, i=0: ImageFont.truetype(BASK, s, index=i)

W, H, PAD = 1080, 1350, 88


def gradient():
    im = Image.new("RGB", (W, H), GREEN_TOP)
    d = ImageDraw.Draw(im)
    for y in range(H):
        t = y / H
        d.line([(0, y), (W, y)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
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


def centered(d, y, text, font, fill, maxw, leading):
    for line in wrap(d, text, font, maxw):
        d.text(((W - d.textlength(line, font=font)) / 2, y), line, font=font, fill=fill)
        y += leading
    return y


def footer(im, d, light=False):
    col = SAGE if light else MINT
    cy = H - PAD - 18
    d.ellipse([PAD, cy - 9, PAD + 18, cy + 9], fill=col)
    d.text((PAD + 34, H - PAD - 36), "@sprouttogether.app", font=f(SEMI, 28), fill=col)


# ---- 1. the tease
im = gradient()
d = ImageDraw.Draw(im)
e = emoji("\U0001f50d", 104)
im.paste(e, ((W - 104) // 2, 268), e)
tw = tracked_w(d, "COMING SOON", f(SEMI, 27), 10)
tracked(d, ((W - tw) / 2, 424), "COMING SOON", f(SEMI, 27), MINT, 10)
y = 508
for line, idx, col in [("Point your camera", 0, WHITE), ("at a sick plant.", 2, MINT)]:
    fo = serif(94, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 110
d.line([(W / 2 - 46, y + 44), (W / 2 + 46, y + 44)], fill=MINT, width=3)
centered(d, y + 106, "We'll tell you what's wrong with it.", f(REG, 42), (214, 231, 215), W - PAD * 2 - 60, 58)
sy = H - PAD - 128
sw_ = d.textlength("swipe", font=f(SEMI, 30))
d.text(((W - sw_ - 54) / 2, sy), "swipe", font=f(SEMI, 30), fill=MINT)
ax = (W - sw_ - 54) / 2 + sw_ + 20
d.line([(ax, sy + 21), (ax + 30, sy + 21)], fill=MINT, width=4)
d.polygon([(ax + 26, sy + 12), (ax + 40, sy + 21), (ax + 26, sy + 30)], fill=MINT)
footer(im, d)
im.save(os.path.join(OUT, "ig-1.png"))

# ---- 2. what it does
im = Image.new("RGB", (W, H), CREAM)
d = ImageDraw.Draw(im)
tw = tracked_w(d, "PLANT SCANNER", f(SEMI, 26), 9)
tracked(d, ((W - tw) / 2, 286), "PLANT SCANNER", f(SEMI, 26), SAGE, 9)
y = 360
for line, idx in [("Two things,", 0), ("one photo.", 2)]:
    fo = serif(96, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=INK)
    y += 112

rows = [
    ("\U0001f50e", "Identify", "Not sure what it is? Find out in seconds."),
    ("\U0001fa79", "Diagnose", "Yellowing, spots, wilting — what's causing it and what to do."),
]
ry = 700
for ch, title, body in rows:
    e = emoji(ch, 62)
    im.paste(e, (PAD + 6, ry + 4), e)
    d.text((PAD + 96, ry - 4), title, font=f(BOLD, 46), fill=INK)
    yy = ry + 56
    for line in wrap(d, body, f(REG, 36), W - PAD * 2 - 110):
        d.text((PAD + 96, yy), line, font=f(REG, 36), fill=(100, 122, 103))
        yy += 48
    ry = yy + 54
footer(im, d, light=True)
im.save(os.path.join(OUT, "ig-2.png"))

# ---- 3. when
im = gradient()
d = ImageDraw.Draw(im)
av = Image.open(os.path.join(HERE, "sprout-avatar.png")).convert("RGBA").resize((186, 186), Image.LANCZOS)
m = Image.new("L", (186, 186), 0)
ImageDraw.Draw(m).rounded_rectangle([0, 0, 185, 185], radius=44, fill=255)
av.putalpha(m)
im.paste(av, ((W - 186) // 2, 320), av)
y = 580
for line, idx, col in [("Landing in the app", 0, WHITE), ("very soon.", 2, MINT)]:
    fo = serif(84, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 100
centered(d, y + 52, "Part of Sprout Together Pro. Follow so you don't miss it.",
         f(REG, 40), (214, 231, 215), W - PAD * 2 - 40, 56)
label, fo = "Sprout Together — free on the App Store", f(SEMI, 34)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(W - tw - 80) / 2, 1010, (W + tw + 80) / 2, 1094], radius=42, fill=MINT)
d.text(((W - tw) / 2, 1032), label, font=fo, fill=(28, 52, 33))
footer(im, d)
im.save(os.path.join(OUT, "ig-3.png"))

print("wrote", sorted(os.listdir(OUT)))
