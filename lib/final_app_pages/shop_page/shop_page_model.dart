import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'shop_page_widget.dart' show ShopPageWidget;
import 'package:flutter/material.dart';

class ShopPageModel extends FlutterFlowModel<ShopPageWidget> {
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
