#!/usr/bin/env python3
"""Generate static plant-guide pages for sprouttogether.app from the app's own data.

Sources (single source of truth — the app and the site can't drift):
  lib/final_app_pages/plant_details_page/plant_knowledge_base.dart
  lib/services/companion_planting_service.dart

Output:
  site-deploy/plants/index.html          hub page
  site-deploy/plants/<slug>/index.html   one guide per plant
  site-deploy/plants/guide.css           shared stylesheet
  site-deploy/sitemap.xml
  site-deploy/robots.txt
"""
import os, re, html, json
from shop_data import load_products, products_for_plant

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..")
SITE = os.path.join(ROOT, "site-deploy")
PLANTS_DIR = os.path.join(SITE, "plants")
BASE = "https://sprouttogether.app"
APPSTORE = "https://apps.apple.com/us/app/sprouttogether/id6785081475"

FIELDS = ["harvestSigns", "harvestHow", "soilPrep", "fertilizing",
          "commonProblems", "storageUse", "bestSeason"]
STR = r"'((?:[^'\\]|\\.)*)'"


def unescape(s):
    return s.replace("\\'", "'").replace('\\"', '"').replace("\\n", " ").replace("\\$", "$").strip()


def load_knowledge():
    src = open(os.path.join(ROOT, "lib/final_app_pages/plant_details_page/plant_knowledge_base.dart")).read()
    body = src[src.index("const Map<String, PlantKnowledge> _plantKnowledgeBase"):]
    out = {}
    for m in re.finditer(r"'([a-z][a-z '\-]*?)':\s*PlantKnowledge\((.*?)\n  \),", body, re.S):
        name, blk = m.group(1), m.group(2)
        rec = {}
        for f in FIELDS:
            fm = re.search(f + r":\s*" + STR, blk, re.S)
            if fm:
                rec[f] = unescape(fm.group(1))
        if len(rec) == len(FIELDS):
            out[name] = rec
    return out


def load_companions():
    src = open(os.path.join(ROOT, "lib/services/companion_planting_service.dart")).read()
    out = {}
    for m in re.finditer(r"'([a-z][a-z ]*?)':\s*\{\s*'good':\s*\[([^\]]*)\],\s*'bad':\s*\[([^\]]*)\],\s*'tip':\s*" + STR, src, re.S):
        name, good, bad, tip = m.groups()
        cl = lambda x: [w.strip().strip("'") for w in x.split(",") if w.strip()]
        out[name] = {"good": cl(good), "bad": cl(bad), "tip": unescape(tip)}
    return out


slug = lambda n: re.sub(r"[^a-z0-9]+", "-", n.lower()).strip("-")
title = lambda n: " ".join(w.capitalize() for w in n.split())
e = html.escape


def trim(s, n=155):
    s = re.sub(r"\s+", " ", s).strip()
    return s if len(s) <= n else s[:s.rfind(" ", 0, n - 1)] + "…"


DISCLOSURE = ("Some links on this page are affiliate links. If you buy through one we may "
              "earn a small commission, at no extra cost to you. "
              "As an Amazon Associate I earn from qualifying purchases.")


def product_cards(items, heading, blurb):
    cards = "".join(
        f'<a class="prod" href="{e(p["url"])}" target="_blank" rel="sponsored nofollow noopener">'
        f'<span class="pcat">{e(p["category"])}</span>'
        f'<span class="pname">{e(p["name"])}</span>'
        f'<span class="pmeta">{e(p["store"] or "")} · {e(p["price"] or "")}</span></a>'
        for p in items)
    return (f'<section class="blk shopblk"><h2>{heading}</h2>'
            f'<p class="pblurb">{blurb}</p>'
            f'<p class="disc">{e(DISCLOSURE)} '
            f'<a href="/affiliate-disclosure/">More</a>.</p>'
            f'<div class="prods">{cards}</div></section>')


