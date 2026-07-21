import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// Frost-date-aware Seed Starting Guide.
/// The user sets their last frost date once; the page then shows
/// a full planting schedule for common vegetables.
class SeedStartingGuideWidget extends StatefulWidget {
  const SeedStartingGuideWidget({super.key});

  static const String routeName = 'SeedStartingGuide';
  static const String routePath = '/seedStartingGuide';

  @override
  State<SeedStartingGuideWidget> createState() =>
      _SeedStartingGuideWidgetState();
}

class _SeedStartingGuideWidgetState extends State<SeedStartingGuideWidget> {
  static const _prefKey = 'last_frost_date';

  DateTime? _lastFrost;
  String _filterCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadFrost();
  }

  Future<void> _loadFrost() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_prefKey);
    if (s != null) {
      setState(() => _lastFrost = DateTime.tryParse(s));
    }
  }

  Future<void> _saveFrost(DateTime d) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, d.toIso8601String());
    setState(() => _lastFrost = d);
  }

  Future<void> _pickFrost() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastFrost ?? DateTime(now.year, 4, 15),
      firstDate: DateTime(now.year - 1, 1, 1),
      lastDate: DateTime(now.year + 1, 12, 31),
      helpText: 'Select your last spring frost date',
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF6F8F72),
            onSurface: FlutterFlowTheme.of(ctx).primaryText,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) await _saveFrost(picked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final categories = ['All', 'Vegetables', 'Herbs', 'Flowers', 'Fruit'];
    final plants = _lastFrost != null
        ? _plantSchedule(_lastFrost!, _filterCategory)
        : <_SeedEntry>[];

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────────
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
                        Text('Seed Starting Guide',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: theme.primaryText)),
                        Text('Personalized to your frost date',
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: theme.secondaryText)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ── Frost date card ───────────────────────────────────────────
            GestureDetector(
              onTap: _pickFrost,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F8F72),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text('❄️', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Last Frost Date',
                              style: GoogleFonts.poppins(
                                  color: Colors.white70, fontSize: 12)),
                          Text(
                            _lastFrost != null
                                ? _formatDate(_lastFrost!)
                                : 'Tap to set your frost date',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          if (_lastFrost != null)
                            Text(
                              _daysUntilFrost(_lastFrost!),
                              style: GoogleFonts.poppins(
                                  color: Colors.white70, fontSize: 12),
                            ),
                        ],
                      ),
                    ),
                    Icon(Icons.edit_calendar_rounded,
                        color: Colors.white70, size: 20),
                  ],
                ),
              ),
            ),

            if (_lastFrost == null)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🗓️',
                            style: TextStyle(fontSize: 60)),
                        const SizedBox(height: 16),
                        Text('Set your last frost date',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: theme.primaryText)),
                        const SizedBox(height: 8),
                        Text(
                          'Your last spring frost date is used to calculate '
                          'exactly when to start seeds indoors and when to '
                          'transplant outdoors.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: theme.secondaryText),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _pickFrost,
                          icon: const Icon(Icons.calendar_today_rounded),
                          label: Text('Set Frost Date',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6F8F72),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else ...[
              // ── Category filter ─────────────────────────────────────────
              SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 6),
                  itemCount: categories.length,
                  itemBuilder: (_, i) {
                    final cat = categories[i];
                    final selected = _filterCategory == cat;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _filterCategory = cat),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF6F8F72)
                              : theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF6F8F72)
                                : theme.alternate,
                          ),
                        ),
                        child: Text(cat,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : theme.primaryText)),
                      ),
                    );
                  },
                ),
              ),

              // ── Legend ──────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                child: Row(
                  children: [
                    _legendDot(Colors.green.shade400),
                    Text(' Start now  ',
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: theme.secondaryText)),
                    _legendDot(Colors.orange.shade400),
                    Text(' Coming up  ',
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: theme.secondaryText)),
                    _legendDot(Colors.grey.shade400),
                    Text(' Past/Outdoors',
                        style: GoogleFonts.poppins(
                            fontSize: 11, color: theme.secondaryText)),
                  ],
                ),
              ),

              // ── Schedule list ────────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.fromLTRB(20, 0, 20, 32),
                  itemCount: plants.length,
                  itemBuilder: (_, i) =>
                      _SeedEntryTile(entry: plants[i], frost: _lastFrost!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _legendDot(Color color) => Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  String _formatDate(DateTime d) =>
      '${_monthName(d.month)} ${d.day}, ${d.year}';

  String _daysUntilFrost(DateTime frost) {
    final diff = frost.difference(DateTime.now()).inDays;
    if (diff < 0) return '${-diff} days after last frost';
    if (diff == 0) return 'Last frost is today!';
    return '$diff days until last frost';
  }

  String _monthName(int m) => const [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ][m - 1];
}

