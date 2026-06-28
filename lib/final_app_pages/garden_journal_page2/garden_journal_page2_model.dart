import '/components/journal_entry/journal_entry_widget.dart';
import '/components/stat_pill/stat_pill_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'garden_journal_page2_widget.dart' show GardenJournalPage2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GardenJournalPage2Model
    extends FlutterFlowModel<GardenJournalPage2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for FinalHeader component.
  late FinalHeaderModel finalHeaderModel;
  // Model for StatPill.
  late StatPillModel statPillModel1;
  // Model for StatPill.
  late StatPillModel statPillModel2;
  // Model for StatPill.
  late StatPillModel statPillModel3;
  // Model for JournalEntry.
  late JournalEntryModel journalEntryModel1;
  // Model for JournalEntry.
  late JournalEntryModel journalEntryModel2;
  // Model for JournalEntry.
  late JournalEntryModel journalEntryModel3;
  // Model for JournalEntry.
  late JournalEntryModel journalEntryModel4;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    statPillModel1 = createModel(context, () => StatPillModel());
    statPillModel2 = createModel(context, () => StatPillModel());
    statPillModel3 = createModel(context, () => StatPillModel());
    journalEntryModel1 = createModel(context, () => JournalEntryModel());
    journalEntryModel2 = createModel(context, () => JournalEntryModel());
    journalEntryModel3 = createModel(context, () => JournalEntryModel());
    journalEntryModel4 = createModel(context, () => JournalEntryModel());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    statPillModel1.dispose();
    statPillModel2.dispose();
    statPillModel3.dispose();
    journalEntryModel1.dispose();
    journalEntryModel2.dispose();
    journalEntryModel3.dispose();
    journalEntryModel4.dispose();
  }
}
