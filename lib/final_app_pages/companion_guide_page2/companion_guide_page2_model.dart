import '/backend/supabase/supabase.dart';
import '/components/relationship_card/relationship_card_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'companion_guide_page2_widget.dart' show CompanionGuidePage2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompanionGuidePage2Model
    extends FlutterFlowModel<CompanionGuidePage2Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for FinalHeader component.
  late FinalHeaderModel finalHeaderModel;
  // Models for RelationshipCard.
  late FlutterFlowDynamicModels<RelationshipCardModel> relationshipCardModels1;
  // Models for RelationshipCard.
  late FlutterFlowDynamicModels<RelationshipCardModel> relationshipCardModels2;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    relationshipCardModels1 =
        FlutterFlowDynamicModels(() => RelationshipCardModel());
    relationshipCardModels2 =
        FlutterFlowDynamicModels(() => RelationshipCardModel());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    relationshipCardModels1.dispose();
    relationshipCardModels2.dispose();
  }
}
