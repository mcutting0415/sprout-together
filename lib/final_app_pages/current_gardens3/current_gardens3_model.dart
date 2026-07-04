import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'current_gardens3_widget.dart' show CurrentGardens3Widget;
import 'package:flutter/material.dart';

class CurrentGardens3Model extends FlutterFlowModel<CurrentGardens3Widget> {
  // Model for FinalHeader component.
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