NAV = '''<nav><div class="wrap">
  <a class="brand" href="/">
    <svg viewBox="0 0 100 100" aria-hidden="true"><rect width="100" height="100" rx="24" fill="#35543a"/><g fill="#aed6b1"><path d="M49 50 C36 49 24 42 25 25 C43 29 51 39 49 50 Z"/><path d="M54 45 C62 44 70 38 74 25 C63 25 54 34 54 45 Z"/><path d="M48 47 C48 55 49 60 49 66" fill="none" stroke="#aed6b1" stroke-width="5" stroke-linecap="round"/></g></svg>
    <span>Sprout Together</span>
  </a>
  <a class="cta-small" href="''' + APPSTORE + '''">Download</a>
</div></nav>'''

FOOTER = '''<footer><div class="wrap">
  <div class="brand-f">Sprout Together</div>
  <div class="tagline">Learn • Plant • Grow • Share</div>
  <div class="links">
    <a href="/plants/">Plant Guides</a>
    <a href="/shop/">Shop</a>
    <a href="/affiliate-disclosure/">Affiliate Disclosure</a>
    <a href="/privacy-policy">Privacy Policy</a>
    <a href="/terms-of-service">Terms of Service</a>
    <a href="mailto:hello@sprouttogether.app">Contact</a>
  </div>
  <div class="copy">© 2026 Sprout Together. All rights reserved.</div>
</div></footer>'''


def head(t, desc, canon, extra=""):
    return f'''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>{e(t)}</title>
<meta name="description" content="{e(desc)}" />
<link rel="canonical" href="{canon}" />
<meta property="og:type" content="article" />
<meta property="og:site_name" content="Sprout Together" />
<meta property="og:url" content="{canon}" />
<meta property="og:title" content="{e(t)}" />
<meta property="og:description" content="{e(desc)}" />
<meta property="og:image" content="{BASE}/img/og-image.png" />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="{e(t)}" />
<meta name="twitter:description" content="{e(desc)}" />
<meta name="twitter:image" content="{BASE}/img/og-image.png" />
<link rel="stylesheet" href="/plants/guide.css" />
{extra}
</head>
<body>
{NAV}'''


