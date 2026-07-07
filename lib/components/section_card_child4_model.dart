import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'section_card_child4_widget.dart' show SectionCardChild4Widget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SectionCardChild4Model extends FlutterFlowModel<SectionCardChild4Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for SettingRow.
  late SettingRowModel settingRowModel1;
  // Model for SettingRow.
  late SettingRowModel settingRowModel3;
  // Model for SettingRow.
  late SettingRowModel settingRowModel4;

  @override
  void initState(BuildContext context) {
    settingRowModel1 = createModel(context, () => SettingRowModel());
    settingRowModel3 = createModel(context, () => SettingRowModel());
    settingRowModel4 = createModel(context, () => SettingRowModel());
  }

  @override
  void dispose() {
    settingRowModel1.dispose();
    settingRowModel3.dispose();
    settingRowModel4.dispose();
  }
}
