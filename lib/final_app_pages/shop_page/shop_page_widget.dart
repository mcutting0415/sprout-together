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
  ];

  // ── Partner stores ──────────────────────────────────────────────────────────
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
  ];

  // ── Curated products (hardcoded) ─────────────────────────────────────────
  // These show in the grid alongside any DB products.
  // Replace affiliate_url values with your tracked links.
  static const List<Map<String, dynamic>> _curatedProducts = [
    // ── SMART GARDENS (Click & Grow — CJ affiliate, Active) ───────────────────
    {
      'name': 'Smart Garden 3 — Countertop Indoor Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$49.99',
      'is_featured': true,
      'affiliate_url': 'https://www.anrdoezrs.net/click-8012865-4297609?url=https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fthe-smart-garden-3',
      'image_url': 'https://images.unsplash.com/photo-1585501502957-37fca56e1e47?w=400&q=80&fit=crop',
    },
    {
      'name': 'Smart Garden 9 — Best-Selling Indoor Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$129.95',
      'is_featured': true,
      'affiliate_url': 'https://www.anrdoezrs.net/click-8012865-4297609?url=https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fthe-smart-garden-9',
      'image_url': 'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
    },
    {
      'name': 'Smart Garden 9 PRO — App-Controlled Indoor Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$229.95',
      'is_featured': false,
      'affiliate_url': 'https://www.anrdoezrs.net/click-8012865-4297609?url=https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fthe-smart-garden-9-pro',
      'image_url': 'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
    },
    {
      'name': 'Smart Garden 27 — Large Indoor Home Garden',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$299.95',
      'is_featured': false,
      'affiliate_url': 'https://www.anrdoezrs.net/click-8012865-4297609?url=https%3A%2F%2Fwww.clickandgrow.com%2Fproducts%2Fsmart-garden-27-home-garden',
      'image_url': 'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=400&q=80&fit=crop',
    },
    {
      'name': 'Click & Grow Herb Garden Plant Pods (9-Pack)',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$19.95',
      'is_featured': false,
      'affiliate_url': 'https://www.anrdoezrs.net/click-8012865-4297609?url=https%3A%2F%2Fwww.clickandgrow.com%2Fcollections%2Fplant-pods',
      'image_url': 'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
    },
    {
      'name': 'Click & Grow Tomato Plant Pods (3-Pack)',
      'category': 'Smart Gardens',
      'store_name': 'Click & Grow',
      'price_estimate': r'$9.95',
      'is_featured': false,
      'affiliate_url': 'https://www.anrdoezrs.net/click-8012865-4297609?url=https%3A%2F%2Fwww.clickandgrow.com%2Fcollections%2Fplant-pods',
      'image_url': 'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
    },
    // ── SEEDS (Amazon Associates) ───────────────────────────────────────────
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
    },
    // ── TOOLS (Amazon) ──────────────────────────────────────────────────
    {
      'name': 'Soil Knife (Hori Hori) with Sheath',
      'category': 'Tools',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$22–$35',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=hori+hori+soil+knife&tag=sprouttogether-20',
      // garden fork pushed into rich soil
      'image_url': 'https://images.unsplash.com/photo-1781521215146-5aa55e800b0d?w=400&q=80&fit=crop',
    },
    {
      'name': 'Heavy-Duty Garden Pruning Shears',
      'category': 'Tools',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$32',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+pruning+shears&tag=sprouttogether-20',
      // pruning shears / secateurs
      'image_url': 'https://images.unsplash.com/photo-1677941731347-0369249f7aa8?w=400&q=80&fit=crop',
    },
    {
      'name': 'Soil pH & Moisture Meter',
      'category': 'Tools',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$12–$20',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=soil+pH+moisture+meter&tag=sprouttogether-20',
      // hands working in dark rich soil
      'image_url': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=400&q=80&fit=crop',
    },
    // ── SOIL & AMENDMENTS (Amazon) ──────────────────────────────────────
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
      'name': 'Raised Bed Soil Blend (1.5 cu ft)',
      'category': 'Soil & Amendments',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$17–$24',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=raised+bed+soil&tag=sprouttogether-20',
      // seedlings in a raised garden bed — distinct from dark soil shot
      'image_url': 'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=400&q=80&fit=crop',
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
    // ── FERTILIZERS (Amazon) ────────────────────────────────────────────
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
      'name': 'Mycorrhizae Root Builder (4 oz)',
      'category': 'Fertilizers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$16–$24',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=mycorrhizae+root+stimulator&tag=sprouttogether-20',
      'image_url': 'https://cdn.shopify.com/s/files/1/2016/2681/files/1686148778_CopyofTL-WM-Black-2023-06-07T081508.924.jpg?v=1762449629',
    },
    // ── POTS & CONTAINERS (Amazon) ──────────────────────────────────────
    {
      'name': 'Fabric Grow Bags — 5 Gallon (5-pack)',
      'category': 'Pots & Containers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$15–$22',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=fabric+grow+bags+5+gallon&tag=sprouttogether-20',
      // bean vines growing — plant-in-bag / container context
      'image_url': 'https://images.unsplash.com/photo-1590165482129-1b8b27698780?w=400&q=80&fit=crop',
    },
    {
      'name': 'Fabric Grow Bags — 10 Gallon (5-pack)',
      'category': 'Pots & Containers',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$26',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=fabric+grow+bags+10+gallon&tag=sprouttogether-20',
      // tomato plant growing — larger container growing context
      'image_url': 'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
    },
    // ── WATERING (Amazon) ───────────────────────────────────────────────
    {
      'name': 'Adjustable Soaker Hose (25 ft)',
      'category': 'Watering',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$28',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=soaker+hose+garden&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1468971050039-be99497410af?w=400&q=80&fit=crop',
    },
    {
      'name': 'Hose Wand with Adjustable Head',
      'category': 'Watering',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$20–$35',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+hose+wand&tag=sprouttogether-20',
      // garden hose / spray nozzle
      'image_url': 'https://images.unsplash.com/photo-1680124744736-859f16257ef0?w=400&q=80&fit=crop',
    },
    {
      'name': 'Automatic Drip Watering Spikes (12-pack)',
      'category': 'Watering',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$14–$20',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=automatic+plant+watering+spikes&tag=sprouttogether-20',
      // plants with drip/moisture — distinct from drip irrigation kit
      'image_url': 'https://images.unsplash.com/photo-1661963694689-a800cae4e413?w=400&q=80&fit=crop',
    },
    // ── TRELLISES & SUPPORTS (Amazon) ───────────────────────────────────
    {
      'name': 'Heavy-Duty Bamboo Stakes (4 ft, 25-pack)',
      'category': 'Trellises & Supports',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$12–$18',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=bamboo+garden+stakes&tag=sprouttogether-20',
      // tall plants staked in garden — bamboo stakes context
      'image_url': 'https://images.unsplash.com/photo-1629978237678-3e6a2004958f?w=400&q=80&fit=crop',
    },
    {
      'name': 'Cucumber & Bean Trellis Netting (5×15 ft)',
      'category': 'Trellises & Supports',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$10–$16',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+trellis+netting&tag=sprouttogether-20',
      // passionflower / climbing vine — distinct from A-frame trellis shot
      'image_url': 'https://images.unsplash.com/photo-1628341423248-4b8c5c51a3cd?w=400&q=80&fit=crop',
    },
    {
      'name': 'Plant Clips & Twist Ties Set (100-pc)',
      'category': 'Trellises & Supports',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$8–$14',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=garden+plant+clips+ties&tag=sprouttogether-20',
      // bean vine climbing — plant-clip / tie context, distinct from tomato cage shot
      'image_url': 'https://images.unsplash.com/photo-1609473295863-2d9299af71d4?w=400&q=80&fit=crop',
    },
    // ── PEST CONTROL (Amazon) ───────────────────────────────────────────
    {
      'name': 'Neem Oil Spray — Organic (32 oz)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$14–$20',
      'is_featured': true,
      'affiliate_url': 'https://www.amazon.com/s?k=neem+oil+garden+spray&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
    },
    {
      'name': 'Copper Slug & Snail Barrier Tape (16 ft)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$10–$16',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=copper+slug+snail+barrier+tape&tag=sprouttogether-20',
      // garden tools on wood — barrier/copper tape product context
      'image_url': 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400&q=80&fit=crop',
    },
    {
      'name': 'Yellow Sticky Insect Traps (24-pack)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$8–$14',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=yellow+sticky+traps+garden&tag=sprouttogether-20',
      // marigold — companion planting / natural pest deterrent context
      'image_url': 'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
    },
    {
      'name': 'Diatomaceous Earth (4 lbs food grade)',
      'category': 'Pest Control',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$12–$18',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=food+grade+diatomaceous+earth&tag=sprouttogether-20',
      // dark rich soil / earth tones — powder/amendment product context
      'image_url': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=400&q=80&fit=crop',
    },
    // ── GROW LIGHTS (Amazon) ────────────────────────────────────────────
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
      'name': 'Clip-On Grow Light for Windowsill',
      'category': 'Grow Lights',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$18–$30',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=clip+on+grow+light+plant&tag=sprouttogether-20',
      // small herb plants on a windowsill — windowsill context
      'image_url': 'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
    },
    {
      'name': 'Full-Spectrum LED Panel 45W',
      'category': 'Grow Lights',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$35–$55',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=45w+led+grow+light+panel&tag=sprouttogether-20',
      // seedlings in raised tray — panel grow light context
      'image_url': 'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=400&q=80&fit=crop',
    },
    // ── OUTDOOR LIGHTING (Amazon) ───────────────────────────────────────
    {
      'name': 'Solar Pathway Stake Lights (8-pack)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$22–$36',
      'is_featured': true,
      'affiliate_url': 'https://www.amazon.com/s?k=solar+pathway+garden+lights&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1611095973763-414019e72400?w=400&q=80&fit=crop',
    },
    {
      'name': 'Waterproof LED Garden Spotlights (2-pack)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$28–$45',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=waterproof+led+garden+spotlights&tag=sprouttogether-20',
      'image_url': 'https://images.unsplash.com/photo-1498940757830-82f7813bf178?w=400&q=80&fit=crop',
    },
    {
      'name': 'Solar String Fairy Lights (33 ft)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$16–$25',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=solar+string+fairy+lights+outdoor&tag=sprouttogether-20',
      // passionflower with warm bokeh — fairy lights ambiance
      'image_url': 'https://images.unsplash.com/photo-1628341423248-4b8c5c51a3cd?w=400&q=80&fit=crop',
    },
    {
      'name': 'Motion-Activated Garden Floodlight',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$30–$50',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=motion+sensor+outdoor+floodlight&tag=sprouttogether-20',
      // outdoor lights / floodlight on wall
      'image_url': 'https://images.unsplash.com/photo-1498940757830-82f7813bf178?w=400&q=80&fit=crop',
    },
    {
      'name': 'Mason Jar Solar Lanterns (4-pack)',
      'category': 'Outdoor Lighting',
      'store_name': 'Amazon Garden',
      'price_estimate': r'$20–$32',
      'is_featured': false,
      'affiliate_url': 'https://www.amazon.com/s?k=mason+jar+solar+lanterns+outdoor&tag=sprouttogether-20',
      // peony / warm romantic garden flowers — lantern ambiance
      'image_url': 'https://images.unsplash.com/photo-1527061011665-3652c757a4d4?w=400&q=80&fit=crop',
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

/// Per-product image overrides — checked before the Supabase image_url.
/// Keys match the exact Supabase shop_products.name value.
///
/// Only products needing an override are listed here — correct Supabase images
/// fall through automatically to the isTrustedUrl check.
const _kShopProductImageOverrides = <String, String>{
  // ── SEEDS ────────────────────────────────────────────────────────────────
  'Heirloom Tomato Seed Collection':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/best-selling-tomatoes-collection-Comp.jpg?v=1756309253',
  'Salad Greens Mix':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/lettuce-salad-leaf-blend-mix-com-wm_1222x1222_3570a053-1fa4-4e2b-9828-fc381d6c3376.jpg?v=1764633742',
  'Herb Garden Starter Collection':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/Organic_Herb_Collection_8_Pack_Collage_Comp.jpg?v=1778194453',
  'Dragon Tongue Bean Seeds':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/dragons-tongue-beans-wm_700_1222x1222_2396e638-12b9-4e6a-8554-34123c4a7bef.jpg?v=1764633795',
  'Rainbow Carrot Seeds':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/Carrot-Seeds-Rainbow-Blend-Organic-comp.jpg?v=1762440662',

  // ── TOOLS ────────────────────────────────────────────────────────────────
  'DeWit Hand Weeder':
      'https://images.unsplash.com/photo-1665395131262-c2df665c2cbe?w=400&q=80&fit=crop',
  'Hori Hori Garden Knife':
      'https://images.unsplash.com/photo-1677941731347-0369249f7aa8?w=400&q=80&fit=crop',
  'Radius Garden Kneeler':
      'https://images.unsplash.com/photo-1665395131699-f904d110acf5?w=400&q=80&fit=crop',
  'Tomato Cage Set of 3':
      'https://images.unsplash.com/photo-1535222830855-fd60aca7e065?w=400&q=80&fit=crop',

  // ── SOIL & AMENDMENTS ────────────────────────────────────────────────────
  'Coco Coir Brick - 5 Pack':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/Collage_Minute_Soil_2_50be3d92-ca63-4cdf-bbed-d3cf8fca2acd.jpg?v=1776821374',
  'Perlite - 8 Quart Bag':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/perlite-wm_1_1222x1222_0ec1fbb2-971b-46cc-b9b1-c419857199a5.jpg?v=1764633919',
  'Worm Castings - 15 lb Bag':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/Worm-Castings-Comp.jpg?v=1762440335',
  'Espoma Tomato-Tone Fertilizer':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/1745345731_fertilizer_espoma_plant_tone_5_3_3_organic_4lb_bag_comp_ed1747a6-e555-4d09-835e-d961d8ffbac1.jpg?v=1762453402',
  'Espoma Herb and Vegetable Fertilizer':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/1740507920_fertilizer_espoma_garden_food_10_10_10_675lb_bag_wm_comp_1bbd3198-7fb7-45da-9b03-014f49de965b.jpg?v=1762453068',

  // ── POTS & CONTAINERS ────────────────────────────────────────────────────
  'Hanging Basket with Coconut Liner':
      'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
  'Self-Watering Planter Box':
      'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
  'Raised Garden Bed - 4x4 Cedar':
      'https://images.unsplash.com/photo-1535222830855-fd60aca7e065?w=400&q=80&fit=crop',

  // ── GROW LIGHTS ──────────────────────────────────────────────────────────
  'LED Grow Light Bar - Full Spectrum':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/Boost-MaxPro-Grow-Lights-Comp.jpg?v=1762450181',
  '4-Tier Grow Light Stand':
      'https://cdn.shopify.com/s/files/1/2016/2681/files/Boost-MaxPro-Grow-Lights-Comp.jpg?v=1762450181',
  'Seedling Heat Mat with Thermostat':
      'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=400&q=80&fit=crop',
  'Outlet Timer for Grow Lights':
      'https://images.unsplash.com/photo-1505253758473-96b7015fcd40?w=400&q=80&fit=crop',
};

// Reliable Unsplash fallback images per category.
// These are the same Unsplash photos used in the plant-library fallback map,
// so we know they load. Chosen to be thematically relevant to each category.
const _kShopCategoryFallbacks = <String, String>{
  'Seeds':
      'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop',
  // Garden hand tools / gloves
  'Tools':
      'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400&q=80&fit=crop',
  // Rich dark soil / earth
  'Soil & Amendments':
      'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=400&q=80&fit=crop',
  // Lush green herbs / plants (fertilizer result)
  'Fertilizers':
      'https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=400&q=80&fit=crop',
  // Terracotta plant pots
  'Pots & Containers':
      'https://images.unsplash.com/photo-1459156212016-c812468e2115?w=400&q=80&fit=crop',
  // Classic garden watering can
  'Watering':
      'https://images.unsplash.com/photo-1545558014-8692077e9b5c?w=400&q=80&fit=crop',
  // Bean vines climbing a support
  'Trellises & Supports':
      'https://images.unsplash.com/photo-1590165482129-1b8b27698780?w=400&q=80&fit=crop',
  // Marigolds — natural pest deterrent companion plant
  'Pest Control':
      'https://images.unsplash.com/photo-1548263594-a71ea65a8598?w=400&q=80&fit=crop',
  // LED grow lights over seedling trays
  'Grow Lights':
      'https://images.unsplash.com/photo-1505253758473-96b7015fcd40?w=400&q=80&fit=crop',
  // Solar outdoor garden lights
  'Outdoor Lighting':
      'https://images.unsplash.com/photo-1611095973763-414019e72400?w=400&q=80&fit=crop',
};

Widget _shopProductImage(BuildContext context, Map<String, dynamic> product) {
  final rawUrl = (product['image_url'] ?? '') as String;
  final productName = (product['name'] ?? 'garden product') as String;
  final category = (product['category'] ?? '') as String;

  // Unsplash fallback for this category (guaranteed to load)
  final categoryFallback = _kShopCategoryFallbacks[category]
      ?? 'https://images.unsplash.com/photo-1592921870789-04563d55041c?w=400&q=80&fit=crop';

  // Map categories to emojis for the last-resort placeholder
  final emoji = category == 'Seeds' ? '🌱'
      : category == 'Tools' ? '🔧'
      : category == 'Soil & Amendments' ? '🪱'
      : category == 'Pots & Containers' ? '🪴'
      : category == 'Pest Control' ? '🐛'
      : category == 'Grow Lights' ? '💡'
      : category == 'Outdoor Lighting' ? '🔆'
      : '🛍️';

  Widget emojiPlaceholder() => Container(
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

  // 1. Check hardcoded per-product overrides first — guaranteed correct image.
  final overrideUrl = _kShopProductImageOverrides[productName];
  if (overrideUrl != null && overrideUrl.isNotEmpty) {
    return CachedNetworkImage(
      imageUrl: overrideUrl,
      height: 120.0,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => emojiPlaceholder(),
      errorWidget: (context, url, error) => CachedNetworkImage(
        imageUrl: categoryFallback,
        height: 120.0,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => emojiPlaceholder(),
        errorWidget: (context, url, error) => emojiPlaceholder(),
      ),
    );
  }

  // 2. Only trust URLs from known-good image hosts.
  // Supabase shop_products rows can have bad third-party URLs (AirPods,
  // unrelated stock photos) that load successfully but show the wrong thing.
  // Restricting to Unsplash or Shopify CDN ensures relevant product images.
  final bool isTrustedUrl = rawUrl.isNotEmpty &&
      (rawUrl.contains('images.unsplash.com') ||
       rawUrl.contains('cdn.shopify.com'));

  if (isTrustedUrl) {
    return CachedNetworkImage(
      imageUrl: rawUrl,
      height: 120.0,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => emojiPlaceholder(),
      errorWidget: (context, url, error) => CachedNetworkImage(
        imageUrl: categoryFallback,
        height: 120.0,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => emojiPlaceholder(),
        errorWidget: (context, url, error) => emojiPlaceholder(),
      ),
    );
  } else {
    // Untrusted or empty URL — go straight to the category fallback
    return CachedNetworkImage(
      imageUrl: categoryFallback,
      height: 120.0,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => emojiPlaceholder(),
      errorWidget: (context, url, error) => emojiPlaceholder(),
    );
  }
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
