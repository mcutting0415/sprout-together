import '/backend/supabase/supabase.dart';
import '/draft_pages/garden_detail_drawer/garden_detail_drawer_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'garden_card2_widget.dart' show GardenCard2Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GardenCard2Model extends FlutterFlowModel<GardenCard2Widget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<GardenPlotsRow>? selectedGardenPlotsQuery;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<PlantsRow>? drawerAllPlantsQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
