import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// Indoor Growing hub — year-round growing tips, best plants,
/// lighting guide, and curated affiliate products.
class IndoorGrowingWidget extends StatefulWidget {
  const IndoorGrowingWidget({super.key});

  static const String routeName = 'IndoorGrowing';
  static const String routePath = '/indoorGrowing';

  @override
  State<IndoorGrowingWidget> createState() => _IndoorGrowingWidgetState();
}

class _IndoorGrowingWidgetState extends State<IndoorGrowingWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  final List<String> _tabs = ['Plants', 'Lighting', 'Products'];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: theme.primaryText, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Indoor Growing',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: theme.primaryText)),
                        Text('Grow year-round, indoors',
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: theme.secondaryText)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Hero card ───────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF6F8F72),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('🌿 No outdoor space?',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        const SizedBox(height: 6),
                        Text(
                          'Fresh herbs, veggies, and microgreens — '
                          'all from your windowsill or a simple grow light setup.',
                          style: GoogleFonts.poppins(
                              color: Colors.white70, fontSize: 12, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text('🏡', style: TextStyle(fontSize: 40)),
                ],
              ),
            ),

            // ── Tabs ────────────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                controller: _tab,
                labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 13),
                unselectedLabelStyle:
                    GoogleFonts.poppins(fontSize: 13),
                labelColor: Colors.white,
                unselectedLabelColor: theme.secondaryText,
                indicator: BoxDecoration(
                  color: const Color(0xFF6F8F72),
                  borderRadius: BorderRadius.circular(12),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                tabs: _tabs.map((t) => Tab(text: t)).toList(),
              ),
            ),

            // ── Tab content ─────────────────────────────────────────────
            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [
                  _PlantsTab(launch: _launch),
                  _LightingTab(launch: _launch),
                  _ProductsTab(launch: _launch),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Plants Tab ──────────────────────────────────────────────────────────────

class _PlantsTab extends StatelessWidget {
  final Future<void> Function(String) launch;
  const _PlantsTab({required this.launch});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    const plants = [
      _IndoorPlant('Basil', '🌿', 'Needs 6+ hours of sun or a grow light. Pinch flowers to extend harvest.', 'High', 'Easy'),
      _IndoorPlant('Mint', '🌿', 'Grows aggressively — keep in its own pot. Loves moisture and indirect light.', 'Medium', 'Easy'),
      _IndoorPlant('Chives', '🌿', 'One of the easiest herbs indoors. Snip and they regrow in days.', 'Medium', 'Easy'),
      _IndoorPlant('Parsley', '🌿', 'Slow to start but productive. Needs bright light — south-facing window ideal.', 'Medium', 'Moderate'),
      _IndoorPlant('Cherry Tomatoes', '🍅', 'Compact varieties like Tiny Tim or Tumbling Tom work well indoors with grow lights.', 'High', 'Moderate'),
      _IndoorPlant('Lettuce', '🥗', 'Cut-and-come-again varieties are perfect for windowsill containers. Harvest outer leaves.', 'Medium', 'Easy'),
      _IndoorPlant('Spinach', '🌿', 'Cool-season crop — does well in lower light. Great for a kitchen windowsill.', 'Low', 'Easy'),
      _IndoorPlant('Green Onions', '🧅', 'Regrow from store-bought roots in a glass of water. No soil needed.', 'Low', 'Easy'),
      _IndoorPlant('Microgreens', '🌱', 'Ready in 7–14 days. No grow light needed — just a bright windowsill.', 'Medium', 'Easy'),
      _IndoorPlant('Strawberries', '🍓', 'Compact alpine varieties thrive in hanging baskets indoors.', 'High', 'Moderate'),
      _IndoorPlant('Peppers', '🌶️', 'Compact ornamental peppers fruit easily indoors with a grow light.', 'High', 'Moderate'),
      _IndoorPlant('Aloe Vera', '🪴', 'Nearly indestructible. Needs bright light and infrequent watering.', 'Low', 'Easy'),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Text('Best plants for indoors',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.primaryText)),
        const SizedBox(height: 4),
        Text('Sorted by ease — start with the Easy ones.',
            style: GoogleFonts.poppins(fontSize: 12, color: theme.secondaryText)),
        const SizedBox(height: 12),
        ...plants.map((p) => _PlantCard(plant: p)),
      ],
    );
  }
}

