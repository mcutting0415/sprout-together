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

// Helper to show the "add entry" bottom sheet (public so other pages can invoke it)
Future<void> showAddJournalEntrySheet(BuildContext context, VoidCallback onSaved) async {
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
              child: SingleChildScrollView(
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
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
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
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
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
                                          bucketName: 'garden-photos',
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

class GardenJournalPage2Widget extends StatefulWidget {
  const GardenJournalPage2Widget({
    super.key,
    this.fromInsights = false,
  });

  /// When true, a back button is shown so the user can return to
  /// the garden insights page they came from.
  final bool fromInsights;

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

  /// Opens a view/edit sheet for an existing journal entry.
  Future<void> _showViewEditSheet(GardenJournalEntriesRow entry) async {
    bool isEditing = false;
    bool isSaving = false;
    final titleController = TextEditingController(text: entry.title ?? '');
    final notesController = TextEditingController(text: entry.entryText ?? '');

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(builder: (ctx, setModalState) {
        return Padding(
          padding: MediaQuery.viewInsetsOf(ctx),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(ctx).secondaryBackground,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag handle
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
                    const SizedBox(height: 16.0),
                    // Header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            isEditing ? 'Edit Entry' : 'Journal Entry',
                            style: FlutterFlowTheme.of(ctx).titleLarge.override(
                                  font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        if (!isEditing)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton.icon(
                                onPressed: () =>
                                    setModalState(() => isEditing = true),
                                icon: Icon(Icons.edit_rounded,
                                    size: 16.0,
                                    color: FlutterFlowTheme.of(ctx).primary),
                                label: Text('Edit',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: FlutterFlowTheme.of(ctx).primary,
                                      fontSize: 13.0,
                                    )),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: ctx,
                                    builder: (dialogCtx) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      title: Text('Delete Entry?',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold)),
                                      content: Text(
                                          'This will permanently remove this journal entry.',
                                          style: GoogleFonts.poppins(
                                              fontSize: 14.0)),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(dialogCtx, false),
                                          child: Text('Cancel',
                                              style: GoogleFonts.poppins(
                                                  color: FlutterFlowTheme.of(
                                                          ctx)
                                                      .secondaryText)),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                FlutterFlowTheme.of(ctx).error,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(dialogCtx, true),
                                          child: Text('Delete',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirm == true && entry.id != null) {
                                    try {
                                      await GardenJournalEntriesTable().delete(
                                        matchingRows: (q) =>
                                            q.eqOrNull('id', entry.id),
                                      );
                                      Navigator.pop(ctx);
                                      _loadData();
                                    } catch (_) {}
                                  }
                                },
                                icon: Icon(Icons.delete_outline_rounded,
                                    color: FlutterFlowTheme.of(ctx).error,
                                    size: 20.0),
                                tooltip: 'Delete entry',
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    // Date + garden badge
                    Row(
                      children: [
                        Text(
                          _formatDate(entry.entryDate ?? entry.createdAt),
                          style: FlutterFlowTheme.of(ctx).labelSmall.override(
                                font: GoogleFonts.poppins(),
                                color: FlutterFlowTheme.of(ctx).secondaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        if (entry.gardenId != null) ...[
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(ctx).primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              _gardenNames[entry.gardenId!] ?? 'Garden',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                                color: FlutterFlowTheme.of(ctx).primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    // Photo (if any)
                    if (entry.imageUrl != null && entry.imageUrl!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            entry.imageUrl!,
                            width: double.infinity,
                            height: 180.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // Title
                    if (isEditing)
                      TextFormField(
                        controller: titleController,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: 'Title',
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
                              font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                              letterSpacing: 0.0,
                            ),
                      )
                    else
                      Text(
                        entry.title ?? 'Untitled Entry',
                        style: FlutterFlowTheme.of(ctx).titleMedium.override(
                              font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    const SizedBox(height: 12.0),
                    // Notes
                    if (isEditing)
                      TextFormField(
                        controller: notesController,
                        maxLines: 6,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: 'Notes',
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
                              font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(ctx).bodyMedium.fontWeight),
                              letterSpacing: 0.0,
                            ),
                      )
                    else if ((entry.entryText ?? '').isNotEmpty)
                      Text(
                        entry.entryText!,
                        style: FlutterFlowTheme.of(ctx).bodyMedium.override(
                              font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(ctx).bodyMedium.fontWeight),
                              color: FlutterFlowTheme.of(ctx).primaryText,
                              letterSpacing: 0.0,
                              lineHeight: 1.6,
                            ),
                      ),
                    const SizedBox(height: 24.0),
                    // Action buttons
                    if (isEditing)
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => setModalState(() => isEditing = false),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: FlutterFlowTheme.of(ctx).alternate),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                padding: const EdgeInsets.symmetric(vertical: 14.0),
                              ),
                              child: Text('Cancel',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: FlutterFlowTheme.of(ctx).secondaryText,
                                  )),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isSaving
                                  ? null
                                  : () async {
                                      final newTitle = titleController.text.trim();
                                      if (newTitle.isEmpty) return;
                                      setModalState(() => isSaving = true);
                                      try {
                                        await GardenJournalEntriesTable().update(
                                          data: {
                                            'title': newTitle,
                                            'entry_text': notesController.text.trim(),
                                          },
                                          matchingRows: (q) => q.eqOrNull('id', entry.id),
                                        );
                                        Navigator.pop(ctx);
                                        _loadData();
                                      } catch (_) {
                                        setModalState(() => isSaving = false);
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: FlutterFlowTheme.of(ctx).primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                padding: const EdgeInsets.symmetric(vertical: 14.0),
                              ),
                              child: isSaving
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                    )
                                  : Text('Save Changes',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                            ),
                          ),
                        ],
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: FlutterFlowTheme.of(ctx).primary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                          ),
                          child: Text('Done',
                              style: FlutterFlowTheme.of(ctx).titleSmall.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                    color: FlutterFlowTheme.of(ctx).primary,
                                    letterSpacing: 0.0,
                                  )),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
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
          onPressed: () => showAddJournalEntrySheet(context, () {
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
                        // Only show back button when coming from garden insights
                        backAction: widget.fromInsights ? () => context.pop() : null,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: wrapWithModel(
                                  model: _model.statPillModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: StatPillWidget(
                                    icon: Icon(
                                      Icons.auto_stories_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      size: 14.0,
                                    ),
                                    value: _isLoading
                                        ? '–'
                                        : _entries.length.toString(),
                                    label: 'Entries',
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: wrapWithModel(
                                  model: _model.statPillModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: StatPillWidget(
                                    icon: Icon(
                                      Icons.image_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      size: 14.0,
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
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: wrapWithModel(
                                  model: _model.statPillModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: StatPillWidget(
                                    icon: Icon(
                                      Icons.local_florist_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primary,
                                      size: 14.0,
                                    ),
                                    value: _isLoading
                                        ? '–'
                                        : _gardenNames.length.toString(),
                                    label: 'Gardens',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Filter chips — Row with Expanded so they fit evenly, no scrolling
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 8.0),
                      child: Row(
                        children: [
                          'All',
                          'By Garden',
                          'By Plant',
                          'By Month',
                        ].map((filter) {
                          final isSelected = _selectedFilter == filter;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => safeSetState(
                                  () => _selectedFilter = filter),
                              child: Container(
                                height: 34.0,
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
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
                                child: Text(
                                  filter == 'All' ? 'All' : filter.split(' ').last,
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .fontWeight,
                                        ),
                                        color: isSelected
                                            ? Colors.white
                                            : FlutterFlowTheme.of(context)
                                                .primaryText,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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
                      ..._filteredEntries.map((entry) => GestureDetector(
                            onTap: () => _showViewEditSheet(entry),
                            child: JournalEntryWidget(
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
                            ),
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
