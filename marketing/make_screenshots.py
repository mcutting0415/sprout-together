#!/usr/bin/env python3
import os
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "appstore")
os.makedirs(OUT, exist_ok=True)

W, H = 1320, 2868
TOP = (60, 111, 69)      # #3c6f45
BOT = (47, 74, 52)       # #2f4a34
WHITE = (255, 255, 255)
MINT = (174, 214, 177)   # #aed6b1
MINT_SOFT = (207, 231, 208)  # #cfe7d0

def font_path(candidates):
    for c in candidates:
        if os.path.exists(c):
            return c
    return None

BOLD = font_path([
    "/System/Library/Fonts/Supplemental/Arial Bold.ttf",
    "/Library/Fonts/Arial Bold.ttf",
    "/System/Library/Fonts/Supplemental/Helvetica.ttc",
])
REG = font_path([
    "/System/Library/Fonts/Supplemental/Arial.ttf",
    "/Library/Fonts/Arial.ttf",
    "/System/Library/Fonts/Helvetica.ttc",
])

def fit_font(draw, text, path, start, maxw, minsize=40):
    size = start
    while size > minsize:
        f = ImageFont.truetype(path, size)
        if draw.textlength(text, font=f) <= maxw:
            return f
        size -= 2
    return ImageFont.truetype(path, minsize)

def gradient(w, h, top, bot):
    base = Image.new("RGB", (w, h), top)
    d = ImageDraw.Draw(base)
    for y in range(h):
        t = y / (h - 1)
        r = int(top[0] + (bot[0] - top[0]) * t)
        g = int(top[1] + (bot[1] - top[1]) * t)
        b = int(top[2] + (bot[2] - top[2]) * t)
        d.line([(0, y), (w, y)], fill=(r, g, b))
    return base

def rounded(img, radius):
    img = img.convert("RGBA")
    mask = Image.new("L", img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, img.size[0], img.size[1]], radius=radius, fill=255)
    img.putalpha(mask)
    return img

slides = [
    ("Plant Lib.jpg", "Care guides for", "154 plants", "Veggies, herbs & flowers — all in your pocket", "1-plants.png"),
    ("Detail.PNG", "Know when to", "plant & harvest", "Timing & care for every plant", "2-timing.png"),
    ("Builder.jpg", "Design your", "garden beds", "Lay out plots and plants in minutes", "3-builder.png"),
    ("Companion.jpg", "Companion", "planting made easy", "See what grows well together", "4-companion.png"),
    ("Journal.jpg", "Track every", "season", "Photos, notes & progress in one place", "5-journal.png"),
]

MAXW = 1210
for src, h1, h2, sub, outname in slides:
    canvas = gradient(W, H, TOP, BOT)
    d = ImageDraw.Draw(canvas)

    wf = ImageFont.truetype(REG, 44)
    d.text((W/2, 118), "Sprout Together", font=wf, fill=MINT, anchor="mm")

    f1 = fit_font(d, h1, BOLD, 108, MAXW)
    f2 = fit_font(d, h2, BOLD, 108, MAXW)
    d.text((W/2, 250), h1, font=f1, fill=WHITE, anchor="mm")
    d.text((W/2, 368), h2, font=f2, fill=WHITE, anchor="mm")

    sf = fit_font(d, sub, REG, 42, MAXW, minsize=30)
    d.text((W/2, 452), sub, font=sf, fill=MINT_SOFT, anchor="mm")

    shot = Image.open(os.path.join(HERE, src))
    box_w, box_top, box_h = 1110, 500, H - 500 - 46
    scale = min(box_w / shot.width, box_h / shot.height)
    nw, nh = int(shot.width * scale), int(shot.height * scale)
    shot = shot.resize((nw, nh), Image.LANCZOS)
    shot = rounded(shot, 46)
    x = (W - nw) // 2
    y = box_top + (box_h - nh) // 2
    canvas.paste(shot, (x, y), shot)

    canvas.save(os.path.join(OUT, outname))
    print(f"saved {outname}  ({W}x{H}, shot {nw}x{nh} at {x},{y})")

print("done")
