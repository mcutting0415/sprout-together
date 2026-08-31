#!/usr/bin/env python3
"""Welcome post — the account's first ever post.

Instagram : marketing/welcome-post/ig-1.png .. ig-5.png   (1080x1350, 4:5)
Pinterest : marketing/welcome-post/pin.png                (1000x1500, 2:3)
"""
import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "welcome-post")
os.makedirs(OUT, exist_ok=True)

CREAM = (248, 245, 238)
CREAM_D = (238, 233, 222)
INK = (32, 54, 37)
SAGE = (122, 148, 126)
GREEN_TOP = (60, 111, 69)
GREEN_BOT = (37, 61, 42)
MINT = (174, 214, 177)
WHITE = (255, 255, 255)

FDIR = os.path.join(HERE, "..", "assets", "fonts")
BOLD, SEMI, REG = (os.path.join(FDIR, f"Poppins-{n}.ttf") for n in ("Bold", "SemiBold", "Regular"))
BASK = "/System/Library/Fonts/Supplemental/Baskerville.ttc"
EMOJI = "/System/Library/Fonts/Apple Color Emoji.ttc"

f = lambda p, s: ImageFont.truetype(p, s)
serif = lambda s, i=0: ImageFont.truetype(BASK, s, index=i)


def gradient(w, h, top, bot):
    im = Image.new("RGB", (w, h), top)
    d = ImageDraw.Draw(im)
    for y in range(h):
        t = y / h
        d.line([(0, y), (w, y)], fill=tuple(int(top[i] + (bot[i] - top[i]) * t) for i in range(3)))
    return im


def emoji(ch, size):
    src = Image.new("RGBA", (200, 200), (0, 0, 0, 0))
    ImageDraw.Draw(src).text((10, 10), ch, font=f(EMOJI, 160), embedded_color=True)
    return src.crop(src.getbbox()).resize((size, size), Image.LANCZOS)


def wrap(d, text, font, maxw):
    lines, cur = [], ""
    for word in text.split():
        t = (cur + " " + word).strip()
        if d.textlength(t, font=font) <= maxw:
            cur = t
        else:
            lines.append(cur)
            cur = word
    if cur:
        lines.append(cur)
    return lines


def draw_wrapped(d, xy, text, font, fill, maxw, leading, center_w=None):
    x, y = xy
    for line in wrap(d, text, font, maxw):
        px = (center_w - d.textlength(line, font=font)) / 2 if center_w else x
        d.text((px, y), line, font=font, fill=fill)
        y += leading
    return y


def tracked(d, xy, text, font, fill, track):
    """Letter-spaced small caps for the eyebrow."""
    x, y = xy
    for ch in text:
        d.text((x, y), ch, font=font, fill=fill)
        x += d.textlength(ch, font=font) + track
    return x


def phone(shot_name, target_h, crop_top=0.0, crop_bot=1.0):
    """App screenshot in a rounded device frame with a soft drop shadow."""
    src = Image.open(os.path.join(HERE, shot_name)).convert("RGB")
    w, h = src.size
    src = src.crop((0, int(h * crop_top), w, int(h * crop_bot)))
    r = target_h / src.size[1]
    sw, sh = int(src.size[0] * r), target_h
    src = src.resize((sw, sh), Image.LANCZOS)

    bez, rad = 14, 52
    fw, fh = sw + bez * 2, sh + bez * 2
    frame = Image.new("RGBA", (fw, fh), (0, 0, 0, 0))
    ImageDraw.Draw(frame).rounded_rectangle([0, 0, fw - 1, fh - 1], radius=rad, fill=(26, 40, 29, 255))
    mask = Image.new("L", (sw, sh), 0)
    ImageDraw.Draw(mask).rounded_rectangle([0, 0, sw - 1, sh - 1], radius=rad - bez, fill=255)
    frame.paste(src, (bez, bez), mask)

    pad = 60
    out = Image.new("RGBA", (fw + pad * 2, fh + pad * 2), (0, 0, 0, 0))
    sh_layer = Image.new("RGBA", out.size, (0, 0, 0, 0))
    ImageDraw.Draw(sh_layer).rounded_rectangle(
        [pad, pad + 16, pad + fw, pad + fh + 16], radius=rad, fill=(40, 60, 44, 70))
    out.alpha_composite(sh_layer.filter(ImageFilter.GaussianBlur(26)))
    out.alpha_composite(frame, (pad, pad))
    return out


def footer(im, d, w, h, pad, light=False):
    col = SAGE if light else MINT
    cy = h - pad - 18
    d.ellipse([pad, cy - 9, pad + 18, cy + 9], fill=col)
    d.text((pad + 34, h - pad - 36), "@sprouttogether.app", font=f(SEMI, 28), fill=col)


# ================================================================ INSTAGRAM
W, H, PAD = 1080, 1350, 88