class _IndoorPlant {
  final String name;
  final String emoji;
  final String tip;
  final String light;
  final String difficulty;
  const _IndoorPlant(this.name, this.emoji, this.tip, this.light, this.difficulty);
}

class _PlantCard extends StatelessWidget {
  final _IndoorPlant plant;
  const _PlantCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final diffColor = plant.difficulty == 'Easy'
        ? Colors.green.shade600
        : Colors.orange.shade700;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.alternate),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(plant.emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(plant.name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: theme.primaryText)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: diffColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(plant.difficulty,
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: diffColor)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(children: [
                  Icon(Icons.wb_sunny_outlined,
                      size: 13, color: theme.secondaryText),
                  const SizedBox(width: 4),
                  Text('${plant.light} light',
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: theme.secondaryText)),
                ]),
                const SizedBox(height: 6),
                Text(plant.tip,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: theme.secondaryText,
                        height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Lighting Tab ─────────────────────────────────────────────────────────────

class _LightingTab extends StatelessWidget {
  final Future<void> Function(String) launch;
  const _LightingTab({required this.launch});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    const sections = [
      _LightSection(
        '☀️',
        'South-facing windowsill',
        '4–6+ hours of direct sun per day. Ideal for herbs (basil, parsley, chives) and lettuce.',
        null,
      ),
      _LightSection(
        '💡',
        'Full-spectrum LED grow lights',
        'Best all-around option. 12–16 hours on, 8 hours off. Position 6–12 inches above plants.',
        'https://www.amazon.com/s?k=full+spectrum+LED+grow+light&tag=sprouttogether-20',
      ),
      _LightSection(
        '🕯️',
        'T5 fluorescent tubes',
        'Budget-friendly for seedlings and herbs. Good for starting seeds before transplanting.',
        'https://www.amazon.com/s?k=T5+grow+light+fluorescent&tag=sprouttogether-20',
      ),
      _LightSection(
        '🔴',
        'Red/blue LED panels',
        'Efficient for flowering and fruiting. Red (650nm) + blue (450nm) spectrum drives growth.',
        'https://www.amazon.com/s?k=red+blue+LED+grow+panel&tag=sprouttogether-20',
      ),
    ];

    const tips = [
      ('⏰', 'Use a timer', 'Set lights on a 14-hour cycle. Consistency matters more than intensity.'),
      ('🌡️', 'Watch temperature', 'Lights add heat. Keep leaves from touching bulbs — 2 inches minimum clearance.'),
      ('💧', 'Adjust watering', 'Grow lights dry soil faster. Check moisture daily under artificial lighting.'),
      ('🪴', 'Rotate pots', 'Turn pots a quarter turn every few days for even growth under window light.'),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Text('Light options',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.primaryText)),
        const SizedBox(height: 12),
        ...sections.map((s) => _LightCard(section: s, launch: launch)),
        const SizedBox(height: 16),
        Text('Pro tips',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.primaryText)),
        const SizedBox(height: 12),
        ...tips.map((t) => _TipCard(emoji: t.$1, title: t.$2, body: t.$3)),
      ],
    );
  }
}

class _LightSection {
  final String emoji;
  final String title;
  final String body;
  final String? shopUrl;
  const _LightSection(this.emoji, this.title, this.body, this.shopUrl);
}

