import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'tools_page_widget.dart' show ToolsPageWidget;
import 'package:flutter/material.dart';

class ToolsPageModel extends FlutterFlowModel<ToolsPageWidget> {
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
