import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/add_task_sheet_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/final_app_pages/garden_goals_page/garden_goals_page_widget.dart';
import '/final_app_pages/garden_journal_page2/garden_journal_page2_widget.dart';
import '/final_app_pages/garden_tips_page/garden_tips_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'current_gardens3_model.dart';
export 'current_gardens3_model.dart';

class CurrentGardens3Widget extends StatefulWidget {
  const CurrentGardens3Widget({super.key, this.fromPlanner = false});

  final bool fromPlanner;

  static String routeName = 'CurrentGardens3';
  static String routePath = '/currentGardens3';

  @override
  State<CurrentGardens3Widget> createState() => _CurrentGardens3WidgetState();
}

class _CurrentGardens3WidgetState extends State<CurrentGardens3Widget> {
  late CurrentGardens3Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProfilesRow? _profile;
  List<GardensRow> _gardens = [];
  List<UserSelectedPlantsRow> _selectedPlants = [];
  List<PlantsRow> _plantDetails = [];
  List<GardenTasksRow> _upcomingTasks = [];
  List<GardenJournalEntriesRow> _recentJournal = [];
  List<UserGoalsRow> _goals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CurrentGardens3Model());
    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _loading = true);
    try {
      final now = DateTime.now();
      final weekLater = now.add(const Duration(days: 7));

      final profileRows = await ProfilesTable().queryRows(
        queryFn: (q) => q.eqOrNull('id', currentUserUid),
      );
      final gardens = await GardensTable().queryRows(
        queryFn: (q) =>
            q.eqOrNull('user_id', currentUserUid).eqOrNull('is_archived', false),
      );
      final tasks = await GardenTasksTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('user_id', currentUserUid)
            .eqOrNull('completed', false)
            .gte('due_date', now.toIso8601String())
            .lte('due_date', weekLater.toIso8601String())
            .order('due_date'),
      );
      final selectedPlants = await UserSelectedPlantsTable().queryRows(
        queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
      );
      final journal = await GardenJournalEntriesTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('user_id', currentUserUid)
            .order('entry_date', ascending: false)
            .limit(3),
      );
      final goals = await UserGoalsTable().queryRows(
        queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
      );
      final plants = await PlantsTable().queryRows(
        queryFn: (q) => q.order('plant_name'),
      );

      if (!mounted) return;
      setState(() {
        _profile = profileRows.isNotEmpty ? profileRows.first : null;
        _gardens = gardens;
        _upcomingTasks = tasks;
        _selectedPlants = selectedPlants;
        _recentJournal = journal;
        _goals = goals;
        _plantDetails = plants;
        _loading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  PlantsRow? _plantById(String plantId) {
    try {
      return _plantDetails.firstWhere((p) => p.id == plantId);
    } catch (_) {
      return null;
    }
  }

  String get _experienceLevel {
    if (_profile?.experienceLevel != null &&
        _profile!.experienceLevel!.isNotEmpty) {
      return _profile!.experienceLevel!;
    }
    final appLevel = FFAppState().setupExperienceLevel;
    return appLevel.isNotEmpty ? appLevel : 'Beginner';
  }

  List<Map<String, dynamic>> get _tips {
    switch (_experienceLevel) {
      case 'Advanced':
        return [
          {
            'icon': Icons.science_rounded,
            'color': const Color(0xFF4E7A2E),
            'text': 'Rotate plant families each season to break pest and disease cycles naturally.',
            'detail': 'Divide plants into families: nightshades (tomato, pepper, eggplant), brassicas (cabbage, broccoli, kale), alliums (onion, garlic), and cucurbits (cucumber, squash). Move each family to a new bed each season. After 3–4 rotations, many soil-borne diseases and pests that target specific families are starved out.',
            'action': null,
          },
          {
            'icon': Icons.water_rounded,
            'color': const Color(0xFF4A90A4),
            'text': 'Monitor soil pH weekly — most vegetables thrive between 6.0 and 7.0.',
            'detail': 'Use a digital pH meter or test strips. If pH is too low (acidic), add garden lime. If too high (alkaline), add sulfur or peat moss. Check after heavy rains, which can leach lime and drop pH. Record readings in your Garden Journal to spot trends over the season.',
            'action': 'journal',
          },
          {
            'icon': Icons.layers_rounded,
            'color': const Color(0xFFE0A43A),
            'text': 'Layer green and brown compost 1:2 to maintain 55–65°C and speed decomposition.',
            'detail': 'Greens: kitchen scraps, fresh grass clippings, coffee grounds. Browns: dry leaves, cardboard, straw. The 1:2 green-to-brown ratio keeps nitrogen and carbon balanced so microbes thrive. Turn the pile every 3–5 days to introduce oxygen and sustain heat. At 55–65°C, weed seeds and most pathogens are destroyed.',
            'action': null,
          },
          {
            'icon': Icons.bug_report_rounded,
            'color': const Color(0xFFD9534F),
            'text': 'Introduce beneficial insects like lacewings or parasitic wasps for long-term pest suppression.',
            'detail': 'Lacewings eat aphids, whiteflies, and small caterpillars. Parasitic wasps lay eggs inside hornworms and aphids, killing them from within. Attract them by planting dill, fennel, or yarrow near your vegetables. Avoid broad-spectrum pesticides — they kill beneficial insects too.',
            'action': null,
          },
        ];
      case 'Intermediate':
        return [
          {
            'icon': Icons.grass_rounded,
            'color': const Color(0xFF4E7A2E),
            'text': 'Pinch suckers on tomatoes weekly to redirect energy into fruit production.',
            'detail': 'Suckers are small shoots that grow in the "V" between the main stem and a branch. Left unchecked, they become full branches and dilute the plant\'s energy. Pinch them off when small (under 2 inches) with your fingers. Focus especially on suckers below the first flower cluster. Indeterminate varieties benefit most from this.',
            'action': null,
          },
          {
            'icon': Icons.pest_control_rounded,
            'color': const Color(0xFFD9534F),
            'text': 'Check leaf undersides for aphids — a strong blast of water dislodges most colonies.',
            'detail': 'Aphids cluster on tender new growth and leaf undersides, sucking sap and leaving sticky honeydew behind. Check weekly. A forceful spray of water removes 90% of them without chemicals. For persistent infestations, spray neem oil in the evening when bees are inactive. Log what you find in your journal to catch patterns early.',
            'action': 'journal',
          },
          {
            'icon': Icons.thermostat_rounded,
            'color': const Color(0xFF4A90A4),
            'text': 'Harden off seedlings over 7–10 days to prevent transplant shock before moving outdoors.',
            'detail': 'Seedlings grown indoors are not used to direct sun, wind, or temperature swings. Start by placing them outside in shade for 1–2 hours a day. Over 7–10 days, gradually increase sun exposure and duration. By day 10 they should be outside most of the day. This prevents wilting, sunscald, and root stress after transplanting.',
            'action': null,
          },
          {
            'icon': Icons.compost_rounded,
            'color': const Color(0xFFE0A43A),
            'text': 'Side-dress heavy feeders like corn and squash with compost mid-season.',
            'detail': 'Side-dressing means spreading a 1–2 inch band of compost around the base of the plant, 4–6 inches from the stem, then watering it in. Do this when corn is knee-high and when squash starts setting fruit. It gives a slow-release nitrogen boost at the exact moment the plant needs it most for fruit development.',
            'action': null,
          },
        ];
      default: // Beginner
        return [
          {
            'icon': Icons.water_drop_rounded,
            'color': const Color(0xFF4A90A4),
            'text': 'Water in the morning so leaves dry before nighttime — this prevents mold and fungal disease.',
            'detail': 'Wet foliage overnight creates the perfect conditions for powdery mildew, botrytis, and other fungal diseases. Morning watering gives leaves the whole day to dry. Water at the base of the plant when possible — a soaker hose or watering can aimed at the soil keeps leaves dry entirely. If you must water in the evening, water only the soil.',
            'action': null,
          },
          {
            'icon': Icons.wb_sunny_rounded,
            'color': const Color(0xFFE0A43A),
            'text': 'Most plants need 6–8 hours of direct sun per day. Track which spots in your yard get shade.',
            'detail': 'Walk your yard at 10am, 12pm, 2pm, and 4pm and note which areas are sunny vs. shaded. Tall fences, trees, and the house itself cast moving shadows throughout the day. "Full sun" means 6+ hours of direct sun. "Part shade" means 3–6 hours. Knowing your sun patterns helps you place the right plants in the right spots.',
            'action': 'journal',
          },
          {
            'icon': Icons.eco_rounded,
            'color': const Color(0xFF4E7A2E),
            'text': 'Start with easy wins: lettuce, radishes, and zucchini grow fast and are hard to mess up.',
            'detail': 'Radishes are ready in just 25–30 days. Lettuce can be harvested leaf by leaf in 30–45 days. Zucchini grows so vigorously that beginners often have more than they can eat. These plants give you quick feedback and confidence. Once you\'ve grown them, move on to tomatoes, peppers, or herbs — which need a bit more attention.',
            'action': null,
          },
          {
            'icon': Icons.spa_rounded,
            'color': const Color(0xFF9C6EA3),
            'text': 'Mulch around plants keeps soil moist, suppresses weeds, and keeps roots cool.',
            'detail': 'Apply 2–3 inches of straw, wood chips, or shredded leaves around (not touching) plant stems. Mulch cuts watering frequency roughly in half, keeps soil temperature 10°F cooler on hot days, and smothers weed seeds. Refresh it mid-season if it thins out. Avoid piling mulch against stems — it can cause rot.',
            'action': null,
          },
        ];
    }
  }

  String _taskDayLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);
    final diff = d.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    return DateFormat('EEE, MMM d').format(date);
  }

  IconData _taskIcon(String? type) {
    switch (type) {
      case 'Water':
        return Icons.water_drop_rounded;
      case 'Fertilize':
        return Icons.eco_rounded;
      case 'Prune':
        return Icons.content_cut_rounded;
      case 'Harvest':
        return Icons.grass_rounded;
      case 'Plant':
        return Icons.spa_rounded;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color _taskColor(String? type) {
    switch (type) {
      case 'Water':
        return const Color(0xFF4A90A4);
      case 'Fertilize':
        return const Color(0xFF4E7A2E);
      case 'Prune':
        return const Color(0xFFE0A43A);
      case 'Harvest':
        return const Color(0xFF7BA05B);
      case 'Plant':
        return const Color(0xFF9C6EA3);
      default:
        return const Color(0xFF888888);
    }
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
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: Column(
          children: [
            Container(
              height: 1.0,
              color: theme.alternate,
            ),
            wrapWithModel(
              model: _model.finalHeaderModel,
              updateCallback: () => safeSetState(() {}),
              child: FinalHeaderWidget(
                pageTitle: 'Garden Insights',
                menuReplaceBackAction: widget.fromPlanner ? () => context.pop() : null,
              ),
            ),
            Expanded(
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadData,
                      color: theme.primary,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildStatsRow(theme),
                            const SizedBox(height: 8.0),
                            _buildGardensSection(theme),
                            _buildUpcomingTasksSection(theme),
                            _buildJournalSection(theme),
                            _buildTipsSection(theme),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ── STATS ROW ──────────────────────────────────────────────────────────────
  Widget _buildStatsRow(FlutterFlowTheme theme) {
    final completedGoals = _goals.where((g) => g.completed).length;
    final totalGoals = _goals.length;
    final goalsText = totalGoals == 0
        ? '–'
        : '$completedGoals/$totalGoals';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
      child: Row(
        children: [
          _statCard(theme, icon: Icons.yard_rounded, label: 'Gardens',
              value: '${_gardens.length}', color: const Color(0xFF4E7A2E)),
          const SizedBox(width: 10.0),
          _statCard(theme, icon: Icons.local_florist_rounded, label: 'Plants',
              value: '${_selectedPlants.length}', color: const Color(0xFF7BA05B)),
          const SizedBox(width: 10.0),
          _statCard(theme, icon: Icons.calendar_today_rounded, label: "This Week's\nTo-Do's",
              value: '${_upcomingTasks.length}', color: const Color(0xFF4A90A4)),
          const SizedBox(width: 10.0),
          Expanded(
            child: GestureDetector(
              onTap: () => context.pushNamed(GardenGoalsPageWidget.routeName),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0A43A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFE0A43A).withOpacity(0.25)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.flag_rounded, color: Color(0xFFE0A43A), size: 22.0),
                    const SizedBox(height: 4.0),
                    Text(goalsText,
                        style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.bold, color: theme.primaryText)),
                    Text('Goals', textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 10.0, color: theme.secondaryText, height: 1.2)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    FlutterFlowTheme theme, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22.0),
            const SizedBox(height: 4.0),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: theme.primaryText,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 10.0,
                color: theme.secondaryText,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── TIPS FOR YOUR LEVEL ────────────────────────────────────────────────────
  Widget _buildTipsSection(FlutterFlowTheme theme) {
    final tips = _tips;
    final levelColor = _experienceLevel == 'Advanced'
        ? const Color(0xFF9C6EA3)
        : _experienceLevel == 'Intermediate'
            ? const Color(0xFFE0A43A)
            : const Color(0xFF4A90A4);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            theme,
            icon: Icons.lightbulb_rounded,
            title: 'Tips for You',
            badge: _experienceLevel,
            badgeColor: levelColor,
          ),
          const SizedBox(height: 12.0),
          ...tips.map((tip) => _tipCard(theme, tip)),
          const SizedBox(height: 4.0),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => context.pushNamed(
                GardenTipsPageWidget.routeName,
                queryParameters: {'experienceLevel': _experienceLevel},
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View all tips & hacks',
                    style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4E7A2E),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(Icons.arrow_forward_rounded,
                      size: 14.0, color: Color(0xFF4E7A2E)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _tipCard(FlutterFlowTheme theme, Map<String, dynamic> tip) {
    final color = tip['color'] as Color;
    final detail = tip['detail'] as String? ?? '';
    final action = tip['action'] as String?;
    return GestureDetector(
      onTap: () => _showTipDetail(theme, tip),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(tip['icon'] as IconData, color: color, size: 18.0),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                tip['text'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 13.0,
                  height: 1.5,
                  color: theme.primaryText,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: color, size: 18.0),
          ],
        ),
      ),
    );
  }

  void _showTipDetail(FlutterFlowTheme theme, Map<String, dynamic> tip) {
    final color = tip['color'] as Color;
    final action = tip['action'] as String?;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.only(top: 80.0),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          border: Border.all(color: theme.alternate),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: theme.secondaryText.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Container(
                      width: 44.0, height: 44.0,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(tip['icon'] as IconData, color: color, size: 22.0),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Text(
                        tip['text'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: color.withOpacity(0.15)),
                  ),
                  child: Text(
                    tip['detail'] as String? ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      height: 1.6,
                      color: theme.primaryText,
                    ),
                  ),
                ),
                if (action == 'journal') ...[
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        showAddJournalEntrySheet(context, () {
                          _loadData();
                        });
                      },
                      icon: const Icon(Icons.menu_book_rounded, size: 18.0),
                      label: const Text('Log a Note in Garden Journal'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── UPCOMING TASKS ─────────────────────────────────────────────────────────
  Widget _buildUpcomingTasksSection(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _sectionHeader(
                  theme,
                  icon: Icons.calendar_month_rounded,
                  title: 'Upcoming Tasks',
                  subtitle: 'Next 7 days',
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => AddTaskSheetWidget(
                      gardenId: _gardens.isNotEmpty ? _gardens.first.id : null,
                    ),
                  );
                  _loadData();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: theme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_rounded, color: theme.primary, size: 14.0),
                      const SizedBox(width: 4.0),
                      Text(
                        'Add Task',
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          if (_upcomingTasks.isEmpty)
            _emptyState(theme,
                icon: Icons.calendar_today_rounded,
                message: 'No tasks due this week.\nAdd tasks in the Growing Calendar.')
          else
            Column(
              children: _upcomingTasks.map((task) {
                final color = _taskColor(task.taskType);
                final dueDate = task.dueDate;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: theme.alternate),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_taskIcon(task.taskType),
                            color: color, size: 16.0),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.taskName ?? 'Task',
                              style: GoogleFonts.poppins(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: theme.primaryText,
                              ),
                            ),
                            if (dueDate != null)
                              Text(
                                _taskDayLabel(dueDate),
                                style: GoogleFonts.poppins(
                                  fontSize: 11.0,
                                  color: theme.secondaryText,
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (task.taskType != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            task.taskType!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  // ── YOUR GARDENS ──────────────────────────────────────────────────────────
  Widget _buildGardensSection(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            theme,
            icon: Icons.yard_rounded,
            title: 'Your Gardens',
          ),
          const SizedBox(height: 12.0),
          if (_gardens.isEmpty)
            _emptyState(theme,
                icon: Icons.yard_outlined,
                message: 'No gardens yet. Create your first garden to get started.')
          else
            Column(
              children: _gardens.map((g) => _gardenCard(theme, g)).toList(),
            ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _gardenCard(FlutterFlowTheme theme, GardensRow garden) {
    final size = (garden.width != null && garden.length != null)
        ? '${garden.width} × ${garden.length} ${garden.measurementUnit ?? 'ft'}'
        : null;
    return GestureDetector(
      onTap: () => _showGardenDetail(theme, garden),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: theme.alternate),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Mini garden grid thumbnail ──────────────────────────────
            if (garden.width != null && garden.length != null)
              FutureBuilder<List<GardenPlotsRow>>(
                future: GardenPlotsTable().queryRows(
                  queryFn: (q) => q
                      .eqOrNull('garden_id', garden.id)
                      .order('row_index', ascending: true)
                      .order('col_index', ascending: true),
                ),
                builder: (context, snapshot) {
                  final plots = snapshot.data ?? [];
                  final colCount = (garden.width!).clamp(1, 10);
                  final rowCount = (garden.length!).clamp(1, 10);
                  final previewRows = rowCount.clamp(1, 3);
                  final previewCount = colCount * previewRows;
                  // Build set of planted cell positions from real data
                  final plantedCells = <String>{};
                  for (final p in plots) {
                    if (p.plantId != null && p.plantId!.isNotEmpty) {
                      plantedCells.add('${p.rowIndex}_${p.colIndex}');
                    }
                  }
                  return ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14.0)),
                    child: Container(
                      color: const Color(0x0D6F8F72),
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: colCount,
                              crossAxisSpacing: 3.0,
                              mainAxisSpacing: 3.0,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: previewCount,
                            itemBuilder: (context, i) {
                              final row = i ~/ colCount;
                              final col = i % colCount;
                              final hasPlant = plantedCells.contains('${row}_${col}');
                              return Container(
                                decoration: BoxDecoration(
                                  color: hasPlant
                                      ? const Color(0xFF6F8F72)
                                      : theme.secondaryBackground,
                                  borderRadius: BorderRadius.circular(3.0),
                                  border: Border.all(
                                    color: hasPlant
                                        ? const Color(0xFF4E7A2E)
                                        : theme.alternate,
                                    width: 0.5,
                                  ),
                                ),
                              );
                            },
                          ),
                          if (rowCount > previewRows)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                '+${rowCount - previewRows} more rows',
                                style: GoogleFonts.poppins(
                                  fontSize: 9.0,
                                  color: theme.secondaryText,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            // ── Garden info row ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E7A2E).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Icon(Icons.yard_rounded,
                        color: Color(0xFF4E7A2E), size: 22.0),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          garden.gardenName ?? 'Garden',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: theme.primaryText,
                          ),
                        ),
                        Row(
                          children: [
                            if (garden.gardenType != null) ...[
                              Text(
                                garden.gardenType!,
                                style: GoogleFonts.poppins(
                                    fontSize: 11.0, color: theme.secondaryText),
                              ),
                              if (size != null)
                                Text(' · ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 11.0, color: theme.secondaryText)),
                            ],
                            if (size != null)
                              Text(
                                size,
                                style: GoogleFonts.poppins(
                                    fontSize: 11.0, color: theme.secondaryText),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (garden.sunExposure != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0A43A).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.wb_sunny_rounded,
                              color: Color(0xFFE0A43A), size: 12.0),
                          const SizedBox(width: 3.0),
                          Text(
                            garden.sunExposure!,
                            style: GoogleFonts.poppins(
                              fontSize: 10.0,
                              color: const Color(0xFFE0A43A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showGardenDetail(FlutterFlowTheme theme, GardensRow garden) async {
    final size = (garden.width != null && garden.length != null)
        ? '${garden.width} × ${garden.length} ${garden.measurementUnit ?? 'ft'}'
        : null;

    // ── Load plots and plant names before showing the sheet ──────────────────
    List<GardenPlotsRow> plots = [];
    Map<String, String> plantNames = {};
    try {
      plots = await GardenPlotsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('garden_id', garden.id)
            .order('row_index', ascending: true)
            .order('col_index', ascending: true),
      );
      final plantIds = plots
          .where((p) => p.plantId != null && p.plantId!.isNotEmpty)
          .map((p) => p.plantId!)
          .toSet()
          .toList();
      if (plantIds.isNotEmpty) {
        final plantRows = await PlantsTable().queryRows(
          queryFn: (q) => q.inFilterOrNull('id', plantIds),
        );
        for (final p in plantRows) {
          if (p.id != null) plantNames[p.id!] = p.plantName ?? 'Plant';
        }
      }
    } catch (_) {}

    if (!mounted) return;

    final colCount = (garden.width?.toInt() ?? 4).clamp(1, 12);
    final rowCount = (garden.length?.toInt() ?? 4).clamp(1, 12);
    final totalCells = colCount * rowCount;
    final assignedCount = plots.where((p) => p.plantId != null && p.plantId!.isNotEmpty).length;
    // Position-based map: 'row_col' → plot
    final plotMap = <String, GardenPlotsRow>{};
    for (final p in plots) {
      if (p.rowIndex != null && p.colIndex != null) {
        plotMap['${p.rowIndex}_${p.colIndex}'] = p;
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.only(top: 80.0),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          border: Border.all(color: theme.alternate),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: theme.secondaryText.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Garden name + type header
                Row(
                  children: [
                    Container(
                      width: 48.0, height: 48.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E7A2E).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(Icons.yard_rounded, color: Color(0xFF4E7A2E), size: 24.0),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            garden.gardenName ?? 'Garden',
                            style: GoogleFonts.poppins(
                              fontSize: 18.0, fontWeight: FontWeight.bold,
                              color: theme.primaryText,
                            ),
                          ),
                          if (garden.gardenType != null)
                            Text(garden.gardenType!,
                              style: GoogleFonts.poppins(fontSize: 13.0, color: theme.secondaryText)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                // Detail rows
                if (size != null) _detailRow(theme, Icons.straighten_rounded, 'Size', size),
                if (garden.sunExposure != null)
                  _detailRow(theme, Icons.wb_sunny_rounded, 'Sun Exposure', garden.sunExposure!),
                _detailRow(theme, Icons.local_florist_rounded, 'Plants Placed',
                    '$assignedCount / $totalCells squares'),

                // ── Read-only garden layout preview ──────────────────────────
                ...[
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Icon(Icons.grid_view_rounded, size: 15.0, color: Color(0xFF4E7A2E)),
                      const SizedBox(width: 6.0),
                      Text(
                        'Garden Layout',
                        style: GoogleFonts.poppins(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: const Color(0x0D6F8F72),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(color: const Color(0x336F8F72)),
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: colCount,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: totalCells,
                      itemBuilder: (context, i) {
                        final row = i ~/ colCount;
                        final col = i % colCount;
                        final plot = plotMap['${row}_${col}'];
                        final hasPlant = plot != null &&
                            plot.plantId != null && plot.plantId!.isNotEmpty;
                        final plantName =
                            hasPlant ? (plantNames[plot!.plantId] ?? 'Plant') : null;
                        // Two-letter abbreviation: e.g. "Cherry Tomato" → "CT"
                        final abbrev = plantName != null
                            ? plantName
                                .split(' ')
                                .where((w) => w.isNotEmpty)
                                .take(2)
                                .map((w) => w[0].toUpperCase())
                                .join()
                            : null;
                        return Tooltip(
                          message: plantName ?? '',
                          child: Container(
                            decoration: BoxDecoration(
                              color: hasPlant
                                  ? const Color(0x1A6F8F72)
                                  : theme.secondaryBackground,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: hasPlant
                                    ? const Color(0xFF6F8F72)
                                    : theme.alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Center(
                              child: hasPlant
                                  ? Text(
                                      abbrev!,
                                      style: GoogleFonts.poppins(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF4E7A2E),
                                      ),
                                    )
                                  : Icon(Icons.add,
                                      size: 10.0,
                                      color: theme.secondaryText
                                          .withOpacity(0.3)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (plantNames.isNotEmpty) ...[
                    const SizedBox(height: 10.0),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: plantNames.values.toSet().map((name) {
                        final abbrev = name
                            .split(' ')
                            .where((w) => w.isNotEmpty)
                            .take(2)
                            .map((w) => w[0].toUpperCase())
                            .join();
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: const Color(0x1A6F8F72),
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: const Color(0x336F8F72)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                abbrev,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF4E7A2E),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                name,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.0,
                                  color: theme.primaryText,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],

                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          context.pushNamed(
                            'GardenBuilderPage',
                            queryParameters: {'gardenID': garden.id ?? ''},
                          );
                        },
                        icon: const Icon(Icons.edit_rounded, size: 16.0),
                        label: const Text('Edit Garden'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.primary,
                          side: BorderSide(color: theme.primary),
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(FlutterFlowTheme theme, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Icon(icon, size: 16.0, color: theme.secondaryText),
          const SizedBox(width: 8.0),
          Text(label, style: GoogleFonts.poppins(fontSize: 13.0, color: theme.secondaryText)),
          const Spacer(),
          Text(value, style: GoogleFonts.poppins(fontSize: 13.0, fontWeight: FontWeight.w600, color: theme.primaryText)),
        ],
      ),
    );
  }

  // ── PLANTS YOU WANT TO GROW ────────────────────────────────────────────────
  Widget _buildPlantsSection(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            theme,
            icon: Icons.local_florist_rounded,
            title: 'Plants to Grow',
            subtitle: '${_selectedPlants.length} selected',
          ),
          const SizedBox(height: 12.0),
          if (_selectedPlants.isEmpty)
            _emptyState(theme,
                icon: Icons.local_florist_outlined,
                message:
                    'No plants selected yet. Add plants in the Planner to see insights here.')
          else
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _selectedPlants.map((sp) {
                final plant = _plantById(sp.plantId);
                final name = plant?.plantName ?? 'Unknown Plant';
                final dth = plant?.daysToHarvest;
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E7A2E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        color: const Color(0xFF4E7A2E).withOpacity(0.25)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.eco_rounded,
                          color: Color(0xFF4E7A2E), size: 14.0),
                      const SizedBox(width: 6.0),
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: theme.primaryText,
                        ),
                      ),
                      if (dth != null) ...[
                        const SizedBox(width: 4.0),
                        Text(
                          '· ${dth}d',
                          style: GoogleFonts.poppins(
                            fontSize: 11.0,
                            color: theme.secondaryText,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  // ── RECENT JOURNAL ─────────────────────────────────────────────────────────
  Widget _buildJournalSection(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            theme,
            icon: Icons.menu_book_rounded,
            title: 'Recent Journal',
          ),
          const SizedBox(height: 12.0),
          if (_recentJournal.isEmpty)
            _emptyState(theme,
                icon: Icons.menu_book_outlined,
                message: 'No journal entries yet.\nStart logging your garden progress.')
          else
            Column(
              children: _recentJournal.map((e) => _journalCard(theme, e)).toList(),
            ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _journalCard(FlutterFlowTheme theme, GardenJournalEntriesRow entry) {
    final dateStr = entry.entryDate != null
        ? DateFormat('MMM d, yyyy').format(entry.entryDate!)
        : entry.createdAt != null
            ? DateFormat('MMM d, yyyy').format(entry.createdAt!)
            : '';
    return GestureDetector(
      onTap: () => _showJournalEntryDetail(theme, entry),
      child: Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: theme.alternate),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34.0,
            height: 34.0,
            decoration: BoxDecoration(
              color: const Color(0xFF9C6EA3).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit_note_rounded,
                color: Color(0xFF9C6EA3), size: 18.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title ?? 'Journal Entry',
                  style: GoogleFonts.poppins(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryText,
                  ),
                ),
                if (entry.entryText != null)
                  Text(
                    entry.entryText!.length > 80
                        ? '${entry.entryText!.substring(0, 80)}…'
                        : entry.entryText!,
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: theme.secondaryText,
                      height: 1.4,
                    ),
                  ),
                if (dateStr.isNotEmpty)
                  Text(
                    dateStr,
                    style: GoogleFonts.poppins(
                      fontSize: 10.0,
                      color: theme.secondaryText,
                    ),
                  ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: const Color(0xFF9C6EA3), size: 18.0),
        ],
      ),
      ),
    );
  }

  // ── JOURNAL ENTRY DETAIL ───────────────────────────────────────────────────
  void _showJournalEntryDetail(FlutterFlowTheme theme, GardenJournalEntriesRow entry) {
    final dateStr = entry.entryDate != null
        ? DateFormat('MMMM d, yyyy').format(entry.entryDate!)
        : entry.createdAt != null
            ? DateFormat('MMMM d, yyyy').format(entry.createdAt!)
            : '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.only(top: 80.0),
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          border: Border.all(color: theme.alternate),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40, height: 4,
                    decoration: BoxDecoration(
                      color: theme.secondaryText.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                if (entry.imageUrl != null && entry.imageUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14.0),
                    child: Image.network(
                      entry.imageUrl!,
                      width: double.infinity,
                      height: 180.0,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                if (entry.imageUrl != null && entry.imageUrl!.isNotEmpty)
                  const SizedBox(height: 16.0),
                Text(
                  entry.title ?? 'Journal Entry',
                  style: GoogleFonts.poppins(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryText,
                  ),
                ),
                if (dateStr.isNotEmpty) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    dateStr,
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: theme.secondaryText,
                    ),
                  ),
                ],
                const SizedBox(height: 16.0),
                if (entry.entryText != null && entry.entryText!.isNotEmpty)
                  Text(
                    entry.entryText!,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      height: 1.6,
                      color: theme.primaryText,
                    ),
                  ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.pushNamed(
                        GardenJournalPage2Widget.routeName,
                        queryParameters: {'fromInsights': serializeParam(true, ParamType.bool)}.withoutNulls,
                      );
                    },
                    icon: const Icon(Icons.menu_book_rounded, size: 16.0),
                    label: const Text('Open in Journal'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.primary,
                      side: BorderSide(color: theme.primary),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── SHARED HELPERS ─────────────────────────────────────────────────────────
  Widget _sectionHeader(
    FlutterFlowTheme theme, {
    required IconData icon,
    required String title,
    String? subtitle,
    String? badge,
    Color? badgeColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: theme.primary, size: 20.0),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: theme.primaryText,
          ),
        ),
        const Spacer(),
        if (badge != null)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: (badgeColor ?? theme.primary).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              badge,
              style: GoogleFonts.poppins(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: badgeColor ?? theme.primary,
              ),
            ),
          ),
        if (subtitle != null)
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12.0,
              color: theme.secondaryText,
            ),
          ),
      ],
    );
  }

  Widget _emptyState(FlutterFlowTheme theme,
      {required IconData icon, required String message}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: theme.alternate),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.secondaryText, size: 32.0),
          const SizedBox(height: 8.0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13.0,
              color: theme.secondaryText,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
