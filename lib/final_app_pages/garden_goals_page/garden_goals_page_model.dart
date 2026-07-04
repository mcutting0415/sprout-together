import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'garden_goals_page_widget.dart' show GardenGoalsPageWidget;
import 'package:flutter/material.dart';

class GardenGoalsPageModel extends FlutterFlowModel<GardenGoalsPageWidget> {
  late FinalHeaderModel finalHeaderModel;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
  }

  @override
  void dispose() {
    finalHeaderModel.dispose();
  }
}
