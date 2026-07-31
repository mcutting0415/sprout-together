import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common_questions_page_model.dart';
export 'common_questions_page_model.dart';

class CommonQuestionsPageWidget extends StatefulWidget {
  const CommonQuestionsPageWidget({super.key});

  static String routeName = 'CommonQuestionsPage';
  static String routePath = '/commonQuestionsPage';

  @override
  State<CommonQuestionsPageWidget> createState() =>
      _CommonQuestionsPageWidgetState();
}

class _CommonQuestionsPageWidgetState
    extends State<CommonQuestionsPageWidget> {
  late CommonQuestionsPageModel _model;
  final Set<int> _expanded = {};

  static const List<Map<String, String>> _faqs = [
    {
      'q': 'How do I create my first garden?',
      'a':
          'Tap the "Create Garden" button on the Home screen. Give your garden a name, choose a type (raised bed, container, or in-ground), set its size, and tap "Create Garden" to open the Garden Builder.',
    },
    {
      'q': 'How do I add plants to my garden?',
      'a':
          'Open the Garden Builder and tap any empty plot. This will open the Plant Library where you can search and select a plant to place in that spot.',
    },
    {
      'q': 'What is companion planting?',
      'a':
          'Companion planting is the practice of growing different plants near each other for mutual benefit — for example, basil near tomatoes can repel pests and improve flavor. Check the Companion Guide in the app for plant pairings.',
    },
    {
      'q': 'How often should I water my plants?',
      'a':
          'Watering needs depend on the plant and weather. In general, most vegetables need about 1 inch of water per week. Check each plant\'s details in the Plant Library for specific watering requirements.',
    },
    {
      'q': 'What do the sun requirement labels mean?',
      'a':
          '"Full Sun" means 6+ hours of direct sunlight daily. "Partial Sun" means 3–6 hours. "Full Shade" means less than 3 hours. Choose plants that match the sunlight in your garden location.',
    },
    {
      'q': 'How do I track my garden tasks?',
      'a':
          'Use the Planner page to view and manage tasks. You can add tasks like watering, fertilizing, or harvesting and check them off as you complete them.',
    },
    {
      'q': 'Can I have more than one garden?',
      'a':
          'Yes! You can create multiple gardens. Switch between them from the Home screen. Each garden has its own layout, plants, and task list.',
    },
    {
      'q': 'How do I reset my password?',
      'a':
          'On the login screen, tap "Forgot Password" and enter your email address. You will receive a password reset link in your inbox.',
    },
    {
      'q': 'How do I change my profile photo?',
      'a':
          'Go to Settings → Account → Edit Profile, or visit your Profile page and tap your photo.',
    },
    {
      'q': 'How do I delete my account?',
      'a':
          'Go to Settings and scroll to Account Actions. Tap "Delete Account." This action is permanent and cannot be undone.',
    },
    {
      'q': 'What does SproutTogether Pro include?',
      'a':
          'Pro unlocks the Seed Inventory (track your seed collection), Seed Starting Guide (personalized frost-date planting schedule), unlimited gardens, advanced plant health insights, full planting calendar with smart reminders, and priority support. Free users get full access to the Plant Library, Companion Guide, Garden Tips, Indoor Growing guide, and one starter garden.',
    },
    {
      'q': 'How do I use the Seed Starting Guide?',
      'a':
          'The Seed Starting Guide (found in Tools → Seed Starting Guide) is a Pro feature. Tap the frost date card at the top to enter your last expected spring frost date. The guide then calculates exactly when to start seeds indoors and when to transplant outdoors for 40+ vegetables, herbs, flowers, and fruits.',
    },
    {
      'q': 'What is the Seed Inventory?',
      'a':
          'The Seed Inventory (Tools → Seed Inventory, Pro only) lets you log every seed packet you own — variety, quantity, source, purchase date, and notes. It keeps you organized so you always know what you have before buying more.',
    },
    {
      'q': 'How does companion planting work in the app?',
      'a':
          'The Companion Guide (hamburger menu → Companion Plants) lets you select any plant and see its beneficial companions (plants that help it grow or repel pests) and plants to avoid (those that compete or harm each other). Tap any companion plant name to explore it further.',
    },
    {
      'q': 'What do the weather cards on the Planner show?',
      'a':
          'The Planner overview shows current weather and a 5-day forecast for your location. It also generates smart planting suggestions based on today\'s conditions — for example, suggesting you transplant seedlings on rainy days, or warning you to protect plants when frost is coming.',
    },
    {
      'q': 'How do I use the Garden Journal?',
      'a':
          'The Garden Journal (hamburger menu → Garden Journal) lets you write notes, observations, and entries about your garden. Use it to track what worked, what didn\'t, and what you want to try next season. It\'s your personal gardening diary.',
    },
    {
      'q': 'Can I grow plants indoors with this app?',
      'a':
          'Yes! Go to Tools → Indoor Growing for a complete guide to year-round indoor gardening. It covers the best plants for indoors, lighting options (windowsill, LED grow lights, fluorescent), expert tips, and product recommendations.',
    },
    {
      'q': 'How do I add a task to my calendar?',
      'a':
          'Open the Growing Calendar (hamburger menu → Growing Calendar) and tap the "Add Task" button. Choose a task type (Water, Fertilize, Harvest, Plant, Prune, or Other), set a due date, and optionally link it to a garden. The task appears as a dot on the calendar on its due date.',
    },
    {
      'q': 'What are Garden Goals?',
      'a':
          'Garden Goals (hamburger menu → Garden Goals) let you set intentions for your garden season — like "Grow 5 types of tomatoes" or "Start a compost bin." Add goals anytime and check them off as you achieve them. It\'s a great way to stay motivated and focused.',
    },
    {
      'q': 'How do I restore my subscription after reinstalling?',
      'a':
          'Go to your Profile page and tap "Manage Subscription," then tap "Restore Purchases." Make sure you\'re signed in with the same Apple ID you originally used to purchase. If purchases still don\'t restore, contact us at sprouttogether.support@gmail.com.',
    },
    {
      'q': 'Why are some features locked with a PRO badge?',
      'a':
          'Locked features are part of SproutTogether Pro, our subscription tier. Tap any locked feature to see the subscription options and what Pro includes. You can subscribe monthly or annually — the annual plan works out to a much lower cost per month.',
    },
    {
      'q': 'How do I find a specific plant in the Plant Library?',
      'a':
          'Open the Plant Library and use the search bar at the top to search by plant name. You can also filter by category using the chips below the search bar (Vegetables, Herbs, Fruits, Flowers). Tap any plant card to view its full details, including growing requirements, harvest instructions, and companion planting info.',
    },
    {
      'q': 'What plant information is in the Plant Library?',
      'a':
          'Each plant page includes: sun and water requirements, spacing, days to harvest, planting season, companion plants to grow with and avoid, and a full knowledge guide covering soil preparation, fertilizing, common problems, harvest tips, and storage. Over 130 plants are covered.',
    },
    {
      'q': 'Can I archive gardens I\'m no longer using?',
      'a':
          'Yes! From your Garden Insights page, you can archive any garden. Archived gardens move to the "Your Archive" section (hamburger menu → Your Archive) where you can view them for reference or restore them later.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommonQuestionsPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Common Questions',
                  style:
                      FlutterFlowTheme.of(context).headlineSmall.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 32.0),
                itemCount: _faqs.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                itemBuilder: (context, index) {
                  final faq = _faqs[index];
                  final isOpen = _expanded.contains(index);
                  return Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.0),
                      onTap: () => setState(() {
                        if (isOpen) {
                          _expanded.remove(index);
                        } else {
                          _expanded.add(index);
                        }
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color:
                                FlutterFlowTheme.of(context).alternate,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: const Color(0x0A000000),
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      faq['q']!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  Icon(
                                    isOpen
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primary,
                                    size: 22.0,
                                  ),
                                ],
                              ),
                              if (isOpen) ...[
                                const SizedBox(height: 10.0),
                                Divider(
                                  height: 1.0,
                                  thickness: 1.0,
                                  color:
                                      FlutterFlowTheme.of(context).alternate,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  faq['a']!,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
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
