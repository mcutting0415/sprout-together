#!/usr/bin/env python3
"""Builds the first Instagram carousel: "5 veggies you can't kill".
Output: marketing/ig-post-1/slide-1.png ... slide-7.png (1080x1350, 4:5)
"""
import os
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "ig-post-1")
os.makedirs(OUT, exist_ok=True)

W, H = 1080, 1350
PAD = 88

# Brand palette (matches the App Store screenshots)
GREEN_TOP = (60, 111, 69)      # #3c6f45
GREEN_BOT = (37, 61, 42)       # #253d2a
CREAM = (247, 244, 235)        # #f7f4eb
INK = (34, 56, 39)             # #223827
INK_SOFT = (96, 122, 100)      # #607a64
MINT = (174, 214, 177)         # #aed6b1
WHITE = (255, 255, 255)

BOLD = os.path.join(HERE, "..", "assets", "fonts", "Poppins-Bold.ttf")
SEMI = os.path.join(HERE, "..", "assets", "fonts", "Poppins-SemiBold.ttf")
REG = os.path.join(HERE, "..", "assets", "fonts", "Poppins-Regular.ttf")
EMOJI = "/System/Library/Fonts/Apple Color Emoji.ttc"

f = lambda p, s: ImageFont.truetype(p, s)


def gradient(top, bot):
    im = Image.new("RGB", (W, H), top)
    d = ImageDraw.Draw(im)
    for y in range(H):
        t = y / H
        d.line([(0, y), (W, y)], fill=tuple(int(top[i] + (bot[i] - top[i]) * t) for i in range(3)))
    return im


def emoji(ch, size):
    """Render a color emoji at an arbitrary size (Apple's font only loads at 160)."""
    src = Image.new("RGBA", (200, 200), (0, 0, 0, 0))
    ImageDraw.Draw(src).text((10, 10), ch, font=f(EMOJI, 160), embedded_color=True)
    return src.crop(src.getbbox()).resize((size, size), Image.LANCZOS)


def wrap(d, text, font, maxw):
    lines, cur = [], ""
    for word in text.split():
        trial = (cur + " " + word).strip()
        if d.textlength(trial, font=font) <= maxw:
            cur = trial
        else:
            lines.append(cur)
            cur = word
    if cur:
        lines.append(cur)
    return lines


def draw_wrapped(d, xy, text, font, fill, maxw, leading):
    x, y = xy
    for line in wrap(d, text, font, maxw):
        d.text((x, y), line, font=font, fill=fill)
        y += leading
    return y


def footer(im, d, light=False):
    """Handle, bottom-left, with a small brand dot."""
    col = MINT if not light else INK_SOFT
    cy = H - PAD - 18
    d.ellipse([PAD, cy - 9, PAD + 18, cy + 9], fill=col)
    d.text((PAD + 34, H - PAD - 36), "@sprouttogether.app", font=f(SEMI, 28), fill=col)


def chip(d, xy, text, fg, bg):
    x, y = xy
    fo = f(SEMI, 30)
    tw = d.textlength(text, font=fo)
    d.rounded_rectangle([x, y, x + tw + 56, y + 62], radius=31, fill=bg)
    d.text((x + 28, y + 13), text, font=fo, fill=fg)
    return y + 62


# ---------------------------------------------------------------- slide 1 (cover)
im = gradient(GREEN_TOP, GREEN_BOT)
d = ImageDraw.Draw(im)
e = emoji("🌱", 96)
im.paste(e, (PAD, 200), e)
y = 372
d.text((PAD, y), "5 VEGGIES", font=f(BOLD, 124), fill=WHITE)
d.text((PAD, y + 132), "YOU CAN'T", font=f(BOLD, 124), fill=WHITE)
d.text((PAD, y + 264), "KILL", font=f(BOLD, 124), fill=MINT)
d.rounded_rectangle([PAD, y + 442, PAD + 120, y + 450], radius=4, fill=MINT)
draw_wrapped(d, (PAD, y + 502), "Beginner-proof picks that forgive almost everything.",
             f(REG, 42), (222, 236, 223), W - PAD * 2 - 60, 58)