// ── Data model ─────────────────────────────────────────────────────────────

class _SeedEntry {
  final String name;
  final String category;
  final String emoji;
  final int startIndoorsWeeks;  // weeks BEFORE frost (negative = after)
  final int transplantWeeks;    // weeks relative to frost
  final String notes;

  const _SeedEntry({
    required this.name,
    required this.category,
    required this.emoji,
    required this.startIndoorsWeeks,
    required this.transplantWeeks,
    required this.notes,
  });

  DateTime startIndoorsDate(DateTime frost) =>
      frost.subtract(Duration(days: startIndoorsWeeks * 7));

  DateTime transplantDate(DateTime frost) =>
      frost.add(Duration(days: transplantWeeks * 7));
}

// ── Schedule tile ──────────────────────────────────────────────────────────

class _SeedEntryTile extends StatelessWidget {
  final _SeedEntry entry;
  final DateTime frost;
  const _SeedEntryTile({required this.entry, required this.frost});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final now = DateTime.now();
    final startDate = entry.startIndoorsDate(frost);
    final transplantDate = entry.transplantDate(frost);

    // Status logic
    final isStartWindow =
        now.isAfter(startDate.subtract(const Duration(days: 7))) &&
            now.isBefore(transplantDate);
    final isPast = now.isAfter(transplantDate.add(const Duration(days: 7)));
    final isUpcoming = !isStartWindow && !isPast &&
        now.isBefore(startDate.subtract(const Duration(days: 7)));

    Color statusColor = isPast
        ? Colors.grey.shade300
        : isStartWindow
            ? Colors.green.shade100
            : Colors.orange.shade50;
    Color dotColor = isPast
        ? Colors.grey.shade400
        : isStartWindow
            ? Colors.green.shade500
            : Colors.orange.shade400;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: dotColor.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.emoji,
                style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(entry.name,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: theme.primaryText)),
                      const Spacer(),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: dotColor, shape: BoxShape.circle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _dateRow(
                    context,
                    Icons.home_rounded,
                    'Start indoors:',
                    startDate,
                    now,
                  ),
                  const SizedBox(height: 3),
                  _dateRow(
                    context,
                    Icons.wb_sunny_rounded,
                    'Transplant outside:',
                    transplantDate,
                    now,
                  ),
                  if (entry.notes.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(entry.notes,
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: theme.secondaryText,
                            fontStyle: FontStyle.italic)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateRow(BuildContext context, IconData icon, String label,
      DateTime date, DateTime now) {
    final theme = FlutterFlowTheme.of(context);
    final isPast = now.isAfter(date);
    final diff = date.difference(now).inDays;
    String relative;
    if (isPast) {
      relative = '${now.difference(date).inDays}d ago';
    } else if (diff == 0) {
      relative = 'Today!';
    } else if (diff < 7) {
      relative = 'in $diff days';
    } else {
      relative = 'in ${(diff / 7).round()} wks';
    }

    return Row(
      children: [
        Icon(icon, size: 13, color: theme.secondaryText),
        const SizedBox(width: 4),
        Text('$label ',
            style: GoogleFonts.poppins(
                fontSize: 12, color: theme.secondaryText)),
        Text(
          '${_month(date.month)} ${date.day}',
          style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w600, color: theme.primaryText),
        ),
        const SizedBox(width: 6),
        Text('($relative)',
            style: GoogleFonts.poppins(
                fontSize: 11, color: theme.secondaryText)),
      ],
    );
  }

  String _month(int m) => const [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ][m - 1];
}

// ── Plant schedule data ────────────────────────────────────────────────────
// startIndoorsWeeks = weeks BEFORE last frost to start indoors
// transplantWeeks   = weeks AFTER last frost to move outside (0 = at frost)

