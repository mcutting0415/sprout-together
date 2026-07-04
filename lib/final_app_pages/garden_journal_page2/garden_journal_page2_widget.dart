import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/backend/supabase/storage/storage.dart';
import '/components/journal_entry/journal_entry_widget.dart';
import '/components/stat_pill/stat_pill_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'garden_journal_page2_model.dart';
export 'garden_journal_page2_model.dart';

// Helper to show the "add entry" bottom sheet
Future<void> _showAddEntrySheet(BuildContext context, VoidCallback onSaved) async {
  final titleController = TextEditingController();
  final notesController = TextEditingController();
  String? selectedGardenId;
  List<GardensRow> gardens = [];
  bool isSaving = false;
  SelectedFile? selectedImage;

  try {
    gardens = await GardensTable().queryRows(
      queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
    );
  } catch (_) {}

  if (!context.mounted) return;

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return StatefulBuilder(builder: (ctx, setModalState) {
        return Padding(
          padding: MediaQuery.viewInsetsOf(ctx),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(ctx).secondaryBackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(ctx).alternate,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'New Journal Entry',
                      style: FlutterFlowTheme.of(ctx).titleLarge.override(
                            font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(height: 20.0),
                    // Photo picker
                    GestureDetector(
                      onTap: () async {
                        final file = await selectMediaWithSourceBottomSheet(
                          context: ctx,
                          maxWidth: 1200,
                          maxHeight: 1200,
                          imageQuality: 85,
                          allowPhoto: true,
                        );
                        if (file != null && file.isNotEmpty) setModalState(() => selectedImage = file.first);
                      },
                      child: Container(
                        width: double.infinity,
                        height: selectedImage != null ? 140.0 : 60.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(ctx).primaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(ctx).alternate,
                            width: 1.5,
                          ),
                        ),
                        child: selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(11.0),
                                child: Image.memory(
                                  selectedImage!.bytes,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_photo_alternate_outlined,
                                      color: FlutterFlowTheme.of(ctx).primary, size: 22.0),
                                  SizedBox(width: 8.0),
                                  Text(
                                    'Add Photo (optional)',
                                    style: FlutterFlowTheme.of(ctx).labelMedium.override(
                                          font: GoogleFonts.poppins(
                                              fontWeight: FlutterFlowTheme.of(ctx).labelMedium.fontWeight),
                                          color: FlutterFlowTheme.of(ctx).primary,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    // Title field
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Entry Title',
                        hintText: 'e.g. First tomatoes sprouting!',
                        filled: true,
                        fillColor: FlutterFlowTheme.of(ctx).primaryBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).alternate),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).alternate),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).primary, width: 2.0),
                        ),
                      ),
                      style: FlutterFlowTheme.of(ctx).bodyMedium.override(
                            font: GoogleFonts.poppins(fontWeight: FlutterFlowTheme.of(ctx).bodyMedium.fontWeight),
                            letterSpacing: 0.0,
                          ),
                    ),
                    SizedBox(height: 12.0),
                    // Garden picker
                    if (gardens.isNotEmpty)
                      DropdownButtonFormField<String>(
                        value: selectedGardenId,
                        hint: Text('Select a garden (optional)',
                            style: FlutterFlowTheme.of(ctx).labelMedium),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: FlutterFlowTheme.of(ctx).primaryBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).alternate),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).alternate),
                          ),
                        ),
                        items: gardens
                            .where((g) => g.id != null)
                            .map((g) => DropdownMenuItem(
                                  value: g.id,
                                  child: Text(g.gardenName ?? 'Garden'),
                                ))
                            .toList(),
                        onChanged: (val) => setModalState(() => selectedGardenId = val),
                      ),
                    if (gardens.isNotEmpty) SizedBox(height: 12.0),
                    // Notes field
                    TextFormField(
                      controller: notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Notes',
                        hintText: 'What did you notice today?',
                        alignLabelWithHint: true,
                        filled: true,
                        fillColor: FlutterFlowTheme.of(ctx).primaryBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).alternate),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).alternate),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(ctx).primary, width: 2.0),
                        ),
                      ),
                      style: FlutterFlowTheme.of(ctx).bodyMedium.override(
                            font: GoogleFonts.poppins(fontWeight: FlutterFlowTheme.of(ctx).bodyMedium.fontWeight),
                            letterSpacing: 0.0,
                          ),
                    ),
                    SizedBox(height: 24.0),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(ctx),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: FlutterFlowTheme.of(ctx).primary),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                            ),
                            child: Text('Cancel',
                                style: FlutterFlowTheme.of(ctx).titleSmall.override(
                                      font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                      color: FlutterFlowTheme.of(ctx).primary,
                                      letterSpacing: 0.0,
                                    )),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isSaving
                                ? null
                                : () async {
                                    final title = titleController.text.trim();
                                    if (title.isEmpty) return;
                                    setModalState(() => isSaving = true);
                                    try {
                                      String? imageUrl;
                                      if (selectedImage != null) {
                                        final ext = selectedImage!.storagePath.split('.').last.toLowerCase();
                                        final uploadFile = SelectedFile(
                                          storagePath: 'journal/$currentUserUid/${DateTime.now().millisecondsSinceEpoch}.$ext',
                                          bytes: selectedImage!.bytes,
                                        );
                                        imageUrl = await uploadSupabaseStorageFile(
                                          bucketName: 'profile-photo',
                                          selectedFile: uploadFile,
                                        );
                                      }
                                      await GardenJournalEntriesTable().insert({
                                        'user_id': currentUserUid,
                                        'title': title,
                                        'entry_text': notesController.text.trim(),
                                        'garden_id': selectedGardenId,
                                        'entry_date': DateTime.now().toIso8601String(),
                                        if (imageUrl != null) 'image_url': imageUrl,
                                      });
                                      Navigator.pop(ctx);
                                      onSaved();
                                    } catch (e) {
                                      setModalState(() => isSaving = false);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Could not save entry: $e')),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: FlutterFlowTheme.of(ctx).primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                            ),
                            child: isSaving
                                ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : Text('Save Entry',
                                    style: FlutterFlowTheme.of(ctx).titleSmall.override(
                                          font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        )),
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
      });
    },
  );
}

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddEntrySheet(context, () {
            _loadData(); // refresh after save
          }),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          icon: Icon(Icons.edit_rounded, color: Colors.white),
          label: Text(
            'New Entry',
            style: FlutterFlowTheme.of(context).titleSmall.override(
                  font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  color: Colors.white,
                  letterSpacing: 0.0,
                ),
          ),
        ),
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
                                : '',
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
                  padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 100.0),
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
