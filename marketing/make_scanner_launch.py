#!/usr/bin/env python3
"""Plant Scanner launch: Instagram carousel + Pinterest pin, built from real
app captures (Scanner.PNG, Diagnose.PNG).

marketing/scanner-launch/ig-1.png .. ig-4.png  (1080x1350)
marketing/scanner-launch/pin.png               (1000x1500)
"""
import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "scanner-launch")
os.makedirs(OUT, exist_ok=True)

CREAM, CREAM_D = (248, 245, 238), (238, 233, 222)
INK, SAGE = (32, 54, 37), (122, 148, 126)
GREEN_TOP, GREEN_BOT = (60, 111, 69), (33, 55, 38)
MINT, WHITE = (174, 214, 177), (255, 255, 255)

FDIR = os.path.join(HERE, "..", "assets", "fonts")
BOLD, SEMI, REG = (os.path.join(FDIR, f"Poppins-{n}.ttf") for n in ("Bold", "SemiBold", "Regular"))
BASK = "/System/Library/Fonts/Supplemental/Baskerville.ttc"
f = lambda p, s: ImageFont.truetype(p, s)
serif = lambda s, i=0: ImageFont.truetype(BASK, s, index=i)


def gradient(w, h):
    im = Image.new("RGB", (w, h), GREEN_TOP)
    d = ImageDraw.Draw(im)
    for y in range(h):
        t = y / h
        d.line([(0, y), (w, y)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
    return im


def phone(name, target_h, crop_bot=1.0):
    src = Image.open(os.path.join(HERE, name)).convert("RGB")
    src = src.crop((0, 0, src.width, int(src.height * crop_bot)))
    r = target_h / src.height
    sw, sh = int(src.width * r), target_h
    src = src.resize((sw, sh), Image.LANCZOS)
    bez, rad = 14, 52
    fw, fh = sw + bez * 2, sh + bez * 2
    fr = Image.new("RGBA", (fw, fh), (0, 0, 0, 0))
    ImageDraw.Draw(fr).rounded_rectangle([0, 0, fw - 1, fh - 1], radius=rad, fill=(24, 38, 27, 255))
    m = Image.new("L", (sw, sh), 0)
    ImageDraw.Draw(m).rounded_rectangle([0, 0, sw - 1, sh - 1], radius=rad - bez, fill=255)
    fr.paste(src, (bez, bez), m)
    pad = 60
    out = Image.new("RGBA", (fw + pad * 2, fh + pad * 2), (0, 0, 0, 0))
    sl = Image.new("RGBA", out.size, (0, 0, 0, 0))
    ImageDraw.Draw(sl).rounded_rectangle([pad, pad + 16, pad + fw, pad + fh + 16], radius=rad, fill=(20, 35, 24, 90))
    out.alpha_composite(sl.filter(ImageFilter.GaussianBlur(26)))
    out.alpha_composite(fr, (pad, pad))
    return out


def tracked(d, cx, y, text, font, fill, track):
    w = sum(d.textlength(c, font=font) + track for c in text) - track
    x = cx - w / 2
    for c in text:
        d.text((x, y), c, font=font, fill=fill)
        x += d.textlength(c, font=font) + track


def centered(d, cx, y, text, font, fill):
    d.text((cx - d.textlength(text, font=font) / 2, y), text, font=font, fill=fill)


def footer(d, w, h, pad, col):
    cy = h - pad - 18
    d.ellipse([pad, cy - 9, pad + 18, cy + 9], fill=col)
    d.text((pad + 34, h - pad - 36), "@sprouttogether.app", font=f(SEMI, 28), fill=col)


W, H, PAD = 1080, 1350, 88

# ---- 1. hook
im = gradient(W, H)
d = ImageDraw.Draw(im)
tracked(d, W / 2, 300, "NEW IN SPROUT TOGETHER", f(SEMI, 27), MINT, 9)
for i, (line, idx, col) in enumerate([("Point your camera", 0, WHITE), ("at any plant.", 2, MINT)]):
    centered(d, W / 2, 390 + i * 116, line, serif(100, idx), col)
d.line([(W / 2 - 46, 668), (W / 2 + 46, 668)], fill=MINT, width=3)
centered(d, W / 2, 720, "Find out what it is.", f(REG, 46), (220, 235, 221))
centered(d, W / 2, 784, "Or what's wrong with it.", f(REG, 46), (220, 235, 221))
sy = H - PAD - 128
sw_ = d.textlength("swipe", font=f(SEMI, 30))
x0 = (W - sw_ - 54) / 2
d.text((x0, sy), "swipe", font=f(SEMI, 30), fill=MINT)
ax = x0 + sw_ + 20
d.line([(ax, sy + 21), (ax + 30, sy + 21)], fill=MINT, width=4)
d.polygon([(ax + 26, sy + 12), (ax + 40, sy + 21), (ax + 26, sy + 30)], fill=MINT)
footer(d, W, H, PAD, MINT)
im.save(os.path.join(OUT, "ig-1.png"))

# ---- 2 & 3. real captures
for n, (shot, eyebrow, head, sub, bg) in enumerate([
    ("Scanner.PNG", "IDENTIFY", "What plant is this?", "Name, confidence, look-alikes and safety notes.", CREAM),
    ("Diagnose.PNG", "DIAGNOSE", "What's wrong with it?", "Likely causes, how serious, and what to do.", CREAM_D),
], start=2):
    im = Image.new("RGB", (W, H), bg)
    d = ImageDraw.Draw(im)
    tracked(d, W / 2, 96, eyebrow, f(SEMI, 26), SAGE, 9)
    centered(d, W / 2, 142, head, f(BOLD, 62), INK)
    centered(d, W / 2, 226, sub, f(REG, 34), (100, 122, 103))
    ph = phone(shot, 930, crop_bot=0.8)
    im.paste(ph, ((W - ph.width) // 2, 262), ph)
    im.save(os.path.join(OUT, f"ig-{n}.png"))

# ---- 4. CTA
im = gradient(W, H)
d = ImageDraw.Draw(im)
av = Image.open(os.path.join(HERE, "sprout-avatar.png")).convert("RGBA").resize((186, 186), Image.LANCZOS)
m = Image.new("L", (186, 186), 0)
ImageDraw.Draw(m).rounded_rectangle([0, 0, 185, 185], radius=44, fill=255)
av.putalpha(m)
im.paste(av, ((W - 186) // 2, 290), av)
for i, (line, idx, col) in enumerate([("Try it on your", 0, WHITE), ("own garden.", 2, MINT)]):
    centered(d, W / 2, 546 + i * 104, line, serif(90, idx), col)
centered(d, W / 2, 800, "3 free scans for everyone.", f(REG, 42), (214, 231, 215))
centered(d, W / 2, 858, "Unlimited with Sprout Together Pro.", f(REG, 42), (214, 231, 215))
label, fo = "Free on the App Store  -  link in bio", f(SEMI, 38)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(W - tw - 88) / 2, 990, (W + tw + 88) / 2, 1080], radius=45, fill=MINT)
d.text(((W - tw) / 2, 1012), label, font=fo, fill=(28, 52, 33))
footer(d, W, H, PAD, MINT)
im.save(os.path.join(OUT, "ig-4.png"))

# ---- Pinterest: answers a search, shows the tool as the answer
PW, PH = 1000, 1500
im = Image.new("RGB", (PW, PH), CREAM)
d = ImageDraw.Draw(im)
for y in range(420):
    t = y / 420
    d.line([(0, y), (PW, y)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
tracked(d, PW / 2, 60, "PLANT IDENTIFIER APP", f(SEMI, 22), MINT, 7)
centered(d, PW / 2, 104, "Identify Any Plant", serif(70, 0), WHITE)
centered(d, PW / 2, 188, "From a Photo", serif(70, 2), MINT)
centered(d, PW / 2, 296, "and find out what's wrong with a sick one", f(REG, 29), (210, 228, 212))
centered(d, PW / 2, 342, "- in seconds.", f(REG, 29), (210, 228, 212))
left = phone("Scanner.PNG", 640, crop_bot=0.78)
right = phone("Diagnose.PNG", 640, crop_bot=0.78)
im.paste(left, (-18, 400), left)
im.paste(right, (PW - right.width + 18, 470), right)
centered(d, PW / 2, 1290, "Name, safety notes, causes and fixes.", f(SEMI, 32), INK)
label, fo = "sprouttogether.app", f(SEMI, 32)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(PW - tw - 80) / 2, 1356, (PW + tw + 80) / 2, 1434], radius=39, fill=GREEN_TOP)
d.text(((PW - tw) / 2, 1375), label, font=fo, fill=WHITE)
im.save(os.path.join(OUT, "pin.png"))
print("wrote", sorted(os.listdir(OUT)))
