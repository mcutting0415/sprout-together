import '/flutter_flow/flutter_flow_icon_button.dart';
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
            // Header row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primaryText,
                    borderRadius: 8.0,
                    buttonSize: 40.0,
                    fillColor: FlutterFlowTheme.of(context).alternate,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () => context.safePop(),
                  ),
                  const SizedBox(width: 12.0),
                  Text(
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
                ],
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
