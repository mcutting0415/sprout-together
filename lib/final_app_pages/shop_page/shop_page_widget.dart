import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'shop_page_model.dart';
export 'shop_page_model.dart';

class ShopPageWidget extends StatefulWidget {
  const ShopPageWidget({super.key});

  static String routeName = 'ShopPage';
  static String routePath = '/shopPage';

  @override
  State<ShopPageWidget> createState() => _ShopPageWidgetState();
}

class _ShopPageWidgetState extends State<ShopPageWidget>
    with SingleTickerProviderStateMixin {
  late ShopPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _categories = [
    'All',
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
  ];

  // ── Partner stores ──────────────────────────────────────────────────────────
  // Replace the affiliate_url values with your actual affiliate tracking URLs
  // once you've joined each program.
  static const List<Map<String, dynamic>> _partnerStores = [
    {
      'name': 'True Leaf Market',
      'tagline': 'Organic & heirloom seeds, microgreens & sprouting supplies',
      'logo_emoji': '🌿',
      'color': 0xFF4E7A2E,
      // TODO: replace with your True Leaf Market affiliate URL
      'url': 'https://www.trueleafmarket.com/',
    },
    {
      'name': "Gardener's Supply Co",
      'tagline': 'Premium tools, raised beds, planters & soil amendments',
      'logo_emoji': '🪴',
      'color': 0xFF2E7D52,
      // TODO: replace with your Gardener's Supply affiliate URL
      'url': 'https://www.gardeners.com/',
    },
    {
      'name': 'Burpee',
      'tagline': 'America\'s top seed brand — vegetables, herbs & flowers',
      'logo_emoji': '🌱',
      'color': 0xFF5C8A1A,
      // TODO: replace with your Burpee affiliate URL
      'url': 'https://www.burpee.com/',
    },
    {
      'name': 'Amazon Garden',
      'tagline': 'Millions of garden products — tools, lights, soil & more',
      'logo_emoji': '📦',
      'color': 0xFFFF9900,
      // TODO: replace with your Amazon Associates affiliate URL
      'url': 'https://www.amazon.com/gardening?tag=sprouttogether-20',
    },
    {
      'name': "Johnny's Selected Seeds",
      'tagline': 'Professional-quality vegetable & herb seeds for every grower',
      'logo_emoji': '🫘',
      'color': 0xFF1A6B3C,
      // TODO: replace with your Johnny's affiliate URL
      'url': 'https://www.johnnyseeds.com/',
    },
  ];

  // ── Curated products (hardcoded) ─────────────────────────────────────────
  // These show in the grid alongside any DB products.
  // Replace affiliate_url values with your tracked links.
  static const List<Map<String, dynamic>> _curatedProducts = [
    // ── SEEDS ──────────────────────────────────────────────────────────────
    {
      'name': 'Organic Tomato Seed Collection',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$12–$18',
      'is_featured': true,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/tomato-seeds',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/best-selling-tomatoes-collection-Comp.jpg?v=1756309253',
    },
    {
      'name': 'Microgreens Starter Seed Kit',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$19.99',
      'is_featured': false,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/microgreens-seeds',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/microgreens-deluxe-kit-comp_2d791e21-5d3d-472b-982a-cc7fcf3f6e65.jpg?v=1762440795',
    },
    {
      'name': 'Heirloom Vegetable Seed Vault',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$24.99',
      'is_featured': false,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/heirloom-seeds',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Instant-Garden-Heirloom-Vegetable-Seed-Collection-With-Comp.jpg?v=1761160549',
    },
    {
      'name': 'Organic Herb Seed Collection',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$14.99',
      'is_featured': false,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/herb-seeds',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Organic_Herb_Collection_8_Pack_Collage_Comp.jpg?v=1778194453',
    },
    {
      'name': 'Burpee Big Boy Tomato Seeds',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$4.99',
      'is_featured': true,
      'affiliate_url': 'https://www.burpee.com/vegetables/tomatoes/',
      'image_url': 'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
    },
    {
      'name': 'Patio Garden Pepper Seed Mix',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$5.99',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/vegetables/peppers/',
      'image_url': 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400&q=80&fit=crop',
    },
    {
      'name': 'Organic Salad Green Blend',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$6.49',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/vegetables/lettuce/',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/lettuce-salad-leaf-blend-mix-com-wm_1222x1222_3570a053-1fa4-4e2b-9828-fc381d6c3376.jpg?v=1764633742',
    },
    {
      'name': 'Cucumber Seed Variety Pack',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$5.49',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/vegetables/cucumbers/',
      'image_url': 'https://images.unsplash.com/photo-1604977042946-1eecc30f269e?w=400&q=80&fit=crop',
    },
    {
      'name': 'Herb Garden Seed Collection',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$9.99',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/herbs/',
      'image_url': 'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
    },
    {
      'name': 'Sungold Cherry Tomato Seeds',
      'category': 'Seeds',
      'store_name': "Johnny's Selected Seeds",
      'price_estimate': r'$5.45',
      'is_featured': true,
      'affiliate_url': 'https://www.johnnyseeds.com/vegetables/tomatoes/cherry-tomatoes/',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Tomato-Seeds-Cherry-Sungold-Hybrid-comp.jpg?v=1762440731',
    },
    {
      'name': 'Organic Carrot Mix — Rainbow Blend',
      'category': 'Seeds',
      'store_name': "Johnny's Selected Seeds",
      'price_estimate': r'$4.75',
      'is_featured': false,
      'affiliate_url': 'https://www.johnnyseeds.com/vegetables/carrots/',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Carrot-Seeds-Rainbow-Blend-Organic-comp.jpg?v=1762440662',
    },
    {
      'name': 'Salanova Lettuce Seeds',
      'category': 'Seeds',
      'store_name': "Johnny's Selected Seeds",
      'price_estimate': r'$5.25',
      'is_featured': false,
      'affiliate_url': 'https://www.johnnyseeds.com/vegetables/lettuce/',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/lettuce-salad-leaf-blend-mix-com-wm_1222x1222_3570a053-1fa4-4e2b-9828-fc381d6c3376.jpg?v=1764633742',
    },
    {
      'name': 'Dragon Tongue Bean Seeds',
      'category': 'Seeds',
      'store_name': "Johnny's Selected Seeds",
      'price_estimate': r'$3.95',
      'is_featured': false,
      'affiliate_url': 'https://www.johnnyseeds.com/vegetables/beans/',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/dragons-tongue-beans-wm_700_1222x1222_2396e638-12b9-4e6a-8554-34123c4a7bef.jpg?v=1764633795',
    },
    {
      'name': 'Sprouting Seed Variety Pack (6 types)',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$16.99',
      'is_featured': false,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/sprouting-seeds',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Sprouting-Seed-Super-Sampler_3060041e-88a5-4873-ac9a-44440c6c9f5e.jpg?v=1762440321',
    },

    // ── TOOLS ──────────────────────────────────────────────────────────────
    {
      'name': 'CobraHead Long-Handle Weeder & Cultivator',
      'category': 'Tools',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$39.95',
      'is_featured': true,
      'affiliate_url': 'https://www.gardeners.com/category/garden-tools',
      'image_url': 'https://www.cobrahead.com/cdn/shop/products/CobraHead_Long_Handle__25828.1556630747.1280.1280.jpg?v=1747076970',
    },
    {
      'name': 'Stainless-Steel Hand Trowel Set (3-pc)',
      'category': 'Tools',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$29.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/garden-tools',
      'image_url': 'https://www.cobrahead.com/cdn/shop/products/cobrahead_mini_15__82045.1618102065.1280.1280.jpg?v=1747076981',
    },
    {
      'name': 'Soil Knife (Hori Hori) with Sheath',
      'category': 'Tools',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$22–$35',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=hori+hori+soil+knife&tag=sprouttogether-20',
      'image_url': 'https://www.cobrahead.com/cdn/shop/products/CobraHead_Mini_one_hand_compressed__07992.1614093205.1280.1280.jpg?v=1764114694',
    },
    {
      'name': 'Heavy-Duty Garden Pruning Shears',
      'category': 'Tools',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$32',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+pruning+shears&tag=sprouttogether-20',
      'image_url': 'https://www.cobrahead.com/cdn/shop/files/FELCO_2Whitebackground.webp?v=1753140663',
    },
    {
      'name': 'Broadfork Garden Fork (10-tine)',
      'category': 'Tools',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$89.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/garden-tools',
      'image_url': 'https://www.cobrahead.com/cdn/shop/products/CobraHead_Broadfork_white_background__79224.1644507789.1280.1280.jpg?v=1747076956',
    },
    {
      'name': 'Transplanting Dibber & Ruler',
      'category': 'Tools',
      'store_name': "Johnny's Selected Seeds",
      'price_estimate': r'$12.95',
      'is_featured': false,
      'affiliate_url': 'https://www.johnnyseeds.com/tools-supplies/hand-tools/',
      'image_url': 'https://www.cobrahead.com/cdn/shop/products/cobrahead_mini_12__87065.1618102066.1280.1280.jpg?v=1764114694',
    },
    {
      'name': 'Soil pH & Moisture Meter',
      'category': 'Tools',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$12–$20',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=soil+pH+moisture+meter&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/LusterLeafRapitestSoilpHMeter.jpg?v=1738527527',
    },
    {
      'name': 'Seedling Heat Mat (10×20 in)',
      'category': 'Tools',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$29.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/starting-seeds',
      'image_url': 'https://trimleaf.com/cdn/shop/files/VIVOSUN_Durable_Waterproof_Seedling_Heat_Mat_10_x_20.75_Structure_600x.webp?v=1748790264',
    },

    // ── SOIL & AMENDMENTS ─────────────────────────────────────────────────
    {
      'name': 'Premium Potting Mix (2 cu ft)',
      'category': 'Soil & Amendments',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$19.99',
      'is_featured': true,
      'affiliate_url': 'https://www.gardeners.com/category/soil-conditioners',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/collections/fc48045ec4fa904be3f8ddc7a4eee59b.jpg?v=1635871651',
    },
    {
      'name': 'Worm Castings (20 lbs)',
      'category': 'Soil & Amendments',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$24.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/fertilizers',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Worm-Castings-Comp.jpg?v=1762440335',
    },
    {
      'name': 'Perlite for Drainage (8 qt)',
      'category': 'Soil & Amendments',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$14–$18',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=horticultural+perlite&tag=sprouttogether-20',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/perlite-wm_1_1222x1222_0ec1fbb2-971b-46cc-b9b1-c419857199a5.jpg?v=1764633919',
    },
    {
      'name': 'Organic Compost Activator',
      'category': 'Soil & Amendments',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$16.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/compost',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/1686148576_CopyofTL-WM-Black-2023-06-07T081603.985.jpg?v=1762449629',
    },
    {
      'name': 'Raised Bed Soil Blend (1.5 cu ft)',
      'category': 'Soil & Amendments',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$17–$24',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=raised+bed+soil&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/collections/fc48045ec4fa904be3f8ddc7a4eee59b.jpg?v=1635871651',
    },
    {
      'name': 'Coco Coir Brick (10 lbs compressed)',
      'category': 'Soil & Amendments',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$28',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=coco+coir+brick&tag=sprouttogether-20',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Collage_Minute_Soil_2_50be3d92-ca63-4cdf-bbed-d3cf8fca2acd.jpg?v=1776821374',
    },

    // ── FERTILIZERS ───────────────────────────────────────────────────────
    {
      'name': 'Fish & Seaweed All-Purpose Fertilizer',
      'category': 'Fertilizers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$18.95',
      'is_featured': true,
      'affiliate_url': 'https://www.gardeners.com/category/fertilizers',
      'image_url': 'https://growitnaturally.com/cdn/shop/products/NH_Blend_Family2.png?v=1511019725',
    },
    {
      'name': 'Tomato & Vegetable Fertilizer (4 lbs)',
      'category': 'Fertilizers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$15–$22',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=tomato+vegetable+fertilizer&tag=sprouttogether-20',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/1745345731_fertilizer_espoma_plant_tone_5_3_3_organic_4lb_bag_comp_ed1747a6-e555-4d09-835e-d961d8ffbac1.jpg?v=1762453402',
    },
    {
      'name': 'Slow-Release Granular Fertilizer (5 lbs)',
      'category': 'Fertilizers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$26',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=slow+release+garden+fertilizer&tag=sprouttogether-20',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/1740507920_fertilizer_espoma_garden_food_10_10_10_675lb_bag_wm_comp_1bbd3198-7fb7-45da-9b03-014f49de965b.jpg?v=1762453068',
    },
    {
      'name': 'Liquid Kelp Fertilizer (16 oz)',
      'category': 'Fertilizers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$14.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/fertilizers',
      'image_url': 'https://growitnaturally.com/cdn/shop/products/NH_Blend_Family2.png?v=1511019725',
    },
    {
      'name': 'Organic Raised Bed Fertilizer Kit',
      'category': 'Fertilizers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$22.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/fertilizers',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/1686149300_CopyofTL-WM-Black-2023-06-07T081056.984.jpg?v=1762449630',
    },
    {
      'name': 'Mycorrhizae Root Builder (4 oz)',
      'category': 'Fertilizers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$16–$24',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=mycorrhizae+root+stimulator&tag=sprouttogether-20',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/1686148778_CopyofTL-WM-Black-2023-06-07T081508.924.jpg?v=1762449629',
    },

    // ── POTS & CONTAINERS ─────────────────────────────────────────────────
    {
      'name': 'Elevated Cedar Raised Bed (4×8 ft)',
      'category': 'Pots & Containers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$129–$179',
      'is_featured': true,
      'affiliate_url': 'https://www.gardeners.com/category/raised-garden-beds',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/AssembledGroRiteBed.jpg?v=1741982075',
    },
    {
      'name': 'Self-Watering Planter (12 in)',
      'category': 'Pots & Containers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$34.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/planters',
      'image_url': 'https://growneer.com/wp-content/uploads/2024/08/AZ1172382MM-scaled.jpg',
    },
    {
      'name': 'Fabric Grow Bags — 5 Gallon (5-pack)',
      'category': 'Pots & Containers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$15–$22',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=fabric+grow+bags+5+gallon&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/collections/9a24eca57ca4528189a44a2abda4f4e8.jpg?v=1631817224',
    },
    {
      'name': 'Fabric Grow Bags — 10 Gallon (5-pack)',
      'category': 'Pots & Containers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$26',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=fabric+grow+bags+10+gallon&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/collections/9a24eca57ca4528189a44a2abda4f4e8.jpg?v=1631817224',
    },
    {
      'name': 'Window Box Planter Set (3-pack)',
      'category': 'Pots & Containers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$49.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/window-boxes',
      'image_url': 'https://growneer.com/wp-content/uploads/2024/08/1-77.jpg',
    },
    {
      'name': 'Square-Foot Gardening Grid Kit',
      'category': 'Pots & Containers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$24.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/raised-garden-beds',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/AssembledGroRiteBed.jpg?v=1741982075',
    },

    // ── WATERING ──────────────────────────────────────────────────────────
    {
      'name': 'Drip Irrigation Starter Kit (50 ft)',
      'category': 'Watering',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$34.95',
      'is_featured': true,
      'affiliate_url': 'https://www.gardeners.com/category/watering',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/products/raisedbeddripwateringkit.jpg?v=1668473813',
    },
    {
      'name': 'Adjustable Soaker Hose (25 ft)',
      'category': 'Watering',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$28',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=soaker+hose+garden&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/collections/hose.jpg?v=1684179555',
    },
    {
      'name': 'Copper Watering Can (1.3 gal)',
      'category': 'Watering',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$44.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/watering-cans',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/products/raisedbeddripwateringkit.jpg?v=1668473813',
    },
    {
      'name': 'Hose Wand with Adjustable Head',
      'category': 'Watering',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$20–$35',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+hose+wand&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/DripIrrigation_1.jpg?v=1683744743',
    },
    {
      'name': 'Automatic Drip Watering Spikes (12-pack)',
      'category': 'Watering',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$14–$20',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=automatic+plant+watering+spikes&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/DripIrrigation_1.jpg?v=1683744743',
    },
    {
      'name': 'Rain Gauge — Classic Glass',
      'category': 'Watering',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$12.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/watering',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/collections/hose.jpg?v=1684179555',
    },

    // ── TRELLISES & SUPPORTS ──────────────────────────────────────────────
    {
      'name': 'Adjustable Tomato Cage (3-pack)',
      'category': 'Trellises & Supports',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$39.95',
      'is_featured': true,
      'affiliate_url': 'https://www.gardeners.com/category/trellises-cages-supports',
      'image_url': 'https://growneer.com/wp-content/uploads/2024/08/tomato-cage.webp',
    },
    {
      'name': 'Heavy-Duty Bamboo Stakes (4 ft, 25-pack)',
      'category': 'Trellises & Supports',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$12–$18',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=bamboo+garden+stakes&tag=sprouttogether-20',
      'image_url': 'https://growneer.com/wp-content/uploads/2024/08/tomato-cage.webp',
    },
    {
      'name': 'A-Frame Garden Trellis (6 ft)',
      'category': 'Trellises & Supports',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$59.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/trellises-cages-supports',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/DIY_ARCH_EMT_624a8bad-e05c-4474-afb2-7df34a2833d2.jpg?v=1767033340',
    },
    {
      'name': 'Cucumber & Bean Trellis Netting (5×15 ft)',
      'category': 'Trellises & Supports',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$10–$16',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+trellis+netting&tag=sprouttogether-20',
      'image_url': 'https://trimleaf.com/cdn/shop/files/High_roller_trellis_netting_600x.webp?v=1770420986',
    },
    {
      'name': 'Plant Clips & Twist Ties Set (100-pc)',
      'category': 'Trellises & Supports',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$8–$14',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+plant+clips+ties&tag=sprouttogether-20',
      'image_url': 'https://growneer.com/wp-content/uploads/2024/08/1-banner-3.jpg',
    },
    {
      'name': 'Wall-Mount Fan Trellis (4 ft)',
      'category': 'Trellises & Supports',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$29.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/trellises-cages-supports',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/DIY_Vine_Trellis_5111dae1-26af-407b-90df-0eb413c9332a.jpg?v=1749568434',
    },

    // ── PEST CONTROL ──────────────────────────────────────────────────────
    {
      'name': 'Neem Oil Spray — Organic (32 oz)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$14–$20',
      'is_featured': true,
      'affiliate_url': 'https://www.amazon.com/s?k=neem+oil+garden+spray&tag=sprouttogether-20',
      'image_url': 'https://growitnaturally.com/cdn/shop/products/captainjacksneemoilfamily.jpg?v=1660443726',
    },
    {
      'name': 'Floating Row Cover — Frost & Pest Protection',
      'category': 'Pest Control',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$19.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/pest-controls',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/FrostBlanket_1.jpg?v=1696435102',
    },
    {
      'name': 'Copper Slug & Snail Barrier Tape (16 ft)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$10–$16',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=copper+slug+snail+barrier+tape&tag=sprouttogether-20',
      'image_url': 'https://growitnaturally.com/cdn/shop/products/captainjacksneemoilfamily.jpg?v=1660443726',
    },
    {
      'name': 'Yellow Sticky Insect Traps (24-pack)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$8–$14',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=yellow+sticky+traps+garden&tag=sprouttogether-20',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/BlueStickTrapCard12Pack.jpg?v=1727724646',
    },
    {
      'name': 'Diatomaceous Earth (4 lbs food grade)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$12–$18',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=food+grade+diatomaceous+earth&tag=sprouttogether-20',
      'image_url': 'https://growitnaturally.com/cdn/shop/products/Diatomaceousearthfamily.png?v=1660443726',
    },
    {
      'name': 'BT Spray — Caterpillar & Worm Control',
      'category': 'Pest Control',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$14.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/pest-controls',
      'image_url': 'https://growitnaturally.com/cdn/shop/products/captainjacksdeadbugfamily.jpg?v=1660443658',
    },
    {
      'name': 'Insect Netting with Frame (3×6 ft)',
      'category': 'Pest Control',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$29.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/pest-controls',
      'image_url': 'https://www.bootstrapfarmer.com/cdn/shop/files/InsectNetting_4c30afea-fa02-4053-9670-a08a2f7b1ea9.jpg?v=1699913403',
    },

    // ── GROW LIGHTS ───────────────────────────────────────────────────────
    {
      'name': 'LED Grow Light Bar — Full Spectrum (24 in)',
      'category': 'Grow Lights',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$28–$45',
      'is_featured': true,
      'affiliate_url': 'https://www.amazon.com/s?k=led+grow+light+bar+full+spectrum&tag=sprouttogether-20',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/Boost-MaxPro-Grow-Lights-Comp.jpg?v=1762450181',
    },
    {
      'name': 'Seedling Grow Light with Timer (4-panel)',
      'category': 'Grow Lights',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$69.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/grow-lights',
      'image_url': 'https://trimleaf.com/cdn/shop/products/horticulture-lighting-group-hlg-65-v2-led-grow-light-19937730298016_600x.jpg?v=1733805852',
    },
    {
      'name': 'Clip-On Grow Light for Windowsill',
      'category': 'Grow Lights',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$30',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=clip+on+grow+light+plant&tag=sprouttogether-20',
      'image_url': 'https://trimleaf.com/cdn/shop/files/IONLED36WCloneLEDFront_600x.webp?v=1754514804',
    },
    {
      'name': 'Full-Spectrum LED Panel 45W',
      'category': 'Grow Lights',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$35–$55',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=45w+led+grow+light+panel&tag=sprouttogether-20',
      'image_url': 'https://trimleaf.com/cdn/shop/files/horticulture-lighting-group-hlg-100-v2-veg-led-grow-light-41237983887576_600x.jpg?v=1733805845',
    },
    {
      'name': 'Indoor Herb Garden Grow Light Station',
      'category': 'Grow Lights',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$89.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/grow-lights',
      'image_url': 'https://trimleaf.com/cdn/shop/files/sunblaster-sunblaster-led-hydroponic-grow-system-39870958371032_600x.jpg?v=1733806187',
    },

    // ── OUTDOOR LIGHTING ──────────────────────────────────────────────────
    {
      'name': 'Solar Pathway Stake Lights (8-pack)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$22–$36',
      'is_featured': true,
      'affiliate_url': 'https://www.amazon.com/s?k=solar+pathway+garden+lights&tag=sprouttogether-20',
      'image_url': 'https://gigalumi.com/cdn/shop/files/XF-XIN-Warm-Scene-1200x1200-01_grande.jpg?v=1686619208',
    },
    {
      'name': 'Waterproof LED Garden Spotlights (2-pack)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$28–$45',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=waterproof+led+garden+spotlights&tag=sprouttogether-20',
      'image_url': 'https://gigalumi.com/cdn/shop/files/SP-MTY-2BC2_grande.jpg?v=1754986864',
    },
    {
      'name': 'Solar String Fairy Lights (33 ft)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$16–$25',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=solar+string+fairy+lights+outdoor&tag=sprouttogether-20',
      'image_url': 'https://gigalumi.com/cdn/shop/files/P-GX120-2YCO_-8_-2000x2000_grande.jpg?v=1775806920',
    },
    {
      'name': 'Motion-Activated Garden Floodlight',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$30–$50',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=motion+sensor+outdoor+floodlight&tag=sprouttogether-20',
      'image_url': 'https://gigalumi.com/cdn/shop/files/PWL-FGMP-2BM2_grande.jpg?v=1755151770',
    },
    {
      'name': 'Mason Jar Solar Lanterns (4-pack)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$20–$32',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=mason+jar+solar+lanterns+outdoor&tag=sprouttogether-20',
      'image_url': 'https://gigalumi.com/cdn/shop/files/MJL-6-Warm-Scene-1200x1200-02_grande.jpg?v=1687748984',
    },
  ];

  String _selectedCategory = 'All';
  List<Map<String, dynamic>> _allProducts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShopPageModel());
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final response = await SupaFlow.client
          .from('shop_products')
          .select()
          .eq('is_active', true)
          .order('is_featured', ascending: false)
          .order('display_order');
      final dbProducts = List<Map<String, dynamic>>.from(response as List);
      // Merge DB products with curated partner products; DB products go first
      final merged = [...dbProducts, ..._curatedProducts];
      setState(() {
        _allProducts = merged;
        _loading = false;
      });
    } catch (e) {
      // Fall back to curated products only if DB is unavailable
      setState(() {
        _allProducts = List<Map<String, dynamic>>.from(_curatedProducts);
        _loading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredProducts {
    if (_selectedCategory == 'All') return _allProducts;
    return _allProducts
        .where((p) => p['category'] == _selectedCategory)
        .toList();
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          children: [
            Container(
              height: 1.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            wrapWithModel(
              model: _model.finalHeaderModel,
              updateCallback: () => safeSetState(() {}),
              child: const FinalHeaderWidget(pageTitle: 'Garden Shop'),
            ),
            // ── Partner Stores banner ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 0.0, 4.0),
              child: Text(
                'Our Partners',
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              height: 100.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
                itemCount: _partnerStores.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10.0),
                itemBuilder: (context, i) {
                  final store = _partnerStores[i];
                  final color = Color(store['color'] as int);
                  return GestureDetector(
                    onTap: () => _openLink(store['url'] as String),
                    child: Container(
                      width: 210.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: color.withOpacity(0.25)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                store['logo_emoji'] as String,
                                style: const TextStyle(fontSize: 22.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  store['name'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  store['tagline'] as String,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.0,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Shop now →',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Category filter chips
            Container(
              height: 52.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8.0),
                itemBuilder: (context, i) {
                  final cat = _categories[i];
                  final selected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: selected
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: selected
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context).alternate,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              font: GoogleFonts.poppins(
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              color: selected
                                  ? Colors.white
                                  : FlutterFlowTheme.of(context).primaryText,
                              fontSize: 13.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Affiliate disclaimer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 13.0,
                      color: FlutterFlowTheme.of(context).secondaryText),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: Text(
                      'Links open partner stores. We may earn a small commission at no cost to you.',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.poppins(),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 11.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            // Product grid
            Expanded(
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    )
                  : _filteredProducts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.storefront_outlined,
                                  size: 48.0,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              const SizedBox(height: 12.0),
                              Text(
                                'No products in this category yet.',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.poppins(),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            childAspectRatio: 0.72,
                          ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return _ProductCard(
                              product: product,
                              onTap: () =>
                                  _openLink(product['affiliate_url'] ?? ''),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _shopProductImage(BuildContext context, Map<String, dynamic> product) {
  final rawUrl = (product['image_url'] ?? '') as String;
  final productName = (product['name'] ?? 'garden product') as String;
  final category = (product['category'] ?? '') as String;

  // Map categories to emojis for the placeholder
  final emoji = category == 'Seeds' ? '🌱'
      : category == 'Tools' ? '🔧'
      : category == 'Soil & Amendments' ? '🪱'
      : category == 'Pots & Containers' ? '🪴'
      : category == 'Pest Control' ? '🐛'
      : category == 'Grow Lights' ? '💡'
      : category == 'Outdoor Lighting' ? '🔆'
      : '🛍️';

  Widget placeholder() => Container(
    height: 120.0,
    width: double.infinity,
    decoration: BoxDecoration(
      color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 36.0)),
        const SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            productName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.0,
              color: FlutterFlowTheme.of(context).secondaryText,
            ),
          ),
        ),
      ],
    ),
  );

  // If no URL, generate one via dreamflow
  final imageUrl = rawUrl.isNotEmpty
      ? rawUrl
      : 'https://dimg.dreamflow.cloud/v1/image/${Uri.encodeComponent(productName)}';

  return CachedNetworkImage(
    imageUrl: imageUrl,
    height: 120.0,
    width: double.infinity,
    fit: BoxFit.cover,
    placeholder: (context, url) => placeholder(),
    errorWidget: (context, url, error) => placeholder(),
  );
}

Color _storeColor(String storeName) {
  if (storeName.contains('True Leaf')) return const Color(0xFF4E7A2E);
  if (storeName.contains('Gardener')) return const Color(0xFF2E7D52);
  if (storeName.contains('Burpee')) return const Color(0xFF5C8A1A);
  return const Color(0xFF7BA05B);
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const _ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isFeatured = product['is_featured'] == true;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isFeatured
                ? FlutterFlowTheme.of(context).primary.withOpacity(0.4)
                : FlutterFlowTheme.of(context).alternate,
            width: isFeatured ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: _shopProductImage(context, product),
                ),
                if (isFeatured)
                  Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '★ Top Pick',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 12.0,
                            letterSpacing: 0.0,
                            lineHeight: 1.4,
                          ),
                    ),
                    const SizedBox(height: 2.0),
                    if ((product['store_name'] ?? '').isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 2.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: _storeColor(product['store_name'] ?? '')
                              .withOpacity(0.10),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          product['store_name'],
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: _storeColor(product['store_name'] ?? ''),
                          ),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if ((product['price_estimate'] ?? '').isNotEmpty)
                          Text(
                            product['price_estimate'],
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .override(
                                  font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600),
                                  color:
                                      FlutterFlowTheme.of(context).primary,
                                  fontSize: 11.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .primary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Shop →',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
