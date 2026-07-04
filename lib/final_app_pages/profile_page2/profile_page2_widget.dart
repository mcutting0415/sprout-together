import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/storage/storage.dart';
import '/backend/supabase/supabase.dart';
import '/components/account_management_rounded_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_page2_model.dart';
export 'profile_page2_model.dart';

class ProfilePage2Widget extends StatefulWidget {
  const ProfilePage2Widget({super.key});

  static String routeName = 'ProfilePage2';
  static String routePath = '/profilePage2';

  @override
  State<ProfilePage2Widget> createState() => _ProfilePage2WidgetState();
}

class _ProfilePage2WidgetState extends State<ProfilePage2Widget> {
  late ProfilePage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isUploadingPhoto = false;
  String? _localImageUrl;

  // Goals state
  List<UserGoalsRow> _goals = [];
  bool _goalsLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilePage2Model());
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    setState(() => _goalsLoading = true);
    try {
      final rows = await UserGoalsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('user_id', currentUserUid)
            .order('created_at', ascending: true),
      );
      // If no initial goals exist yet, seed them from the profile's goals array
      final hasInitial = rows.any((r) => r.goalType == 'initial');
      if (!hasInitial) {
        final profileRows = await ProfilesTable().querySingleRow(
          queryFn: (q) => q.eqOrNull('id', currentUserUid),
        );
        final profileGoals = profileRows.firstOrNull?.goals ?? [];
        if (profileGoals.isNotEmpty) {
          for (final g in profileGoals) {
            await UserGoalsTable().insert({
              'user_id': currentUserUid,
              'goal_text': g,
              'goal_type': 'initial',
              'completed': false,
            });
          }
          // Reload after seeding
          final updated = await UserGoalsTable().queryRows(
            queryFn: (q) => q
                .eqOrNull('user_id', currentUserUid)
                .order('created_at', ascending: true),
          );
          if (mounted) setState(() { _goals = updated; _goalsLoading = false; });
          return;
        }
      }
      if (mounted) setState(() { _goals = rows; _goalsLoading = false; });
    } catch (_) {
      if (mounted) setState(() => _goalsLoading = false);
    }
  }

  Future<void> _toggleGoal(UserGoalsRow goal) async {
    final newVal = !goal.completed;
    await UserGoalsTable().update(
      data: {
        'completed': newVal,
        'completed_at': newVal ? DateTime.now().toIso8601String() : null,
      },
      matchingRows: (q) => q.eqOrNull('id', goal.id),
    );
    await _loadGoals();
  }

  Future<void> _deleteGoal(UserGoalsRow goal) async {
    await UserGoalsTable().delete(
      matchingRows: (q) => q.eqOrNull('id', goal.id),
    );
    await _loadGoals();
  }

  Future<void> _showAddGoalSheet() async {
    final controller = TextEditingController();
    String goalType = 'custom';
    String? season;

    // Current season label
    final now = DateTime.now();
    final seasonLabel = now.month >= 3 && now.month <= 5 ? 'Spring ${now.year}'
        : now.month >= 6 && now.month <= 8 ? 'Summer ${now.year}'
        : now.month >= 9 && now.month <= 11 ? 'Fall ${now.year}'
        : 'Winter ${now.year}';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            padding: const EdgeInsets.all(24.0),
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
                const SizedBox(height: 20.0),
                Text('Add a Goal', style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  letterSpacing: 0.0,
                )),
                const SizedBox(height: 16.0),
                // Type selector
                Row(
                  children: [
                    _typeChip(ctx, setSheetState, label: 'Personal', value: 'custom',
                        selected: goalType == 'custom',
                        onTap: () { setSheetState(() { goalType = 'custom'; season = null; }); }),
                    const SizedBox(width: 8.0),
                    _typeChip(ctx, setSheetState, label: 'Seasonal', value: 'seasonal',
                        selected: goalType == 'seasonal',
                        onTap: () { setSheetState(() { goalType = 'seasonal'; season = seasonLabel; }); }),
                  ],
                ),
                if (goalType == 'seasonal') ...[
                  const SizedBox(height: 10.0),
                  Text('Season: $seasonLabel',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.poppins(),
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                      )),
                ],
                const SizedBox(height: 16.0),
                TextField(
                  controller: controller,
                  autofocus: true,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: goalType == 'seasonal'
                        ? 'e.g. Grow 10 tomatoes this summer'
                        : 'e.g. Learn composting techniques',
                    hintStyle: TextStyle(color: FlutterFlowTheme.of(context).secondaryText),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(14.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.poppins(),
                    letterSpacing: 0.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                    onPressed: () async {
                      final text = controller.text.trim();
                      if (text.isEmpty) return;
                      Navigator.pop(ctx);
                      await UserGoalsTable().insert({
                        'user_id': currentUserUid,
                        'goal_text': text,
                        'goal_type': goalType,
                        'season': season,
                        'completed': false,
                      });
                      await _loadGoals();
                    },
                    child: Text('Add Goal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _typeChip(BuildContext ctx, StateSetter setSheetState,
      {required String label, required String value, required bool selected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: selected ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: selected ? FlutterFlowTheme.of(context).primary : FlutterFlowTheme.of(context).alternate,
          ),
        ),
        child: Text(label, style: TextStyle(
          color: selected ? Colors.white : FlutterFlowTheme.of(context).primaryText,
          fontWeight: FontWeight.w600,
          fontSize: 13.0,
        )),
      ),
    );
  }

  Widget _buildGoalsSection() {
    final completed = _goals.where((g) => g.completed).length;
    final total = _goals.length;
    final progress = total > 0 ? completed / total : 0.0;

    // Group by: initial, then seasonal by season name, then custom
    final initialGoals = _goals.where((g) => g.goalType == 'initial').toList();
    final customGoals = _goals.where((g) => g.goalType == 'custom').toList();
    final seasonalMap = <String, List<UserGoalsRow>>{};
    for (final g in _goals.where((g) => g.goalType == 'seasonal')) {
      seasonalMap.putIfAbsent(g.season ?? 'Seasonal', () => []).add(g);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Goals',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  decoration: TextDecoration.underline,
                )),
            GestureDetector(
              onTap: _showAddGoalSheet,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, color: Colors.white, size: 14.0),
                    const SizedBox(width: 4.0),
                    Text('Add Goal', style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        // Progress bar
        if (total > 0) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$completed of $total completed',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.poppins(),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                  )),
              Text('${(progress * 100).round()}%',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    color: FlutterFlowTheme.of(context).primary,
                    letterSpacing: 0.0,
                  )),
            ],
          ),
          const SizedBox(height: 6.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: FlutterFlowTheme.of(context).alternate,
              color: FlutterFlowTheme.of(context).primary,
              minHeight: 8.0,
            ),
          ),
          const SizedBox(height: 16.0),
        ],
        // Empty state
        if (total == 0)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'No goals yet. Tap "Add Goal" to get started.',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.poppins(),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
              ),
            ),
          ),
        // Initial goals
        if (initialGoals.isNotEmpty) ...[
          _sectionLabel('🌱 Initial Goals'),
          ...initialGoals.map((g) => _goalTile(g)),
          const SizedBox(height: 8.0),
        ],
        // Seasonal goals grouped by season
        ...seasonalMap.entries.map((entry) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel('🗓 ${entry.key}'),
            ...entry.value.map((g) => _goalTile(g)),
            const SizedBox(height: 8.0),
          ],
        )),
        // Custom/personal goals
        if (customGoals.isNotEmpty) ...[
          _sectionLabel('✏️ Personal Goals'),
          ...customGoals.map((g) => _goalTile(g)),
        ],
      ],
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(label,
          style: FlutterFlowTheme.of(context).bodySmall.override(
            font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            color: FlutterFlowTheme.of(context).secondaryText,
            fontSize: 11.0,
            letterSpacing: 0.5,
          )),
    );
  }

  Widget _goalTile(UserGoalsRow goal) {
    return Dismissible(
      key: Key(goal.id ?? UniqueKey().toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).error,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 20.0),
      ),
      onDismissed: (_) => _deleteGoal(goal),
      child: GestureDetector(
        onTap: () => _toggleGoal(goal),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: goal.completed
                ? FlutterFlowTheme.of(context).primaryBackground
                : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: goal.completed
                  ? FlutterFlowTheme.of(context).primary.withOpacity(0.4)
                  : FlutterFlowTheme.of(context).alternate,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: goal.completed ? FlutterFlowTheme.of(context).primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: goal.completed
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).alternate,
                    width: 2.0,
                  ),
                ),
                child: goal.completed
                    ? const Icon(Icons.check_rounded, color: Colors.white, size: 13.0)
                    : null,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  goal.goalText,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.poppins(),
                    color: goal.completed
                        ? FlutterFlowTheme.of(context).secondaryText
                        : FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                    decoration: goal.completed ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              if (goal.completed)
                Icon(Icons.emoji_events_rounded,
                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.7),
                    size: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handlePhotoUpload() async {
    final selectedMedia = await selectMediaWithSourceBottomSheet(
      context: context,
      storageFolderPath: 'profiles/$currentUserUid/',
      allowPhoto: true,
    );
    if (selectedMedia == null || selectedMedia.isEmpty) return;
    if (!selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) return;

    safeSetState(() => _isUploadingPhoto = true);
    try {
      final downloadUrls = await uploadSupabaseStorageFiles(
        bucketName: 'profile-photo',
        selectedFiles: selectedMedia,
      );
      if (downloadUrls.isNotEmpty) {
        final newUrl = downloadUrls.first;
        await ProfilesTable().update(
          data: {'profile_image_url': newUrl},
          matchingRows: (rows) => rows.eqOrNull('id', currentUserUid),
        );
        safeSetState(() {
          _localImageUrl = newUrl;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile photo updated!')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload photo: $e')),
        );
      }
    } finally {
      safeSetState(() => _isUploadingPhoto = false);
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              wrapWithModel(
                model: _model.finalHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: FinalHeaderWidget(
                  pageTitle: 'My Profile',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder<List<ProfilesRow>>(
                      future: ProfilesTable().querySingleRow(
                        queryFn: (q) => q.eqOrNull(
                          'id',
                          currentUserUid,
                        ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<ProfilesRow> containerProfilesRowList =
                            snapshot.data!;

                        final containerProfilesRow =
                            containerProfilesRowList.isNotEmpty
                                ? containerProfilesRowList.first
                                : null;

                        return Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(24.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: _handlePhotoUpload,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: 80.0,
                                                  height: 80.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                    child: () {
                                                      final imageUrl = _localImageUrl ??
                                                          containerProfilesRow
                                                              ?.profileImageUrl;
                                                      return (imageUrl != null &&
                                                              imageUrl.isNotEmpty)
                                                          ? CachedNetworkImage(
                                                              fadeInDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          0),
                                                              fadeOutDuration:
                                                                  Duration(
                                                                      milliseconds:
                                                                          0),
                                                              imageUrl: imageUrl,
                                                              width: 80.0,
                                                              height: 80.0,
                                                              fit: BoxFit.cover,
                                                              alignment:
                                                                  Alignment(
                                                                      0.0, 0.0),
                                                            )
                                                          : Container(
                                                              width: 80.0,
                                                              height: 80.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary
                                                                  .withOpacity(
                                                                      0.2),
                                                              child: Icon(
                                                                Icons
                                                                    .person_rounded,
                                                                size: 48.0,
                                                                color:
                                                                    FlutterFlowTheme
                                                                        .of(
                                                                            context)
                                                                        .primary,
                                                              ),
                                                            );
                                                    }(),
                                                  ),
                                                ),
                                                if (_isUploadingPhoto)
                                                  Positioned.fill(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                      child: Container(
                                                        color: Colors.black45,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2.0,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  Positioned(
                                                    right: -4.0,
                                                    bottom: -4.0,
                                                    child: Container(
                                                      width: 24.0,
                                                      height: 24.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons
                                                            .camera_alt_rounded,
                                                        color: Colors.white,
                                                        size: 12.0,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    containerProfilesRow
                                                        ?.fullName,
                                                    'Tap to set name',
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .headlineSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .headlineSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineSmall
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.stars_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      size: 16.0,
                                                    ),
                                                    Text(
                                                      valueOrDefault<String>(
                                                        containerProfilesRow
                                                            ?.experienceLevel,
                                                        'Gardener',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                                lineHeight: 1.4,
                                                              ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 4.0)),
                                                ),
                                                Text(
                                                  containerProfilesRow?.createdAt != null
                                                    ? 'Member since ${DateFormat('MMMM yyyy').format(containerProfilesRow!.createdAt!)}'
                                                    : 'Member Since . . .',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelSmall
                                                      .override(
                                                        font:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(context).secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.4,
                                                      ),
                                                ),
                                              ].divide(SizedBox(height: 4.0)),
                                            ),
                                          ),
                                        ].divide(SizedBox(width: 24.0)),
                                      ),
                                      Divider(
                                        height: 16.0,
                                        thickness: 3.0,
                                        indent: 0.0,
                                        endIndent: 0.0,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                    ].divide(SizedBox(height: 16.0)),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 10.0, 0.0),
                                    child: Text(
                                      'Garden Zone:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    valueOrDefault<String>(
                                      containerProfilesRow?.gardeningZone,
                                      'Zone not set',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            'Town:  ',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            containerProfilesRow?.town,
                                            'Location not set',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.poppins(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0x506F8F72),
                        borderRadius: BorderRadius.circular(24.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: _goalsLoading
                            ? Center(child: CircularProgressIndicator(strokeWidth: 2.0))
                            : _buildGoalsSection(),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        borderRadius: BorderRadius.circular(24.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'My Garden Photos',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    lineHeight: 1.4,
                                  ),
                            ),
                            SizedBox(height: 12.0),
                            Icon(
                              Icons.photo_library_outlined,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 40.0,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Your garden photos will appear here.',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: wrapWithModel(
                      model: _model.accountManagementRoundedModel,
                      updateCallback: () => safeSetState(() {}),
                      child: AccountManagementRoundedWidget(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
