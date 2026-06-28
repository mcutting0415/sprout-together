import '/backend/supabase/supabase.dart';
import '/components/plot_square/plot_square_widget.dart';
import '/draft_pages/side_menu/side_menu_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'garden_builder_page_widget.dart' show GardenBuilderPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GardenBuilderPageModel extends FlutterFlowModel<GardenBuilderPageWidget> {
  ///  Local state fields for this page.

  String? selectedPlant;

  int selectedSquare = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in GardenBuilderPage widget.
  List<GardenPlotsRow>? gardenPlotQuery;
  // Model for FinalHeader component.
  late FinalHeaderModel finalHeaderModel;
  // Models for PlotSquare dynamic component.
  late FlutterFlowDynamicModels<PlotSquareModel> plotSquareModels;
  // Model for SideMenu component.
  late SideMenuModel sideMenuModel;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
    plotSquareModels = FlutterFlowDynamicModels(() => PlotSquareModel());
    sideMenuModel = createModel(context, () => SideMenuModel());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
    plotSquareModels.dispose();
    sideMenuModel.dispose();
  }
}