List<_SeedEntry> _plantSchedule(DateTime frost, String filterCat) {
  final all = <_SeedEntry>[
    // ── VEGETABLES ──────────────────────────────────────────────────────────
    const _SeedEntry(name: 'Tomato', category: 'Vegetables', emoji: '🍅',
        startIndoorsWeeks: 8, transplantWeeks: 2,
        notes: 'Needs warmth to germinate. Harden off before transplanting.'),
    const _SeedEntry(name: 'Pepper', category: 'Vegetables', emoji: '🌶️',
        startIndoorsWeeks: 10, transplantWeeks: 2,
        notes: 'Slow to germinate — start early! Needs soil temps above 70°F.'),
    const _SeedEntry(name: 'Eggplant', category: 'Vegetables', emoji: '🍆',
        startIndoorsWeeks: 8, transplantWeeks: 2,
        notes: 'Similar to peppers — needs heat and long growing season.'),
    const _SeedEntry(name: 'Broccoli', category: 'Vegetables', emoji: '🥦',
        startIndoorsWeeks: 6, transplantWeeks: -2,
        notes: 'Tolerates light frost. Transplant 2 weeks BEFORE last frost.'),
    const _SeedEntry(name: 'Cabbage', category: 'Vegetables', emoji: '🥬',
        startIndoorsWeeks: 6, transplantWeeks: -3,
        notes: 'Hardy — can go out 3 weeks before last frost.'),
    const _SeedEntry(name: 'Cauliflower', category: 'Vegetables', emoji: '🥦',
        startIndoorsWeeks: 6, transplantWeeks: -2,
        notes: 'Start early, protect from hard freezes after transplanting.'),
    const _SeedEntry(name: 'Lettuce', category: 'Vegetables', emoji: '🥗',
        startIndoorsWeeks: 4, transplantWeeks: -2,
        notes: 'Frost tolerant. Direct sow as soon as ground can be worked.'),
    const _SeedEntry(name: 'Kale', category: 'Vegetables', emoji: '🥬',
        startIndoorsWeeks: 5, transplantWeeks: -3,
        notes: 'Very hardy — frost improves flavor. One of the earliest to plant.'),
    const _SeedEntry(name: 'Spinach', category: 'Vegetables', emoji: '🌿',
        startIndoorsWeeks: 4, transplantWeeks: -4,
        notes: 'Direct sow as early as 4 weeks before last frost.'),
    const _SeedEntry(name: 'Celery', category: 'Vegetables', emoji: '🥬',
        startIndoorsWeeks: 10, transplantWeeks: 2,
        notes: 'Very slow grower — one of the earliest to start indoors.'),
    const _SeedEntry(name: 'Cucumber', category: 'Vegetables', emoji: '🥒',
        startIndoorsWeeks: 3, transplantWeeks: 2,
        notes: 'Don\'t start too early — they grow fast and hate cold.'),
    const _SeedEntry(name: 'Squash / Zucchini', category: 'Vegetables', emoji: '🫑',
        startIndoorsWeeks: 3, transplantWeeks: 2,
        notes: 'Fast grower. Or direct sow after last frost.'),
    const _SeedEntry(name: 'Pumpkin', category: 'Vegetables', emoji: '🎃',
        startIndoorsWeeks: 3, transplantWeeks: 2,
        notes: 'Needs a long season — time your transplant date accordingly.'),
    const _SeedEntry(name: 'Melon', category: 'Vegetables', emoji: '🍈',
        startIndoorsWeeks: 3, transplantWeeks: 3,
        notes: 'Needs warm soil. Use black plastic mulch to warm the soil first.'),
    const _SeedEntry(name: 'Corn', category: 'Vegetables', emoji: '🌽',
        startIndoorsWeeks: 0, transplantWeeks: 2,
        notes: 'Direct sow after last frost. Dislikes transplanting.'),
    const _SeedEntry(name: 'Green Bean', category: 'Vegetables', emoji: '🫘',
        startIndoorsWeeks: 0, transplantWeeks: 2,
        notes: 'Direct sow only — dislikes transplanting.'),
    const _SeedEntry(name: 'Peas', category: 'Vegetables', emoji: '🫛',
        startIndoorsWeeks: 0, transplantWeeks: -6,
        notes: 'Direct sow as early as soil can be worked — 6 wks before frost.'),
    const _SeedEntry(name: 'Onion', category: 'Vegetables', emoji: '🧅',
        startIndoorsWeeks: 10, transplantWeeks: -4,
        notes: 'One of the earliest transplants. Very frost tolerant.'),
    const _SeedEntry(name: 'Leek', category: 'Vegetables', emoji: '🌿',
        startIndoorsWeeks: 10, transplantWeeks: -2,
        notes: 'Start very early indoors — long growing season needed.'),
    const _SeedEntry(name: 'Swiss Chard', category: 'Vegetables', emoji: '🌿',
        startIndoorsWeeks: 4, transplantWeeks: -2,
        notes: 'Hardy and productive. Tolerates light frosts.'),
    const _SeedEntry(name: 'Beet', category: 'Vegetables', emoji: '❤️',
        startIndoorsWeeks: 0, transplantWeeks: -3,
        notes: 'Direct sow 3 weeks before last frost. Dislikes transplanting.'),
    const _SeedEntry(name: 'Carrot', category: 'Vegetables', emoji: '🥕',
        startIndoorsWeeks: 0, transplantWeeks: -3,
        notes: 'Direct sow only. Thin to 3" apart for best roots.'),
    const _SeedEntry(name: 'Radish', category: 'Vegetables', emoji: '🌸',
        startIndoorsWeeks: 0, transplantWeeks: -4,
        notes: 'Direct sow. Matures in 25–30 days — plant in successions.'),

    // ── HERBS ──────────────────────────────────────────────────────────────
    const _SeedEntry(name: 'Basil', category: 'Herbs', emoji: '🌿',
        startIndoorsWeeks: 6, transplantWeeks: 2,
        notes: 'Very frost-tender. Don\'t rush outdoor planting.'),
    const _SeedEntry(name: 'Parsley', category: 'Herbs', emoji: '🌿',
        startIndoorsWeeks: 8, transplantWeeks: 0,
        notes: 'Slow to germinate (3 weeks). Soak seeds overnight to speed up.'),
    const _SeedEntry(name: 'Cilantro', category: 'Herbs', emoji: '🌿',
        startIndoorsWeeks: 0, transplantWeeks: -2,
        notes: 'Direct sow — dislikes transplanting. Plant in cool weather.'),
    const _SeedEntry(name: 'Dill', category: 'Herbs', emoji: '🌿',
        startIndoorsWeeks: 0, transplantWeeks: 0,
        notes: 'Direct sow at last frost date or slightly after.'),
    const _SeedEntry(name: 'Rosemary', category: 'Herbs', emoji: '🌿',
        startIndoorsWeeks: 12, transplantWeeks: 2,
        notes: 'Very slow from seed. Consider buying transplants instead.'),
    const _SeedEntry(name: 'Lavender', category: 'Herbs', emoji: '💜',
        startIndoorsWeeks: 8, transplantWeeks: 0,
        notes: 'Slow to germinate. Stratify seeds in fridge for 2 weeks first.'),
    const _SeedEntry(name: 'Chamomile', category: 'Herbs', emoji: '🌼',
        startIndoorsWeeks: 4, transplantWeeks: -2,
        notes: 'Cold-stratify or direct sow. Frost tolerant seedlings.'),
    const _SeedEntry(name: 'Mint', category: 'Herbs', emoji: '🌿',
        startIndoorsWeeks: 8, transplantWeeks: 0,
        notes: 'Slow from seed. Better to propagate from cuttings or buy starts.'),

    // ── FLOWERS ────────────────────────────────────────────────────────────
    const _SeedEntry(name: 'Marigold', category: 'Flowers', emoji: '🌼',
        startIndoorsWeeks: 4, transplantWeeks: 1,
        notes: 'Fast growing. Don\'t start too early or they\'ll get leggy.'),
    const _SeedEntry(name: 'Nasturtium', category: 'Flowers', emoji: '🌸',
        startIndoorsWeeks: 0, transplantWeeks: 1,
        notes: 'Prefers direct sow — dislikes root disturbance.'),
    const _SeedEntry(name: 'Sunflower', category: 'Flowers', emoji: '🌻',
        startIndoorsWeeks: 2, transplantWeeks: 1,
        notes: 'Or direct sow after last frost. Very easy to grow.'),
    const _SeedEntry(name: 'Zinnia', category: 'Flowers', emoji: '🌺',
        startIndoorsWeeks: 4, transplantWeeks: 2,
        notes: 'Needs warm soil. Don\'t rush — cold stunts them.'),
    const _SeedEntry(name: 'Cosmos', category: 'Flowers', emoji: '🌸',
        startIndoorsWeeks: 4, transplantWeeks: 1,
        notes: 'Fast bloomer. Can also direct sow after last frost.'),
    const _SeedEntry(name: 'Pansy', category: 'Flowers', emoji: '💜',
        startIndoorsWeeks: 10, transplantWeeks: -4,
        notes: 'Very hardy — one of the earliest flowers you can plant out.'),

    // ── FRUIT ──────────────────────────────────────────────────────────────
    const _SeedEntry(name: 'Strawberry', category: 'Fruit', emoji: '🍓',
        startIndoorsWeeks: 12, transplantWeeks: -2,
        notes: 'Start very early. Or buy crowns for faster results.'),
    const _SeedEntry(name: 'Watermelon', category: 'Fruit', emoji: '🍉',
        startIndoorsWeeks: 4, transplantWeeks: 2,
        notes: 'Needs long warm season. Use black plastic mulch to warm soil.'),
  ];

  if (filterCat == 'All') return all;
  return all.where((e) => e.category == filterCat).toList();
}
