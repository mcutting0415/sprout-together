import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'legal_section_widget.dart' show LegalSectionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LegalSectionModel extends FlutterFlowModel<LegalSectionWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for SettingRow.
  late SettingRowModel settingRowModel;

  @override
  void initState(BuildContext context) {
    settingRowModel = createModel(context, () => SettingRowModel());
  }

  @override
  void dispose() {
    settingRowModel.dispose();
  }
}
