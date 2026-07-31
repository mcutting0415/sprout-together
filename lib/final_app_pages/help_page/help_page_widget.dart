import '/final_app_pages/final_header/final_header_widget.dart';
import '/final_app_pages/common_questions_page/common_questions_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'help_page_model.dart';
export 'help_page_model.dart';

class HelpPageWidget extends StatefulWidget {
  const HelpPageWidget({super.key});

  static String routeName = 'HelpPage';
  static String routePath = '/helpPage';

  @override
  State<HelpPageWidget> createState() => _HelpPageWidgetState();
}

class _HelpPageWidgetState extends State<HelpPageWidget> {
  late HelpPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<int> _expanded = {};

  static const List<Map<String, String>> _quickFaqs = [
    {
      'q': 'How do I create my first garden?',
      'a': 'Tap "My Planner" from the home menu, then tap "Create Garden." Give it a name, choose a type (raised bed, container, or in-ground), set the size, and tap Create. Your garden opens in the Garden Builder where you can place plants.',
    },
    {
      'q': 'How do I add plants to my garden?',
      'a': 'In the Garden Builder, tap any empty plot cell. The Plant Library opens — search or browse to pick a plant. Tap a plant to place it in that spot. You can also use the "+ Add Plants" button from the Planner to browse and wishlist plants first.',
    },
    {
      'q': 'My subscription isn\'t working — what do I do?',
      'a': 'First, make sure you\'re signed in with the same Apple ID you purchased with. Then go to your Profile → Subscription and tap "Restore Purchases." If that doesn\'t work, contact us via email and we\'ll sort it out quickly.',
    },
    {
      'q': 'What is companion planting?',
      'a': 'Companion planting is placing certain plants near each other for mutual benefit — for example, basil near tomatoes repels pests and may improve flavor. Check the Companion Plants page (in the hamburger menu) to explore which plants work well together.',
    },
    {
      'q': 'How do I track watering and other garden tasks?',
      'a': 'Use the Growing Calendar — tap any date to add tasks like watering, fertilizing, or harvesting. You can also tap "+ Add Task" from the Planner overview. Tasks with due dates show as dots on the calendar.',
    },
    {
      'q': 'Can I use the app without a subscription?',
      'a': 'Yes! The Plant Library, Companion Guide, Garden Tips, Indoor Growing guide, Growing Calendar, and basic garden creation are all free. A SproutTogether Pro subscription unlocks advanced features like the Seed Inventory, Seed Starting Guide, unlimited gardens, and more.',
    },
  ];

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HelpPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: Column(
          children: [
            Container(height: 1.0, color: theme.alternate),
            wrapWithModel(
              model: _model.finalHeaderModel,
              updateCallback: () => safeSetState(() {}),
              child: const FinalHeaderWidget(pageTitle: 'Help Center'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Hero card ──────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: theme.primary,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'We\'re here to help 🌱',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                Text(
                                  'Browse common questions below or reach out — we typically respond within one business day.',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 12.5,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          const Text('💬', style: TextStyle(fontSize: 38.0)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // ── Contact options ────────────────────────────────────
                    _sectionLabel(context, 'Contact Us'),
                    const SizedBox(height: 10.0),
                    _ContactCard(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Live Chat',
                      subtitle: 'Chat with our team directly',
                      color: theme.primary,
                      onTap: () => _launch('https://tawk.to/sprouttogether'),
                    ),
                    const SizedBox(height: 10.0),
                    _ContactCard(
                      icon: Icons.email_outlined,
                      title: 'Email Support',
                      subtitle: 'sprouttogether.support@gmail.com',
                      color: const Color(0xFF4A90A4),
                      onTap: () => _launch(
                          'mailto:sprouttogether.support@gmail.com?subject=SproutTogether%20Support'),
                    ),
                    const SizedBox(height: 24.0),

                    // ── Quick FAQs ─────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _sectionLabel(context, 'Common Questions'),
                        GestureDetector(
                          onTap: () => context
                              .pushNamed(CommonQuestionsPageWidget.routeName),
                          child: Text(
                            'See all →',
                            style: GoogleFonts.poppins(
                              fontSize: 13.0,
                              color: theme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Material(
                      color: Colors.transparent,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: theme.alternate),
                        ),
                        child: Column(
                          children: List.generate(_quickFaqs.length, (i) {
                            final faq = _quickFaqs[i];
                            final isOpen = _expanded.contains(i);
                            final isLast = i == _quickFaqs.length - 1;
                            return Column(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.vertical(
                                    top: i == 0
                                        ? const Radius.circular(20.0)
                                        : Radius.zero,
                                    bottom: isLast && !isOpen
                                        ? const Radius.circular(20.0)
                                        : Radius.zero,
                                  ),
                                  onTap: () => setState(() {
                                    if (isOpen) {
                                      _expanded.remove(i);
                                    } else {
                                      _expanded.add(i);
                                    }
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 14.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            faq['q']!,
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.5,
                                              color: theme.primaryText,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Icon(
                                          isOpen
                                              ? Icons.keyboard_arrow_up_rounded
                                              : Icons.keyboard_arrow_down_rounded,
                                          color: theme.primary,
                                          size: 22.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isOpen)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 0.0, 16.0, 14.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Divider(
                                            height: 1.0,
                                            color: theme.alternate),
                                        const SizedBox(height: 10.0),
                                        Text(
                                          faq['a']!,
                                          style: GoogleFonts.poppins(
                                            fontSize: 13.0,
                                            color: theme.secondaryText,
                                            height: 1.6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (!isLast)
                                  Divider(
                                      height: 1.0,
                                      indent: 16.0,
                                      endIndent: 16.0,
                                      color: theme.alternate),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // ── Getting Started tips ───────────────────────────────
                    _sectionLabel(context, 'Getting Started'),
                    const SizedBox(height: 10.0),
                    _TipRow(
                      icon: Icons.yard_rounded,
                      color: theme.primary,
                      title: 'Create your first garden',
                      body: 'Go to My Planner → Create Garden. Choose your garden type and size, then start placing plants.',
                    ),
                    const SizedBox(height: 8.0),
                    _TipRow(
                      icon: Icons.local_florist_rounded,
                      color: theme.primary,
                      title: 'Explore the Plant Library',
                      body: 'Browse 130+ plants with detailed growing guides, companion tips, and harvest instructions.',
                    ),
                    const SizedBox(height: 8.0),
                    _TipRow(
                      icon: Icons.lightbulb_rounded,
                      color: theme.primary,
                      title: 'Read the Garden Tips',
                      body: '59 expert tips across watering, soil, pests, composting, organic growing and more — filterable by experience level.',
                    ),
                    const SizedBox(height: 8.0),
                    _TipRow(
                      icon: Icons.calendar_month_rounded,
                      color: theme.primary,
                      title: 'Schedule your tasks',
                      body: 'Add watering, fertilizing, and harvest reminders in the Growing Calendar so nothing gets missed.',
                    ),
                    const SizedBox(height: 24.0),

                    // ── App version ────────────────────────────────────────
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'SproutTogether',
                            style: GoogleFonts.poppins(
                              color: theme.secondaryText,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            'Version 1.0.0',
                            style: GoogleFonts.poppins(
                              color: theme.secondaryText,
                              fontSize: 11.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Learn • Plant • Grow • Share',
                            style: GoogleFonts.poppins(
                              color: theme.secondaryText.withOpacity(0.6),
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
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

  Widget _sectionLabel(BuildContext context, String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
        color: FlutterFlowTheme.of(context).primaryText,
      ),
    );
  }
}

// ── Contact card ─────────────────────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Material(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: theme.alternate),
          ),
          child: Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(icon, color: color, size: 22.0),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: theme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        color: theme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: theme.secondaryText, size: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Getting Started tip row ──────────────────────────────────────────────────

class _TipRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  const _TipRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: theme.alternate),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: color, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  body,
                  style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    color: theme.secondaryText,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