CSS = '''
:root{--green-dark:#2f4a34;--green:#3c6f45;--green-2:#4a7c59;--mint:#aed6b1;--mint-soft:#cfe7d0;
--cream:#f4f8f2;--card:#fff;--ink:#1e2c22;--muted:#5c6b62;--border:#dde6d8;--clay:#a65c46;--clay-soft:#f3e2dc}
*{margin:0;padding:0;box-sizing:border-box}
html{scroll-behavior:smooth}
body{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",system-ui,Roboto,Helvetica,Arial,sans-serif;
color:var(--ink);background:var(--cream);line-height:1.65;-webkit-font-smoothing:antialiased}
.wrap{max-width:880px;margin:0 auto;padding:0 24px}
a{color:inherit}
nav{position:sticky;top:0;z-index:30;background:rgba(244,248,242,.92);backdrop-filter:saturate(140%) blur(10px);border-bottom:1px solid var(--border)}
nav .wrap{display:flex;align-items:center;justify-content:space-between;height:68px;max-width:1080px}
.brand{display:flex;align-items:center;gap:10px;font-weight:700;font-size:1.15rem;color:var(--green);text-decoration:none}
.brand svg{width:30px;height:30px}
nav .cta-small{background:var(--green);color:#fff;text-decoration:none;padding:9px 18px;border-radius:10px;font-weight:600;font-size:.92rem}
nav .cta-small:hover{background:var(--green-dark)}
.phero{background:linear-gradient(160deg,var(--green) 0%,var(--green-dark) 100%);color:#fff;padding:56px 0 60px}
.eyebrow{text-transform:uppercase;letter-spacing:.18em;font-size:.74rem;font-weight:700;color:var(--mint);margin-bottom:14px}
.phero h1{font-size:clamp(2rem,5vw,3rem);line-height:1.08;letter-spacing:-.02em;font-weight:800;margin-bottom:16px}
.phero p{font-size:1.1rem;color:rgba(255,255,255,.9);max-width:62ch}
.crumb{font-size:.85rem;color:var(--mint);margin-bottom:20px}
.crumb a{color:var(--mint);text-decoration:none}.crumb a:hover{text-decoration:underline}
main{padding:44px 0 10px}
section.blk{background:var(--card);border:1px solid var(--border);border-radius:16px;padding:26px 28px;margin-bottom:18px}
section.blk h2{font-size:1.18rem;font-weight:700;margin-bottom:10px;color:var(--green-dark)}
section.blk p{color:#31402f}
.season{background:var(--mint-soft);border-color:#bcdcbe}
.chips{display:flex;flex-wrap:wrap;gap:9px;margin-top:6px}
.chip{display:inline-block;padding:7px 15px;border-radius:999px;font-size:.92rem;font-weight:600;text-decoration:none}
.chip.good{background:var(--mint-soft);color:#25502f}
.chip.bad{background:var(--clay-soft);color:#7d3f2c}
.chip.good:hover{background:var(--mint)}
.lbl{font-size:.72rem;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:var(--muted);margin:14px 0 4px}
.tip{margin-top:16px;font-style:italic;color:var(--muted)}
.cta{background:linear-gradient(160deg,var(--green) 0%,var(--green-dark) 100%);color:#fff;border-radius:18px;padding:34px 30px;text-align:center;margin:26px 0}
.cta h2{font-size:1.5rem;margin-bottom:10px}
.cta p{color:rgba(255,255,255,.88);max-width:46ch;margin:0 auto 20px}
.appstore{display:inline-block;background:#111;color:#fff;text-decoration:none;padding:14px 26px;border-radius:14px;font-weight:600}
.appstore:hover{background:#000}
.rel{margin:30px 0 50px}
.rel h2{font-size:1.05rem;color:var(--muted);margin-bottom:12px;font-weight:700}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(180px,1fr));gap:12px}
.grid a{background:var(--card);border:1px solid var(--border);border-radius:12px;padding:14px 16px;text-decoration:none;font-weight:600;color:var(--ink)}
.grid a:hover{border-color:var(--green-2);color:var(--green)}
.az{margin:34px 0 60px}
.az h2{font-size:1.4rem;margin-bottom:6px}
.az p.sub{color:var(--muted);margin-bottom:22px}
footer{background:var(--green-dark);color:#dceadd;padding:40px 0;text-align:center}
.brand-f{font-weight:700;font-size:1.1rem;color:#fff;margin-bottom:6px}
.tagline{font-size:.9rem;opacity:.8;margin-bottom:16px}
footer .links{display:flex;gap:20px;justify-content:center;flex-wrap:wrap;font-size:.9rem;margin-bottom:14px}
footer .links a{color:#cfe1d1}
.copy{font-size:.8rem;opacity:.6}
.shopblk{background:#fbfaf6}
.pblurb{color:var(--muted);margin-bottom:10px}
.disc{font-size:.82rem;color:var(--muted);background:#f1f5ef;border:1px solid var(--border);
border-radius:10px;padding:10px 13px;margin-bottom:16px}
.prods{display:grid;grid-template-columns:repeat(auto-fill,minmax(220px,1fr));gap:12px}
.prod{display:flex;flex-direction:column;gap:4px;background:#fff;border:1px solid var(--border);
border-radius:12px;padding:14px 16px;text-decoration:none}
.prod:hover{border-color:var(--green-2)}
.pcat{font-size:.68rem;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--green-2)}
.pname{font-weight:600;color:var(--ink);line-height:1.35}
.pmeta{font-size:.85rem;color:var(--muted)}
.shophdr{margin:0 0 18px}
.shophdr h2{font-size:1.3rem;margin-bottom:4px}
@media(max-width:640px){.phero{padding:40px 0 44px}section.blk{padding:22px 20px}}
'''

