import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'garden_goals_page_model.dart';
export 'garden_goals_page_model.dart';

const _goalTypes = ['Seasonal', 'Harvest', 'Learning', 'Garden', 'Other'];
const _seasons = ['Spring', 'Summer', 'Fall', 'Winter', 'Year-round'];

class GardenGoalsPageWidget extends StatefulWidget {
  const GardenGoalsPageWidget({super.key});

  static String routeName = 'GardenGoalsPage';
  static String routePath = '/gardenGoalsPage';

  @override
  State<GardenGoalsPageWidget> createState() => _GardenGoalsPageWidgetState();
}

class _GardenGoalsPageWidgetState extends State<GardenGoalsPageWidget> {
  late GardenGoalsPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<UserGoalsRow> _goals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenGoalsPageModel());
    _loadGoals();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _loadGoals() async {
    setState(() => _loading = true);
    try {
      final goals = await UserGoalsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('user_id', currentUserUid)
            .order('created_at', ascending: false),
      );
      if (mounted) setState(() { _goals = goals; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _toggleGoal(UserGoalsRow goal) async {
    final nowCompleted = !goal.completed;
    await UserGoalsTable().update(
      data: {
        'completed': nowCompleted,
        'completed_at': nowCompleted ? DateTime.now().toIso8601String() : null,
      },
      matchingRows: (rows) => rows.eqOrNull('id', goal.id),
    );
    await _loadGoals();
  }

  Future<void> _deleteGoal(UserGoalsRow goal) async {
    await UserGoalsTable().delete(
      matchingRows: (rows) => rows.eqOrNull('id', goal.id),
    );
    await _loadGoals();
  }

  Future<void> _showAddGoalSheet() async {
    final textController = TextEditingController();
    String selectedType = 'Seasonal';
    String selectedSeason = 'Year-round';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setModal) {
          return Padding(
            padding: MediaQuery.viewInsetsOf(ctx),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40.0, height: 4.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text('New Garden Goal',
                          style: GoogleFonts.poppins(
                              fontSize: 18.0, fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context).primaryText)),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: textController,
                        autofocus: true,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'What do you want to achieve?',
                          hintStyle: GoogleFonts.poppins(
                              color: FlutterFlowTheme.of(context).secondaryText),
                          filled: true,
                          fillColor: FlutterFlowTheme.of(context).primaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14.0),
                            borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.5),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                            color: FlutterFlowTheme.of(context).primaryText),
                      ),
                      const SizedBox(height: 14.0),
                      // Type chips
                      Text('Type',
                          style: GoogleFonts.poppins(
                              fontSize: 12.0, fontWeight: FontWeight.w600,
                              color: FlutterFlowTheme.of(context).secondaryText)),
                      const SizedBox(height: 6.0),
                      Wrap(
                        spacing: 6.0,
                        children: _goalTypes.map((t) {
                          final selected = selectedType == t;
                          return GestureDetector(
                            onTap: () => setModal(() => selectedType = t),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: selected
                                    ? FlutterFlowTheme.of(context).primary
                                        .withOpacity(0.15)
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: selected
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Text(t,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.0,
                                      fontWeight: selected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: selected
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText)),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 14.0),
                      // Season chips
                      Text('Season',
                          style: GoogleFonts.poppins(
                              fontSize: 12.0, fontWeight: FontWeight.w600,
                              color: FlutterFlowTheme.of(context).secondaryText)),
                      const SizedBox(height: 6.0),
                      Wrap(
                        spacing: 6.0,
                        children: _seasons.map((s) {
                          final selected = selectedSeason == s;
                          return GestureDetector(
                            onTap: () => setModal(() => selectedSeason = s),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFF4E7A2E).withOpacity(0.15)
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: selected
                                      ? const Color(0xFF4E7A2E)
                                      : FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Text(s,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.0,
                                      fontWeight: selected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: selected
                                          ? const Color(0xFF4E7A2E)
                                          : FlutterFlowTheme.of(context)
                                              .primaryText)),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final text = textController.text.trim();
                            if (text.isEmpty) return;
                            await UserGoalsTable().insert({
                              'user_id': currentUserUid,
                              'goal_text': text,
                              'goal_type': selectedType,
                              'season': selectedSeason,
                              'completed': false,
                            });
                            if (ctx.mounted) Navigator.pop(ctx);
                            await _loadGoals();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: FlutterFlowTheme.of(context).primary,
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                          ),
                          child: Text('Add Goal',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'Harvest': return const Color(0xFF7BA05B);
      case 'Learning': return const Color(0xFF4A90A4);
      case 'Garden': return const Color(0xFF4E7A2E);
      case 'Seasonal': return const Color(0xFF9C6EA3);
      default: return const Color(0xFFE0A43A);
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'Harvest': return Icons.grass_rounded;
      case 'Learning': return Icons.school_rounded;
      case 'Garden': return Icons.yard_rounded;
      case 'Seasonal': return Icons.wb_sunny_rounded;
      default: return Icons.flag_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);
    final pending = _goals.where((g) => !g.completed).toList();
    final done = _goals.where((g) => g.completed).toList();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddGoalSheet,
          backgroundColor: theme.primary,
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
        body: Column(
          children: [
            wrapWithModel(
              model: _model.finalHeaderModel,
              updateCallback: () => safeSetState(() {}),
              child: FinalHeaderWidget(
                pageTitle: 'My Goals',
                backAction: () => context.pop(),
              ),
            ),
            Expanded(
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(theme.primary),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadGoals,
                      color: theme.primary,
                      child: _goals.isEmpty
                          ? _buildEmpty(theme)
                          : ListView(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 16.0, 16.0, 100.0),
                              children: [
                                if (pending.isNotEmpty) ...[
                                  _sectionLabel(theme, 'In Progress',
                                      Icons.flag_rounded, theme.primary),
                                  const SizedBox(height: 8.0),
                                  ...pending.map((g) => _goalCard(theme, g)),
                                  const SizedBox(height: 16.0),
                                ],
                                if (done.isNotEmpty) ...[
                                  _sectionLabel(theme, 'Completed',
                                      Icons.check_circle_rounded,
                                      const Color(0xFF4E7A2E)),
                                  const SizedBox(height: 8.0),
                                  ...done.map((g) => _goalCard(theme, g)),
                                ],
                              ],
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(FlutterFlowTheme theme) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const SizedBox(height: 60.0),
        Center(
          child: Column(
            children: [
              Icon(Icons.flag_outlined, size: 64.0, color: theme.secondaryText),
              const SizedBox(height: 16.0),
              Text('No goals yet',
                  style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText)),
              const SizedBox(height: 8.0),
              Text('Tap + to add your first garden goal',
                  style: GoogleFonts.poppins(
                      fontSize: 14.0, color: theme.secondaryText)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(
      FlutterFlowTheme theme, String label, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16.0),
        const SizedBox(width: 6.0),
        Text(label,
            style: GoogleFonts.poppins(
                fontSize: 13.0,
                fontWeight: FontWeight.w600,
                color: color)),
      ],
    );
  }

  Widget _goalCard(FlutterFlowTheme theme, UserGoalsRow goal) {
    final color = _typeColor(goal.goalType);
    final isComplete = goal.completed;
    return Dismissible(
      key: Key(goal.id ?? goal.goalText),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: theme.error.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Icon(Icons.delete_outline_rounded, color: theme.error),
      ),
      onDismissed: (_) => _deleteGoal(goal),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: isComplete
              ? theme.secondaryBackground.withOpacity(0.6)
              : theme.secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isComplete
                ? theme.alternate
                : color.withOpacity(0.3),
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          leading: GestureDetector(
            onTap: () => _toggleGoal(goal),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: isComplete
                    ? const Color(0xFF4E7A2E).withOpacity(0.15)
                    : color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isComplete
                    ? Icons.check_circle_rounded
                    : _typeIcon(goal.goalType),
                color: isComplete ? const Color(0xFF4E7A2E) : color,
                size: 20.0,
              ),
            ),
          ),
          title: Text(
            goal.goalText,
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: isComplete
                  ? theme.secondaryText
                  : theme.primaryText,
              decoration:
                  isComplete ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 7.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(goal.goalType,
                    style: GoogleFonts.poppins(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: color)),
              ),
              if (goal.season != null) ...[
                const SizedBox(width: 4.0),
                Text('· ${goal.season}',
                    style: GoogleFonts.poppins(
                        fontSize: 10.0,
                        color: theme.secondaryText)),
              ],
            ],
          ),
          trailing: GestureDetector(
            onTap: () => _toggleGoal(goal),
            child: Icon(
              isComplete
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              color: isComplete
                  ? const Color(0xFF4E7A2E)
                  : theme.secondaryText,
              size: 22.0,
            ),
          ),
        ),
      ),
    );
  }
}