class _LightCard extends StatelessWidget {
  final _LightSection section;
  final Future<void> Function(String) launch;
  const _LightCard({required this.section, required this.launch});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(section.emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(section.title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: theme.primaryText)),
            ),
          ]),
          const SizedBox(height: 8),
          Text(section.body,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: theme.secondaryText, height: 1.5)),
          if (section.shopUrl != null) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => launch(section.shopUrl!),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F8F72),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_bag_outlined,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text('Shop on Amazon',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String body;
  const _TipCard({required this.emoji, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0x0D6F8F72),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x336F8F72)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: theme.primaryText)),
                const SizedBox(height: 2),
                Text(body,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: theme.secondaryText,
                        height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Products Tab ──────────────────────────────────────────────────────────────

class _ProductsTab extends StatelessWidget {
  final Future<void> Function(String) launch;
  const _ProductsTab({required this.launch});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    const clickAndGrowBase = 'https://www.anrdoezrs.net/click-8012865-4297609';
    const amazonTag = 'sprouttogether-20';

    final products = [
      _IndoorProduct(
        name: 'Click & Grow Smart Garden 3',
        emoji: '🪴',
        description: 'Self-watering smart garden. Grows herbs in your kitchen automatically — just add water.',
        price: '\$79.95',
        badge: 'Best for beginners',
        url: '$clickAndGrowBase?url=https://www.clickandgrow.com/products/smart-garden-3',
        isAffiliate: true,
      ),
      _IndoorProduct(
        name: 'Click & Grow Smart Garden 9',
        emoji: '🌿',
        description: 'Grow 9 plants at once. Perfect for herbs, lettuce, and tomatoes year-round.',
        price: '\$199.95',
        badge: 'Most popular',
        url: '$clickAndGrowBase?url=https://www.clickandgrow.com/products/smart-garden-9',
        isAffiliate: true,
      ),
      _IndoorProduct(
        name: 'Aerogarden Harvest Elite',
        emoji: '💧',
        description: 'Hydroponic herb garden with built-in full-spectrum LED. Grows 6 plants in water.',
        price: '\$109.95',
        badge: null,
        url: 'https://www.amazon.com/s?k=aerogarden+harvest+elite&tag=$amazonTag',
        isAffiliate: false,
      ),
      _IndoorProduct(
        name: 'Barrina LED Grow Light (4-pack)',
        emoji: '💡',
        description: 'T5-style full-spectrum LED strips. Linkable design for shelving setups.',
        price: '\$35.99',
        badge: 'Best value',
        url: 'https://www.amazon.com/s?k=barrina+LED+grow+light&tag=$amazonTag',
        isAffiliate: false,
      ),
      _IndoorProduct(
        name: 'Fabric Grow Bags (5-gallon)',
        emoji: '🛍️',
        description: 'Breathable fabric pots prevent root circling and improve drainage. Pack of 10.',
        price: '\$19.99',
        badge: null,
        url: 'https://www.amazon.com/s?k=fabric+grow+bags+5+gallon&tag=$amazonTag',
        isAffiliate: false,
      ),
      _IndoorProduct(
        name: 'Indoor Potting Mix',
        emoji: '🪨',
        description: 'Lightweight, well-draining mix for container gardening. Works for herbs and veggies.',
        price: '\$14.99',
        badge: null,
        url: 'https://www.amazon.com/s?k=indoor+potting+mix+herbs&tag=$amazonTag',
        isAffiliate: false,
      ),
      _IndoorProduct(
        name: 'Liquid Kelp Fertilizer',
        emoji: '🌊',
        description: 'OMRI-listed organic fertilizer for indoor edibles. Great for herbs and microgreens.',
        price: '\$17.99',
        badge: null,
        url: 'https://www.amazon.com/s?k=liquid+kelp+fertilizer+organic&tag=$amazonTag',
        isAffiliate: false,
      ),
      _IndoorProduct(
        name: 'Microgreens Growing Kit',
        emoji: '🌱',
        description: 'Includes seeds, trays, and growing medium. Harvest in 7–14 days.',
        price: '\$24.99',
        badge: 'Quick results',
        url: 'https://www.amazon.com/s?k=microgreens+growing+kit&tag=$amazonTag',
        isAffiliate: false,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Text('Curated indoor growing products',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: theme.primaryText)),
        const SizedBox(height: 4),
        Text('Affiliate links help support SproutTogether.',
            style: GoogleFonts.poppins(fontSize: 11, color: theme.secondaryText)),
        const SizedBox(height: 12),
        ...products.map((p) => _ProductCard(product: p, launch: launch)),
      ],
    );
  }
}

class _IndoorProduct {
  final String name;
  final String emoji;
  final String description;
  final String price;
  final String? badge;
  final String url;
  final bool isAffiliate;
  const _IndoorProduct({
    required this.name,
    required this.emoji,
    required this.description,
    required this.price,
    required this.badge,
    required this.url,
    required this.isAffiliate,
  });
}

class _ProductCard extends StatelessWidget {
  final _IndoorProduct product;
  final Future<void> Function(String) launch;
  const _ProductCard({required this.product, required this.launch});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: () => launch(product.url),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.alternate),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.badge != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0x1A6F8F72),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(product.badge!,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6F8F72))),
                    ),
                    const SizedBox(height: 4),
                  ],
                  Text(product.name,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: theme.primaryText)),
                  const SizedBox(height: 4),
                  Text(product.description,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: theme.secondaryText,
                          height: 1.4)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(product.price,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: const Color(0xFF6F8F72))),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6F8F72),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          product.isAffiliate ? 'Shop Click & Grow' : 'Shop Amazon',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
