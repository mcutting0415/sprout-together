#!/usr/bin/env python3
"""Open Graph / social share card -> site-deploy/img/og-image.png (1200x630)."""
import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "..", "site-deploy", "img", "og-image.png")

W, H = 1200, 630
GREEN_TOP, GREEN_BOT = (60, 111, 69), (37, 61, 42)
MINT, WHITE = (174, 214, 177), (255, 255, 255)

FDIR = os.path.join(HERE, "..", "assets", "fonts")
BOLD, SEMI, REG = (os.path.join(FDIR, f"Poppins-{n}.ttf") for n in ("Bold", "SemiBold", "Regular"))
BASK = "/System/Library/Fonts/Supplemental/Baskerville.ttc"
f = lambda p, s: ImageFont.truetype(p, s)

im = Image.new("RGB", (W, H), GREEN_TOP)
d = ImageDraw.Draw(im)
for y in range(H):
    t = y / H
    d.line([(0, y), (W, y)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))


def phone(name, target_h):
    src = Image.open(os.path.join(HERE, "..", "site-deploy", "img", name)).convert("RGB")
    r = target_h / src.size[1]
    sw, sh = int(src.size[0] * r), target_h
    src = src.resize((sw, sh), Image.LANCZOS)
    bez, rad = 12, 44
    fw, fh = sw + bez * 2, sh + bez * 2
    fr = Image.new("RGBA", (fw, fh), (0, 0, 0, 0))
    ImageDraw.Draw(fr).rounded_rectangle([0, 0, fw - 1, fh - 1], radius=rad, fill=(22, 36, 25, 255))
    m = Image.new("L", (sw, sh), 0)
    ImageDraw.Draw(m).rounded_rectangle([0, 0, sw - 1, sh - 1], radius=rad - bez, fill=255)
    fr.paste(src, (bez, bez), m)
    pad = 50
    out = Image.new("RGBA", (fw + pad * 2, fh + pad * 2), (0, 0, 0, 0))
    sl = Image.new("RGBA", out.size, (0, 0, 0, 0))
    ImageDraw.Draw(sl).rounded_rectangle([pad, pad + 14, pad + fw, pad + fh + 14], radius=rad, fill=(12, 24, 15, 110))
    out.alpha_composite(sl.filter(ImageFilter.GaussianBlur(22)))
    out.alpha_composite(fr, (pad, pad))
    return out

# phones, right side
back = phone("detail.png", 520)
front = phone("builder.jpg", 560)
im.paste(back, (W - back.size[0] + 40, 96), back)
im.paste(front, (W - front.size[0] - 168, 130), front)

# logo + wordmark
logo = Image.open(os.path.join(HERE, "..", "site-deploy", "img", "logo.png")).convert("RGBA").resize((72, 72), Image.LANCZOS)
m = Image.new("L", (72, 72), 0)
ImageDraw.Draw(m).rounded_rectangle([0, 0, 71, 71], radius=18, fill=255)
logo.putalpha(m)
im.paste(logo, (72, 92), logo)
d.text((162, 108), "Sprout Together", font=f(SEMI, 34), fill=MINT)

y = 224
for line, idx in [("Your garden,", 0), ("all in one place.", 2)]:
    d.text((72, y), line, font=ImageFont.truetype(BASK, 66, index=idx), fill=WHITE)
    y += 78

for i, line in enumerate(["Care guides for 154 plants, a visual garden",
                          "planner, companion planting, and planting",
                          "& harvest timing for where you live."]):
    d.text((72, 402 + i * 40), line, font=f(REG, 27), fill=(206, 226, 208))

label, fo = "Free on the App Store", f(SEMI, 27)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([72, 534, 72 + tw + 62, 534 + 62], radius=31, fill=MINT)
d.text((103, 551), label, font=fo, fill=(28, 52, 33))

im.save(OUT)
print("wrote", os.path.normpath(OUT), im.size)
