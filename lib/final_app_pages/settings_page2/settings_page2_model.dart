import '/final_app_pages/final_header/final_header_widget.dart';
import '/components/section_card_child2_widget.dart';
import '/components/section_card_child3_widget.dart';
import '/components/section_card_child4_widget.dart';
import '/components/section_card_child5_widget.dart';
import '/components/section_card_child6_widget.dart';
import '/components/section_card_child7_widget.dart';
import '/components/section_card_child_widget.dart';
import '/components/section_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'settings_page2_widget.dart' show SettingsPage2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPage2Model extends FlutterFlowModel<SettingsPage2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for FinalHeader.
  late FinalHeaderModel finalHeaderModel;
  // Model for SectionCard.
  late SectionCardModel sectionCardModel1;
  // Model for SectionCard.
  late SectionCardModel sectionCardModel2;
  // Model for SectionCard.
  late SectionCardModel sectionCardModel3;
  // Model for SectionCard.
  late SectionCardModel sectionCardModel4;
  // Model for SectionCard.
  late SectionCardModel sectionCardModel5;
  // Model for SectionCard.
  late SectionCardModel sectionCardModel6;
  // Model for SectionCardChild7 component.
  late SectionCardChild7Model sectionCardChild7Model;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    sectionCardModel1 = createModel(context, () => SectionCardModel());
    sectionCardModel2 = createModel(context, () => SectionCardModel());
    sectionCardModel3 = createModel(context, () => SectionCardModel());
    sectionCardModel4 = createModel(context, () => SectionCardModel());
    sectionCardModel5 = createModel(context, () => SectionCardModel());
    sectionCardModel6 = createModel(context, () => SectionCardModel());
    sectionCardChild7Model =
        createModel(context, () => SectionCardChild7Model());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    sectionCardModel1.dispose();
    sectionCardModel2.dispose();
    sectionCardModel3.dispose();
    sectionCardModel4.dispose();
    sectionCardModel5.dispose();
    sectionCardModel6.dispose();
    sectionCardChild7Model.dispose();
  }
}
