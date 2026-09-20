#!/usr/bin/env python3
"""Post #4 — "what's wrong with my plant?" symptom guide.

Every symptom, cause and fix below is taken from the app's own commonProblems
data, so the post can't contradict what people read after installing.

Instagram : marketing/problems-post/ig-1.png .. ig-8.png  (1080x1350)
Pinterest : marketing/problems-post/pin.png               (1000x1500)
"""
import os
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "problems-post")
os.makedirs(OUT, exist_ok=True)

CREAM, CREAM_D = (248, 245, 238), (238, 233, 222)
INK, SAGE = (32, 54, 37), (122, 148, 126)
GREEN_TOP, GREEN_BOT = (60, 111, 69), (37, 61, 42)
MINT, MINT_BG = (174, 214, 177), (223, 236, 224)
CLAY, CLAY_BG = (166, 92, 70), (243, 228, 222)
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


def footer(im, d, w, h, pad, light=True):
    col = SAGE if light else MINT
    cy = h - pad - 18
    d.ellipse([pad, cy - 9, pad + 18, cy + 9], fill=col)
    d.text((pad + 34, h - pad - 36), "@sprouttogether.app", font=f(SEMI, 28), fill=col)


# symptom, what it looks like, likely cause, what to do — all from the app
PROBLEMS = [
    ("🍅", "Dark sunken patch\non the fruit", "Bottom of the tomato goes leathery and black.",
     "Blossom end rot", "Not a disease — a calcium problem caused by uneven watering. Water consistently and it stops."),
    ("🌿", "Brown spots with\nyellow halos", "Lower leaves first, spreading upward.",
     "Early blight", "Remove affected leaves. Water the soil, never the foliage."),
    ("🥒", "White powdery\ncoating on leaves", "Looks like someone dusted them with flour.",
     "Powdery mildew", "Improve air circulation. Late in the season it's normal — don't panic."),
    ("🥬", "Holes chewed\nthrough leaves", "Ragged edges, sometimes a slime trail.",
     "Slugs and snails", "Copper tape, diatomaceous earth, or a beer trap. Check after dark."),
    ("🪴", "Sudden wilt, sawdust\nat the stem base", "Healthy one day, collapsed the next.",
     "Squash vine borer", "Wrap stems in foil at ground level to stop egg-laying, or inject Bt."),
    ("🍂", "Brown, crispy\nleaf edges", "Edges only — the middle of the leaf still looks fine.",
     "Tip burn", "Calcium not reaching the leaf edge. Keep soil evenly moist, don't let it swing."),
]

W, H, PAD = 1080, 1350, 88

