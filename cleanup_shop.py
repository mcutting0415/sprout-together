import re

with open('/sessions/zealous-eager-shannon/mnt/Downloads/sprout_together/lib/final_app_pages/shop_page/shop_page_widget.dart', 'r') as f:
    content = f.read()

# ── 1. NEW _categories (add Smart Gardens) ───────────────────────────────────
NEW_CATEGORIES = """  final List<String> _categories = [
    'All',
    'Smart Gardens',
    'Seeds',
    'Tools',
    'Soil & Amendments',
    'Fertilizers',
    'Pots & Containers',
    'Watering',
    'Trellises & Supports',
    'Pest Control',
    'Grow Lights',
    'Outdoor Lighting',
  ];"""

# ── 2. NEW _partnerStores (Amazon + Click & Grow only) ────────────────────────
NEW_PARTNER_STORES = """  // ── Partner stores ──────────────────────────────────────────────────────────
  static const List<Map<String, dynamic>> _partnerStores = [
    {
      'name': 'Click & Grow',
      'tagline': 'Smart indoor gardens — herbs, veggies & fruits year-round',
      'logo_emoji': '🌿',
      'color': 0xFF2E7D52,
      'url': 'https://www.anrdoezrs.net/click-8012865-4297609',
    },
    {
      'name': 'Amazon Garden',
      'tagline': 'Millions of garden products — tools, lights, soil & more',
      'logo_emoji': '📦',
      'color': 0xFFFF9900,
      'url': 'https://www.amazon.com/gardening?tag=sprouttogether-20',
    },
  ];"""

# ── 3. NEW Click & Grow products ──────────────────────────────────────────────
CG_BASE = 'https://www.anrdoezrs.net/click-8012865-4297609?url='
CG_PRODUCTS = """    // ── SMART GARDENS (Click & Grow — CJ affiliate, Active) ───────────────────
    {
      'name': 'Smart Garden 3 — Countertop Indoor Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$49.99',
      'is_featured': true,
      'affiliate_url': '""" + CG_BASE + """https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fthe-smart-garden-3',
      'image_url': 'https://images.unsplash.com/photo-1585501502957-37fca56e1e47?w=400&q=80&fit=crop',
    },
    {
      'name': 'Smart Garden 9 — Best-Selling Indoor Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$129.95',
      'is_featured': true,
      'affiliate_url': '""" + CG_BASE + """https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fthe-smart-garden-9',
      'image_url': 'https://images.unsplash.com/photo-1585501502957-37fca56e1e47?w=400&q=80&fit=crop',
    },
    {
      'name': 'Smart Garden 9 PRO — App-Controlled Indoor Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$229.95',
      'is_featured': false,
      'affiliate_url': '""" + CG_BASE + """https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fthe-smart-garden-9-pro',
      'image_url': 'https://images.unsplash.com/photo-1585501502957-37fca56e1e47?w=400&q=80&fit=crop',
    },
    {
      'name': 'Smart Garden 27 — Large Indoor Home Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$299.95',
      'is_featured': false,
      'affiliate_url': '""" + CG_BASE + """https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fsmart-garden-27-home-garden',
      'image_url': 'https://images.unsplash.com/photo-1585501502957-37fca56e1e47?w=400&q=80&fit=crop',
    },
    {
      'name': 'Click & Grow Herb Garden Plant Pods (9-Pack)',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$19.95',
      'is_featured': false,
      'affiliate_url': '""" + CG_BASE + """https%3A%2F%2Fwww.clickandgrow.com%2Fcollections%2Fplant-pods',
      'image_url': 'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
    },
    {
      'name': 'Click & Grow Tomato Plant Pods (3-Pack)',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$9.95',
      'is_featured': false,
      'affiliate_url': '""" + CG_BASE + """https%3A%2F%2Fwww.clickandgrow.com%2Fcollections%2Fplant-pods',
      'image_url': 'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
    },"""

