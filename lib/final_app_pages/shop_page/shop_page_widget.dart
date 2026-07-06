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
    'Pots & Containers',
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
  ];

  // ── Curated products (hardcoded) ─────────────────────────────────────────
  // These show in the grid alongside any DB products.
  // Replace affiliate_url values with your tracked links.
  static const List<Map<String, dynamic>> _curatedProducts = [
    // True Leaf Market
    {
      'name': 'Organic Tomato Seed Collection',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$12–$18',
      'is_featured': true,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/tomato-seeds',
      'image_url': '',
    },
    {
      'name': 'Microgreens Starter Kit',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$19.99',
      'is_featured': false,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/microgreens-seeds',
      'image_url': '',
    },
    {
      'name': 'Heirloom Vegetable Seed Vault',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$24.99',
      'is_featured': false,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/heirloom-seeds',
      'image_url': '',
    },
    {
      'name': 'Organic Herb Seed Collection',
      'category': 'Seeds',
      'store_name': 'True Leaf Market',
      'price_estimate': r'$14.99',
      'is_featured': false,
      'affiliate_url': 'https://www.trueleafmarket.com/collections/herb-seeds',
      'image_url': '',
    },
    // Gardener's Supply Co
    {
      'name': 'Elevated Cedar Raised Bed (4×8 ft)',
      'category': 'Pots & Containers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$129–$179',
      'is_featured': true,
      'affiliate_url': 'https://www.gardeners.com/category/raised-garden-beds',
      'image_url': '',
    },
    {
      'name': 'Premium Potting Mix (2 cu ft)',
      'category': 'Soil & Amendments',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$19.99',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/soil-conditioners',
      'image_url': '',
    },
    {
      'name': 'CobraHead Long-Handle Weeder',
      'category': 'Tools',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$39.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/garden-tools',
      'image_url': '',
    },
    {
      'name': 'Self-Watering Planter (12 in)',
      'category': 'Pots & Containers',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$34.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/planters',
      'image_url': '',
    },
    {
      'name': 'Worm Castings (20 lbs)',
      'category': 'Soil & Amendments',
      'store_name': "Gardener's Supply Co",
      'price_estimate': r'$24.95',
      'is_featured': false,
      'affiliate_url': 'https://www.gardeners.com/category/fertilizers',
      'image_url': '',
    },
    // Burpee — seeds only
    {
      'name': 'Burpee Big Boy Tomato Seeds',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$4.99',
      'is_featured': true,
      'affiliate_url': 'https://www.burpee.com/vegetables/tomatoes/',
      'image_url': '',
    },
    {
      'name': 'Burpee Patio Garden Pepper Seed Mix',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$5.99',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/vegetables/peppers/',
      'image_url': '',
    },
    {
      'name': 'Burpee Organic Salad Green Blend',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$6.49',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/vegetables/lettuce/',
      'image_url': '',
    },
    {
      'name': 'Burpee Cucumber Seed Variety Pack',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$5.49',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/vegetables/cucumbers/',
      'image_url': '',
    },
    {
      'name': 'Burpee Herb Garden Seed Collection',
      'category': 'Seeds',
      'store_name': 'Burpee',
      'price_estimate': r'$9.99',
      'is_featured': false,
      'affiliate_url': 'https://www.burpee.com/herbs/',
      'image_url': '',
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