SECTIONS = [
    ("bestSeason",     "When to plant",     "season"),
    ("soilPrep",       "Soil &amp; site",   ""),
    ("fertilizing",    "Feeding",           ""),
    ("commonProblems", "Common problems",   ""),
    ("harvestSigns",   "When to harvest",   ""),
    ("harvestHow",     "How to harvest",    ""),
    ("storageUse",     "Storage &amp; use", ""),
]


def build_shop(products):
    """A modest catch-all shop page. The real work happens contextually inside
    the plant guides — a standalone link farm is thin content and ranks badly."""
    order = ["Seeds", "Soil & Amendments", "Fertilizers", "Watering", "Tools",
             "Pots & Containers", "Trellises & Supports", "Pest Control",
             "Grow Lights", "Smart Gardens", "Outdoor Lighting"]
    cats = {}
    for pr in products:
        cats.setdefault(pr["category"], []).append(pr)

    t = "Garden Gear We Recommend — Tools, Seeds & Supplies"
    desc = ("Garden tools, seeds, soil, fertilizer and supplies we recommend for planning "
            "and growing a vegetable garden.")
    canon = f"{BASE}/shop/"
    out = [head(t, desc, canon)]
    out.append(f'''<header class="phero"><div class="wrap">
  <div class="crumb"><a href="/">Home</a> › Shop</div>
  <div class="eyebrow">Recommended Gear</div>
  <h1>Garden gear we recommend</h1>
  <p>Things we point people to for planning, planting and keeping a garden alive.
  Every plant guide has picks chosen for that specific plant — this is the full list.</p>
</div></header>
<main><div class="wrap">
<section class="blk"><p class="disc">{e(DISCLOSURE)}</p>
<p>We only list gear that fits the way the app tells you to garden. Prices are estimates and
change — the store page is always right.</p></section>''')

    for c in order:
        if c not in cats:
            continue
        out.append(f'<div class="shophdr"><h2>{e(c)}</h2></div>')
        out.append(product_cards(cats[c], e(c), f"{len(cats[c])} picks").replace(
            f'<section class="blk shopblk"><h2>{e(c)}</h2><p class="pblurb">{len(cats[c])} picks</p>'
            f'<p class="disc">{e(DISCLOSURE)}</p>', '<section class="blk shopblk">'))

    out.append(f'''<div class="cta"><h2>Know what to plant before you buy it</h2>
  <p>Sprout Together plans your beds and tells you when to plant and harvest for where you live — free.</p>
  <a class="appstore" href="{APPSTORE}">Get it on the App Store</a></div>
</div></main>{FOOTER}
</body></html>
''')
    d = os.path.join(SITE, "shop")
    os.makedirs(d, exist_ok=True)
    open(os.path.join(d, "index.html"), "w").write("\n".join(out))


def build_disclosure():
    t = "Affiliate Disclosure"
    desc = ("How Sprout Together uses affiliate links, which programs we take part in, "
            "and what it means for you.")
    canon = f"{BASE}/affiliate-disclosure/"
    out = [head(t, desc, canon)]
    out.append(f'''<header class="phero"><div class="wrap">
  <div class="crumb"><a href="/">Home</a> › Affiliate Disclosure</div>
  <div class="eyebrow">Transparency</div>
  <h1>Affiliate disclosure</h1>
  <p>The short version: some links here earn us a commission. It never changes what you pay,
  and it never decides what we recommend.</p>
</div></header>
<main><div class="wrap">
<section class="blk"><h2>What affiliate links are</h2>
<p>Some links on this site and in the Sprout Together app point to online stores. If you buy
something after following one, the store may pay us a small commission. The price you pay is
exactly the same either way.</p></section>

<section class="blk"><h2>Amazon</h2>
<p>As an Amazon Associate I earn from qualifying purchases. Sprout Together is a participant in
the Amazon Services LLC Associates Program, an affiliate advertising program designed to provide
a means for sites to earn advertising fees by advertising and linking to Amazon.com.</p></section>

<section class="blk"><h2>Other programs</h2>
<p>We also take part in affiliate programs run through CJ Affiliate and Impact, including
Click &amp; Grow. The same rules apply: a commission to us, no difference in price to you.</p></section>

<section class="blk"><h2>How we choose what to recommend</h2>
<p>Recommendations are based on what actually helps with the plant or task on the page. On a
plant guide you will only see gear that suits that plant — we do not put a tomato-specific
product on the basil page to fill space. Nobody pays us for placement, and a commission does
not move anything up the list.</p>
<p>Prices shown are estimates and go out of date. The store page is always the accurate one.</p></section>

<section class="blk"><h2>Questions</h2>
<p>Email <a href="mailto:hello@sprouttogether.app">hello@sprouttogether.app</a>.</p></section>
</div></main>{FOOTER}
</body></html>
''')
    d = os.path.join(SITE, "affiliate-disclosure")
    os.makedirs(d, exist_ok=True)
    open(os.path.join(d, "index.html"), "w").write("\n".join(out))


