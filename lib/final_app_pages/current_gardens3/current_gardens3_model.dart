import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/garden_card2/garden_card2_widget.dart';
import '/components/insight_item/insight_item_widget.dart';
import '/draft_pages/garden_detail_drawer/garden_detail_drawer_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'current_gardens3_widget.dart' show CurrentGardens3Widget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CurrentGardens3Model extends FlutterFlowModel<CurrentGardens3Widget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in CurrentGardens3 widget.
  List<GardensRow>? currentGardensQuery;
  // Model for FinalHeader component.
  late FinalHeaderModel finalHeaderModel;
  // Models for GardenCard.
  late FlutterFlowDynamicModels<GardenCard2Model> gardenCardModels1;
  // Models for GardenCard.
  late FlutterFlowDynamicModels<GardenCard2Model> gardenCardModels2;
  // Model for InsightItem.
  late InsightItemModel insightItemModel1;
  // Model for InsightItem.
  late InsightItemModel insightItemModel2;
  // Model for InsightItem.
  late InsightItemModel insightItemModel3;
  // Model for gardenDetailDrawer component.
  late GardenDetailDrawerModel gardenDetailDrawerModel;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    gardenCardModels1 = FlutterFlowDynamicModels(() => GardenCard2Model());
    gardenCardModels2 = FlutterFlowDynamicModels(() => GardenCard2Model());
    insightItemModel1 = createModel(context, () => InsightItemModel());
    insightItemModel2 = createModel(context, () => InsightItemModel());
    insightItemModel3 = createModel(context, () => InsightItemModel());
    gardenDetailDrawerModel =
        createModel(context, () => GardenDetailDrawerModel());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    gardenCardModels1.dispose();
    gardenCardModels2.dispose();
    insightItemModel1.dispose();
    insightItemModel2.dispose();
    insightItemModel3.dispose();
    gardenDetailDrawerModel.dispose();
  }
}
