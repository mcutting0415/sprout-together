import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'garden_tips_page_widget.dart' show GardenTipsPageWidget;
import 'package:flutter/material.dart';

class GardenTipsPageModel extends FlutterFlowModel<GardenTipsPageWidget> {
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
