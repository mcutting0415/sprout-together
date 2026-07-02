import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/journal_entry/journal_entry_widget.dart';
import '/components/stat_pill/stat_pill_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'garden_journal_page2_model.dart';
export 'garden_journal_page2_model.dart';

/// Create an alternative version of my Garden Journal page for
/// SproutTogether.
///
/// Goal:
/// Create a gardening journal where users can document their garden's
/// progress throughout the growing season.
///
/// Use the existing SproutTogether theme, colors, typography, spacing, and
/// design style.
///
/// Requirements:
///
/// Page Header:
///
/// * Garden Journal
///
/// Quick Actions:
///
/// * New Journal Entry button
/// * Add Photo button
///
/// Journal Timeline Section:
///
/// * Display journal entries in reverse chronological order
/// * Show date for each entry
/// * Show photo thumbnail if available
/// * Show entry title
/// * Show notes preview
///
/// Entry Card Layout:
///
/// * Photo
/// * Date
/// * Garden Name
/// * Notes Preview
/// * View Entry button
///
/// Filter Options:
///
/// * All Entries
/// * By Garden
/// * By Plant
/// * By Month
///
/// Statistics Section:
///
/// * Total Entries
/// * Photos Added
/// * Gardens Tracked
///
/// Design Goals:
///
/// * Feel like a gardening scrapbook.
/// * Clean and modern.
/// * Easy to browse.
/// * Friendly and encouraging.
/// * Mobile-friendly.
/// * Use cards and timeline-style layouts.
/// * Plenty of spacing.
///
/// Do not add functionality, database actions, or navigation.
/// Focus only on page structure and visual design.
class GardenJournalPage2Widget extends StatefulWidget {
  const GardenJournalPage2Widget({super.key});

  static String routeName = 'GardenJournalPage2';
  static String routePath = '/gardenJournalPage2';

  @override
  State<GardenJournalPage2Widget> createState() =>
      _GardenJournalPage2WidgetState();
}

class _GardenJournalPage2WidgetState extends State<GardenJournalPage2Widget> {
  late GardenJournalPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<GardenJournalEntriesRow> _entries = [];
  Map<String, String> _gardenNames = {};
  bool _isLoading = true;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenJournalPage2Model());
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
  }

  Future<void> _loadData() async {
    final entries = await GardenJournalEntriesTable().queryRows(
      queryFn: (q) => q
          .eqOrNull('user_id', currentUserUid)
          .order('entry_date', ascending: false),
    );
    final gardens = await GardensTable().queryRows(
      queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
    );
    final names = <String, String>{};
    for (final g in gardens) {
      if (g.id != null) names[g.id!] = g.gardenName ?? 'Garden';
    }
    if (mounted) {
      safeSetState(() {
        _entries = entries;
        _gardenNames = names;
        _isLoading = false;
      });
    }
  }

  List<GardenJournalEntriesRow> get _filteredEntries {
    switch (_selectedFilter) {
      case 'By Garden':
        return _entries.where((e) => e.gardenId != null).toList();
      case 'By Plant':
        return _entries.where((e) => e.plantId != null).toList();
      case 'By Month':
        final now = DateTime.now();
        return _entries
            .where((e) =>
                e.entryDate != null &&
                e.entryDate!.month == now.month &&
                e.entryDate!.year == now.year)
            .toList();
      default:
        return _entries;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMMM dd, yyyy').format(date);
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
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    wrapWithModel(
                      model: _model.finalHeaderModel,
                      updateCallback: () => safeSetState(() {}),
                      child: FinalHeaderWidget(
                        pageTitle: 'Garden Journal',
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 16.0),
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.statPillModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatPillWidget(
                                      icon: Icon(
                                        Icons.auto_stories_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 16.0,
                                      ),
                                      value: _isLoading
                                          ? '–'
                                          : _entries.length.toString(),
                                      label: 'Entries',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.statPillModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatPillWidget(
                                      icon: Icon(
                                        Icons.image_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 16.0,
                                      ),
                                      value: _isLoading
                                          ? '–'
                                          : _entries
                                              .where((e) =>
                                                  e.imageUrl != null &&
                                                  e.imageUrl!.isNotEmpty)
                                              .length
                                              .toString(),
                                      label: 'Photos',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.statPillModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatPillWidget(
                                      icon: Icon(
                                        Icons.local_florist_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 16.0,
                                      ),
                                      value: _isLoading
                                          ? '–'
                                          : _entries
                                              .map((e) => e.gardenId)
                                              .whereType<String>()
                                              .toSet()
                                              .length
                                              .toString(),
                                      label: 'Gardens',
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 16.0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              'All',
                              'By Garden',
                              'By Plant',
                              'By Month',
                            ].map((filter) {
                              final isSelected = _selectedFilter == filter;
                              return GestureDetector(
                                onTap: () => safeSetState(
                                    () => _selectedFilter = filter),
                                child: Container(
                                  height: 34.0,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1.0,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 12.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (isSelected)
                                          Icon(Icons.check_rounded,
                                              color: Colors.white, size: 16.0),
                                        Text(
                                          filter == 'All'
                                              ? 'All Entries'
                                              : filter,
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.poppins(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color: isSelected
                                                    ? Colors.white
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                      ].divide(SizedBox(width: 6.0)),
                                    ),
                                  ),
                                ),
                              );
                            }).toList().divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_isLoading)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      )
                    else if (_filteredEntries.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Column(
                          children: [
                            Icon(Icons.book_outlined,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 48.0),
                            SizedBox(height: 16.0),
                            Text(
                              _selectedFilter == 'All'
                                  ? 'No journal entries yet'
                                  : 'No entries for $_selectedFilter',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Start documenting your garden\'s journey!',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    else
                      ..._filteredEntries.map((entry) => JournalEntryWidget(
                            key: ValueKey(entry.id),
                            imgDesc: (entry.imageUrl != null &&
                                    entry.imageUrl!.isNotEmpty)
                                ? entry.imageUrl!
                                : 'https://dimg.dreamflow.cloud/v1/image/garden%20journal%20entry',
                            date: _formatDate(entry.entryDate ?? entry.createdAt),
                            garden: entry.gardenId != null
                                ? (_gardenNames[entry.gardenId!] ?? 'Garden')
                                : 'General',
                            title: entry.title ?? 'Journal Entry',
                            preview: entry.entryText ?? '',
                          )),
                  ],
                ),
              ),
              if (!_isLoading)
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.eco_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 32.0,
                      ),
                      Text(
                        _entries.isEmpty
                            ? 'Start your journal'
                            : 'You\'re all caught up!',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight:
                                  FlutterFlowTheme.of(context).labelLarge.fontWeight,
                              fontStyle:
                                  FlutterFlowTheme.of(context).labelLarge.fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