# swipe cue (drawn: Poppins has no arrow glyph)
sy = H - PAD - 128
d.text((PAD, sy), "swipe", font=f(SEMI, 32), fill=MINT)
ax = PAD + d.textlength("swipe", font=f(SEMI, 32)) + 20
d.line([(ax, sy + 22), (ax + 34, sy + 22)], fill=MINT, width=4)
d.polygon([(ax + 30, sy + 12), (ax + 46, sy + 22), (ax + 30, sy + 32)], fill=MINT)
footer(im, d)
im.save(os.path.join(OUT, "slide-1.png"))

# ---------------------------------------------------------------- slides 2-6
VEGGIES = [
    ("🍅", "Cherry tomatoes", "One plant keeps producing all summer long.", "60–70 days"),
    ("🥬", "Lettuce", "Cut the outer leaves and it just grows back.", "~30 days"),
    ("🌶️", "Peppers", "Loves heat, hates fuss. Water and walk away.", "70–80 days"),
    ("🫛", "Green beans", "Fast, forgiving, and the more you pick the more you get.", "50–60 days"),
    ("🌿", "Basil & mint", "Thrive on a windowsill. No garden required.", "~40 days"),
]

for i, (ch, name, blurb, days) in enumerate(VEGGIES, start=1):
    im = Image.new("RGB", (W, H), CREAM)
    d = ImageDraw.Draw(im)
    # number
    d.text((PAD, 150), f"0{i}", font=f(BOLD, 88), fill=MINT)
    e = emoji(ch, 340)
    im.paste(e, (W - PAD - 340, 176), e)
    y = 660
    y = draw_wrapped(d, (PAD, y), name, f(BOLD, 92), INK, W - PAD * 2, 106)
    y = draw_wrapped(d, (PAD, y + 34), blurb, f(REG, 44), INK_SOFT, W - PAD * 2 - 40, 64)
    chip(d, (PAD, y + 46), f"{days} to harvest", INK, (223, 236, 224))
    footer(im, d, light=True)
    im.save(os.path.join(OUT, f"slide-{i+1}.png"))

# ---------------------------------------------------------------- slide 7 (CTA)
im = gradient(GREEN_TOP, GREEN_BOT)
d = ImageDraw.Draw(im)
av = Image.open(os.path.join(HERE, "sprout-avatar.png")).convert("RGBA").resize((190, 190), Image.LANCZOS)
mask = Image.new("L", (190, 190), 0)
ImageDraw.Draw(mask).rounded_rectangle([0, 0, 189, 189], radius=44, fill=255)
av.putalpha(mask)
im.paste(av, ((W - 190) // 2, 230), av)
t = "Know exactly when"
for line, fo, col, yy in [("Know exactly when", f(BOLD, 74), WHITE, 490),
                          ("to plant each one.", f(BOLD, 74), MINT, 578)]:
    d.text(((W - d.textlength(line, font=fo)) / 2, yy), line, font=fo, fill=col)
sub = "Sprout Together gives you planting windows,\ncare guides and harvest timing for 154 plants —\nbased on where you live."
yy = 700
for line in sub.split("\n"):
    fo = f(REG, 40)
    d.text(((W - d.textlength(line, font=fo)) / 2, yy), line, font=fo, fill=(214, 231, 215))
    yy += 58
fo = f(SEMI, 40)
label = "Free on the App Store — link in bio"
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(W - tw - 88) / 2, 940, (W + tw + 88) / 2, 1032], radius=46, fill=MINT)
d.text(((W - tw) / 2, 963), label, font=fo, fill=(28, 52, 33))
footer(im, d)
im.save(os.path.join(OUT, "slide-7.png"))

print("wrote", len(os.listdir(OUT)), "slides to", OUT)