def build():
    global PRODUCTS
    PRODUCTS = load_products()
    kb, comp = load_knowledge(), load_companions()
    names = sorted(kb)
    known = {n: slug(n) for n in names}
    os.makedirs(PLANTS_DIR, exist_ok=True)
    open(os.path.join(PLANTS_DIR, "guide.css"), "w").write(CSS.strip() + "\n")

    def link_if_known(word):
        """Link a companion name to its guide page when we have one."""
        w = word.lower().strip()
        for n, sl in known.items():
            if n == w or n == w + "s" or w == n + "s":
                return f'<a class="chip good" href="/plants/{sl}/">{e(title(word))}</a>'
        return None

    for i, name in enumerate(names):
        rec, sl, disp = kb[name], known[name], title(name)
        t = f"How to Grow {disp}: Planting, Care &amp; Harvest Guide"
        t_plain = f"How to Grow {disp}: Planting, Care & Harvest Guide"
        desc = trim(f"{disp} growing guide: when to plant, soil and feeding, common problems, "
                    f"when and how to harvest. {rec['bestSeason']}")
        canon = f"{BASE}/plants/{sl}/"
        ld = {"@context": "https://schema.org", "@type": "Article",
              "headline": t_plain, "description": desc,
              "mainEntityOfPage": canon, "image": f"{BASE}/img/og-image.png",
              "author": {"@type": "Organization", "name": "Sprout Together"},
              "publisher": {"@type": "Organization", "name": "Sprout Together"}}
        crumb = {"@context": "https://schema.org", "@type": "BreadcrumbList", "itemListElement": [
            {"@type": "ListItem", "position": 1, "name": "Home", "item": BASE},
            {"@type": "ListItem", "position": 2, "name": "Plant Guides", "item": f"{BASE}/plants/"},
            {"@type": "ListItem", "position": 3, "name": disp, "item": canon}]}
        extra = ('<script type="application/ld+json">' + json.dumps(ld) + '</script>\n'
                 '<script type="application/ld+json">' + json.dumps(crumb) + '</script>')

        p = [head(t_plain, desc, canon, extra)]
        p.append(f'''<header class="phero"><div class="wrap">
  <div class="crumb"><a href="/">Home</a> › <a href="/plants/">Plant Guides</a> › {e(disp)}</div>
  <div class="eyebrow">Plant Guide</div>
  <h1>How to Grow {e(disp)}</h1>
  <p>Everything you need to grow {e(disp.lower())} well — when to plant, how to prepare the soil,
  what to feed it, what usually goes wrong, and how to tell it's ready to harvest.</p>
</div></header>
<main><div class="wrap">''')
        for key, heading, cls in SECTIONS:
            p.append(f'<section class="blk {cls}"><h2>{heading}</h2><p>{e(rec[key])}</p></section>')

        c = comp.get(name) or comp.get(name.replace("cherry ", ""))
        if c:
            good = "".join(link_if_known(g) or f'<span class="chip good">{e(title(g))}</span>' for g in c["good"])
            bad = "".join(f'<span class="chip bad">{e(title(b))}</span>' for b in c["bad"])
            p.append(f'''<section class="blk"><h2>Companion planting</h2>
  <div class="lbl">Plant with</div><div class="chips">{good}</div>
  <div class="lbl">Keep apart</div><div class="chips">{bad}</div>
  <p class="tip">{e(c["tip"])}</p></section>''')

        picks = products_for_plant(name, PRODUCTS)
        if picks:
            p.append(product_cards(
                picks, f"Useful for growing {e(disp.lower())}",
                "A few things that make this one easier — chosen for this plant, not a generic list."))

        p.append(f'''<div class="cta">
  <h2>Growing {e(disp)} this season?</h2>
  <p>Sprout Together plans your beds, tracks planting and harvest timing for your area, and keeps every guide in your pocket — free.</p>
  <a class="appstore" href="{APPSTORE}">Get it on the App Store</a>
</div>''')

        rel = [names[(i + k) % len(names)] for k in range(1, 9)]
        p.append('<div class="rel"><h2>More plant guides</h2><div class="grid">'
                 + "".join(f'<a href="/plants/{known[r]}/">{e(title(r))}</a>' for r in rel)
                 + '</div></div></div></main>' + FOOTER + '\n</body></html>\n')

        d = os.path.join(PLANTS_DIR, sl)
        os.makedirs(d, exist_ok=True)
        open(os.path.join(d, "index.html"), "w").write("\n".join(p))

    # hub
    desc = f"Free growing guides for {len(names)} plants — when to plant, soil, feeding, common problems, and when to harvest."
    hub = [head("Plant Guides — How to Grow " + str(len(names)) + " Vegetables, Herbs & Fruit",
                desc, f"{BASE}/plants/")]
    hub.append(f'''<header class="phero"><div class="wrap">
  <div class="crumb"><a href="/">Home</a> › Plant Guides</div>
  <div class="eyebrow">Free Plant Guides</div>
  <h1>How to grow {len(names)} plants</h1>
  <p>Straightforward growing guides — when to plant, how to prepare the soil, what to feed, what can go wrong, and how to know it's ready.</p>
</div></header>
<main><div class="wrap"><div class="az">
  <h2>All plants</h2><p class="sub">Every guide is free, and they're all in the Sprout Together app too.</p>
  <div class="grid">''')
    hub.append("".join(f'<a href="/plants/{known[n]}/">{e(title(n))}</a>' for n in names))
    hub.append(f'''</div></div>
  <div class="cta"><h2>Plan your whole garden</h2>
  <p>Lay out your beds, drop in plants, and get planting and harvest timing for where you live — free.</p>
  <a class="appstore" href="{APPSTORE}">Get it on the App Store</a></div>
</div></main>{FOOTER}
</body></html>
''')
    open(os.path.join(PLANTS_DIR, "index.html"), "w").write("\n".join(hub))

    build_shop(PRODUCTS)
    build_disclosure()

    # sitemap + robots
    urls = [(BASE + "/", "1.0"), (f"{BASE}/plants/", "0.9"), (f"{BASE}/shop/", "0.6"), (f"{BASE}/affiliate-disclosure/", "0.3")] + \
           [(f"{BASE}/plants/{known[n]}/", "0.8") for n in names] + \
           [(f"{BASE}/privacy-policy", "0.3"), (f"{BASE}/terms-of-service", "0.3")]
    sm = ['<?xml version="1.0" encoding="UTF-8"?>',
          '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">']
    for u, pr in urls:
        sm.append(f"  <url><loc>{u}</loc><priority>{pr}</priority></url>")
    sm.append("</urlset>")
    open(os.path.join(SITE, "sitemap.xml"), "w").write("\n".join(sm) + "\n")
    open(os.path.join(SITE, "robots.txt"), "w").write(
        f"User-agent: *\nAllow: /\n\nSitemap: {BASE}/sitemap.xml\n")

    print(f"{len(names)} plant pages + hub + shop ({len(PRODUCTS)} products), sitemap ({len(urls)} urls), robots.txt")
    return names


if __name__ == "__main__":
    build()