# ── 4. NEW Amazon Seeds section ────────────────────────────────────────────────
AMZN_SEEDS = """    // ── SEEDS (Amazon Associates) ───────────────────────────────────────────
    {
      'name': 'Heirloom Vegetable Seed Collection (35 varieties)',
      'category': 'Seeds',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$28',
      'is_featured': true,
      'affiliate_url': 'https://www.amazon.com/s?k=heirloom+vegetable+seeds+collection&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=400&q=80&fit=crop',
    },
    {
      'name': 'Organic Herb Seeds Variety Pack (15 types)',
      'category': 'Seeds',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$12–$18',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=organic+herb+seeds+variety+pack&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
    },
    {
      'name': 'Microgreens Seed Growing Kit',
      'category': 'Seeds',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$14–$22',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=microgreens+seeds+growing+kit&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
    },
    {
      'name': 'Tomato Seed Variety Pack (10 types)',
      'category': 'Seeds',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$10–$16',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=tomato+seeds+variety+pack&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
    },
    {
      'name': 'Pepper Seed Assortment (Sweet & Hot)',
      'category': 'Seeds',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$8–$14',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=pepper+seeds+assortment+sweet+hot&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400&q=80&fit=crop',
    },"""

# ── Apply changes ─────────────────────────────────────────────────────────────

# 1. Replace categories
old_cats_match = re.search(r'  final List<String> _categories = \[.*?\];', content, re.DOTALL)
if old_cats_match:
    content = content[:old_cats_match.start()] + NEW_CATEGORIES + content[old_cats_match.end():]
    print("✅ Categories updated")
else:
    print("❌ Categories not found")

# 2. Replace _partnerStores block (from comment to closing ];)
old_stores_match = re.search(r'  // ── Partner stores ──.*?  \];', content, re.DOTALL)
if old_stores_match:
    content = content[:old_stores_match.start()] + NEW_PARTNER_STORES + content[old_stores_match.end():]
    print("✅ Partner stores updated")
else:
    print("❌ Partner stores not found")

# 3. Replace _curatedProducts: extract only Amazon products, prepend CG + Amazon seeds
products_match = re.search(r'  static const List<Map<String, dynamic>> _curatedProducts = \[(.*?)\n  \];', content, re.DOTALL)
if not products_match:
    print("❌ _curatedProducts not found")
else:
    products_block = products_match.group(1)
    
    # Split into individual product maps
    # Find all product entries (from { to },) 
    product_entries = re.findall(r'\n    \{.*?\n    \},', products_block, re.DOTALL)
    
    # Keep only Amazon Garden products
    amazon_products = [p for p in product_entries if "'store_name': 'Amazon Garden'" in p]
    print(f"✅ Found {len(product_entries)} total products, keeping {len(amazon_products)} Amazon products")
    
    # Build new products block
    # Group Amazon products by category for the comment headers
    amazon_by_cat = {}
    for p in amazon_products:
        cat_match = re.search(r"'category': '([^']+)'", p)
        cat = cat_match.group(1) if cat_match else 'Other'
        amazon_by_cat.setdefault(cat, []).append(p)
    
    # Build the new block with category headers
    cat_order = ['Seeds', 'Tools', 'Soil & Amendments', 'Fertilizers', 'Pots & Containers', 
                 'Watering', 'Trellises & Supports', 'Pest Control', 'Grow Lights', 'Outdoor Lighting']
    
    new_products_parts = ['\n' + CG_PRODUCTS + '\n' + AMZN_SEEDS]
    for cat in cat_order:
        if cat in amazon_by_cat:
            new_products_parts.append('\n    // ── ' + cat.upper() + ' (Amazon) ' + '─' * max(1, 55 - len(cat)))
            for p in amazon_by_cat[cat]:
                new_products_parts.append(p)
    
    new_products_block = ''.join(new_products_parts) + '\n  '
    new_curated = '  static const List<Map<String, dynamic>> _curatedProducts = [' + new_products_block + '];'
    
    content = content[:products_match.start()] + new_curated + content[products_match.end():]
    print("✅ _curatedProducts updated")

# Write back
with open('/sessions/zealous-eager-shannon/mnt/Downloads/sprout_together/lib/final_app_pages/shop_page/shop_page_widget.dart', 'w') as f:
    f.write(content)
print("✅ File written")