# ---- cover
im = Image.new("RGB", (W, H), CREAM)
d = ImageDraw.Draw(im)
e = emoji("\U0001f50d", 92)
im.paste(e, ((W - 92) // 2, 246), e)
tw = tracked_w(d, "PLANT PROBLEMS", f(SEMI, 26), 9)
tracked(d, ((W - tw) / 2, 386), "PLANT PROBLEMS", f(SEMI, 26), SAGE, 9)
y = 466
for line, idx in [("What's wrong", 0), ("with my plant?", 2)]:
    fo = serif(104, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=INK)
    y += 122
d.line([(W / 2 - 46, y + 40), (W / 2 + 46, y + 40)], fill=SAGE, width=3)
draw_wrapped(d, (0, y + 100), "Six things gardeners see every season — and what each one actually means.",
             f(REG, 42), (94, 116, 97), W - PAD * 2 - 60, 60, center_w=W)
sy = H - PAD - 128
sw_ = d.textlength("swipe", font=f(SEMI, 30))
d.text(((W - sw_ - 54) / 2, sy), "swipe", font=f(SEMI, 30), fill=SAGE)
ax = (W - sw_ - 54) / 2 + sw_ + 20
d.line([(ax, sy + 21), (ax + 30, sy + 21)], fill=SAGE, width=4)
d.polygon([(ax + 26, sy + 12), (ax + 40, sy + 21), (ax + 26, sy + 30)], fill=SAGE)
footer(im, d, W, H, PAD)
im.save(os.path.join(OUT, "ig-1.png"))

# ---- symptom cards
for i, (ch, symptom, looks, cause, fix) in enumerate(PROBLEMS, start=2):
    im = Image.new("RGB", (W, H), CREAM if i % 2 == 0 else CREAM_D)
    d = ImageDraw.Draw(im)
    e = emoji(ch, 120)
    im.paste(e, (W - PAD - 120, 300), e)

    y = 330
    for line in symptom.split("\n"):
        d.text((PAD, y), line, font=serif(76, 0), fill=INK)
        y += 84
    y = draw_wrapped(d, (PAD, y + 22), looks, serif(40, 2), (108, 128, 110), W - PAD * 2 - 140, 54)

    y += 54
    tracked(d, (PAD, y), "LIKELY CAUSE", f(SEMI, 24), CLAY, 7)
    fo = f(SEMI, 44)
    tw = d.textlength(cause, font=fo)
    d.rounded_rectangle([PAD, y + 46, PAD + tw + 52, y + 122], radius=38, fill=CLAY_BG)
    d.text((PAD + 26, y + 63), cause, font=fo, fill=(122, 58, 40))

    y += 168
    tracked(d, (PAD, y), "WHAT TO DO", f(SEMI, 24), SAGE, 7)
    draw_wrapped(d, (PAD, y + 46), fix, f(REG, 40), (60, 82, 63), W - PAD * 2, 56)

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
for line, idx, col in [("Not sure which", 0, WHITE), ("one you've got?", 2, MINT)]:
    fo = serif(86, idx)
    d.text(((W - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 100
draw_wrapped(d, (0, y + 46),
             "Sprout Together has pest and disease notes for every plant in your garden — free.",
             f(REG, 40), (214, 231, 215), W - PAD * 2 - 40, 56, center_w=W)
label, fo = "Free on the App Store — link in bio", f(SEMI, 38)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(W - tw - 88) / 2, 1000, (W + tw + 88) / 2, 1090], radius=45, fill=MINT)
d.text(((W - tw) / 2, 1022), label, font=fo, fill=(28, 52, 33))
footer(im, d, W, H, PAD, light=False)
im.save(os.path.join(OUT, "ig-8.png"))

# ---- Pinterest chart
PW, PH, PP = 1000, 1500, 62
im = Image.new("RGB", (PW, PH), CREAM)
d = ImageDraw.Draw(im)
for yy in range(300):
    t = yy / 300
    d.line([(0, yy), (PW, yy)], fill=tuple(int(GREEN_TOP[i] + (GREEN_BOT[i] - GREEN_TOP[i]) * t) for i in range(3)))
tw = tracked_w(d, "GARDEN TROUBLESHOOTING", f(SEMI, 21), 6)
tracked(d, ((PW - tw) / 2, 54), "GARDEN TROUBLESHOOTING", f(SEMI, 21), MINT, 6)
y = 96
for line, col in [("What's Wrong With", WHITE), ("My Plant?", MINT)]:
    fo = serif(64, 0)
    d.text(((PW - d.textlength(line, font=fo)) / 2, y), line, font=fo, fill=col)
    y += 76
fo = f(REG, 26)
sub = "Six symptoms, what causes them, and how to fix each one"
d.text(((PW - d.textlength(sub, font=fo)) / 2, 254), sub, font=fo, fill=(206, 226, 208))

ry = 322
for i, (ch, symptom, looks, cause, fix) in enumerate(PROBLEMS):
    rh = 160
    if i % 2 == 0:
        d.rectangle([0, ry - 14, PW, ry + rh - 14], fill=CREAM_D)
    e = emoji(ch, 56)
    im.paste(e, (PP, ry + 18), e)
    flat = symptom.replace("\n", " ")
    d.text((PP + 86, ry + 2), flat, font=f(BOLD, 31), fill=INK)
    d.text((PP + 86, ry + 42), cause, font=f(SEMI, 25), fill=CLAY)
    draw_wrapped(d, (PP + 86, ry + 76), fix, f(REG, 23), (100, 118, 102), PW - PP * 2 - 96, 29)
    ry += rh

fo = f(SEMI, 32)
line = "Pest & disease notes for 154 plants — free."
d.text(((PW - d.textlength(line, font=fo)) / 2, 1330), line, font=fo, fill=INK)
label, fo = "sprouttogether.app", f(SEMI, 31)
tw = d.textlength(label, font=fo)
d.rounded_rectangle([(PW - tw - 78) / 2, 1388, (PW + tw + 78) / 2, 1462], radius=37, fill=(60, 111, 69))
d.text(((PW - tw) / 2, 1406), label, font=fo, fill=WHITE)
im.save(os.path.join(OUT, "pin.png"))

print("wrote", sorted(os.listdir(OUT)))
