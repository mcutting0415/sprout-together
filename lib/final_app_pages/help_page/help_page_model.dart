import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'help_page_widget.dart' show HelpPageWidget;
import 'package:flutter/material.dart';

class HelpPageModel extends FlutterFlowModel<HelpPageWidget> {
  late FinalHeaderModel finalHeaderModel;

  @override
  void initState(BuildContext context) {
    finalHeaderModel = createModel(context, () => FinalHeaderModel());
  }

  @override
  void dispose() {
    finalHeaderModel.maybeDispose();
  }
}