# ---- ig-1 : welcome cover
im = Image.new("RGB", (W, H), CREAM)
d = ImageDraw.Draw(im)
e = emoji("\U0001f331", 92)
im.paste(e, ((W - 92) // 2, 246), e)
tw = sum(d.textlength(c, font=f(SEMI, 26)) + 9 for c in "SPROUT TOGETHER") - 9
tracked(d, ((W - tw) / 2, 386), "SPROUT TOGETHER", f(SEMI, 26), SAGE, 9)
y = 466
for line, fo in [("Welcome to", serif(112, 0)), ("your garden.", serif(112, 2))]:
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=INK)
    y += 128
d.line([(W / 2 - 46, y + 44), (W / 2 + 46, y + 44)], fill=SAGE, width=3)
draw_wrapped(d, (0, y + 104),
             "A free garden companion for people who'd rather grow than google.",
             f(REG, 42), (94, 116, 97), W - PAD * 2 - 80, 60, center_w=W)
sy = H - PAD - 128
sw_ = d.textlength("swipe", font=f(SEMI, 30))
d.text(((W - sw_ - 54) / 2, sy), "swipe", font=f(SEMI, 30), fill=SAGE)
ax = (W - sw_ - 54) / 2 + sw_ + 20
d.line([(ax, sy + 21), (ax + 30, sy + 21)], fill=SAGE, width=4)
d.polygon([(ax + 26, sy + 12), (ax + 40, sy + 21), (ax + 26, sy + 30)], fill=SAGE)
footer(im, d, W, H, PAD, light=True)
im.save(os.path.join(OUT, "ig-1.png"))

# ---- ig-2..4 : feature slides, real app screens
FEATURES = [
    ("Builder.jpg", "Plan your beds", "Lay out raised beds and drop plants in square by square — no graph paper.", 0.0, 1.0),
    ("Detail.PNG",  "154 plant guides", "Sunlight, watering, spacing and days to harvest for every plant.", 0.0, 1.0),
    ("Companion.jpg", "Companion planting", "See which plants help each other before you put them in the ground.", 0.0, 1.0),
]
for i, (shot, title, blurb, ct, cb) in enumerate(FEATURES, start=2):
    im = Image.new("RGB", (W, H), CREAM if i % 2 == 0 else CREAM_D)
    d = ImageDraw.Draw(im)
    ph = phone(shot, 776, ct, cb)
    im.paste(ph, ((W - ph.size[0]) // 2, 66), ph)
    y = 976
    fo = f(BOLD, 62)
    d.text(((W - d.textlength(title, font=fo)) / 2, y), title, font=fo, fill=INK)
    draw_wrapped(d, (0, y + 92), blurb, f(REG, 38), (100, 122, 103), W - PAD * 2 - 60, 54, center_w=W)
    footer(im, d, W, H, PAD, light=True)
    im.save(os.path.join(OUT, f"ig-{i}.png"))

# ---- ig-5 : CTA
im = gradient(W, H, GREEN_TOP, GREEN_BOT)
d = ImageDraw.Draw(im)
av = Image.open(os.path.join(HERE, "sprout-avatar.png")).convert("RGBA").resize((186, 186), Image.LANCZOS)
m = Image.new("L", (186, 186), 0)
ImageDraw.Draw(m).rounded_rectangle([0, 0, 185, 185], radius=44, fill=255)
av.putalpha(m)
im.paste(av, ((W - 186) // 2, 288), av)
y = 542
for line, fo, col in [("Come grow", serif(96, 0), WHITE), ("with us.", serif(96, 2), MINT)]:
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 112
draw_wrapped(d, (0, y + 46), "Plant guides, garden planning and harvest timing — all free.",
             f(REG, 40), (214, 231, 215), W - PAD * 2 - 40, 56, center_w=W)
label, fo = "Free on the App Store — link in bio", f(SEMI, 38)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(W - tw - 88) / 2, 988, (W + tw + 88) / 2, 1078], radius=45, fill=MINT)
d.text(((W - tw) / 2, 1010), label, font=fo, fill=(28, 52, 33))
footer(im, d, W, H, PAD)
im.save(os.path.join(OUT, "ig-5.png"))

# ================================================================ PINTEREST  (1000x1500)
PW, PH, PP = 1000, 1500, 76
im = Image.new("RGB", (PW, PH), CREAM)
d = ImageDraw.Draw(im)
d.rectangle([0, 0, PW, 470], fill=(60, 111, 69))
for yy in range(470):
    t = yy / 470
    d.line([(0, yy), (PW, yy)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
tw = sum(d.textlength(c, font=f(SEMI, 24)) + 8 for c in "FREE APP") - 8
tracked(d, ((PW - tw) / 2, 92), "FREE APP", f(SEMI, 24), MINT, 8)
y = 142
for line, fo, col in [("Plan Your Vegetable", serif(72, 0), WHITE), ("Garden in Minutes", serif(72, 0), MINT)]:
    d.text(((PW - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 86
draw_wrapped(d, (0, y + 26),
             "Garden layouts, companion planting and when-to-plant guides for 154 plants.",
             f(REG, 32), (214, 231, 215), PW - PP * 2 - 40, 44, center_w=PW)

left = phone("Builder.jpg", 560, 0.0, 1.0)
right = phone("Detail.PNG", 560, 0.0, 1.0)
im.paste(right, (PW - right.size[0] + 24, 552), right)
im.paste(left, (-24, 496), left)

y = 1204
for line, fo in [("Everything your garden", f(SEMI, 40)), ("needs, in one free app.", f(SEMI, 40))]:
    d.text(((PW - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=INK)
    y += 52
label, fo = "sprouttogether.app", f(SEMI, 34)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(PW - tw - 84) / 2, 1336, (PW + tw + 84) / 2, 1418], radius=41, fill=(60, 111, 69))
d.text(((PW - tw) / 2, 1357), label, font=fo, fill=WHITE)
im.save(os.path.join(OUT, "pin.png"))

print("wrote", sorted(os.listdir(OUT)))
