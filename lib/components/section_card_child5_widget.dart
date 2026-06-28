import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_child5_model.dart';
export 'section_card_child5_model.dart';

class SectionCardChild5Widget extends StatefulWidget {
  const SectionCardChild5Widget({super.key});

  @override
  State<SectionCardChild5Widget> createState() =>
      _SectionCardChild5WidgetState();
}

class _SectionCardChild5WidgetState extends State<SectionCardChild5Widget> {
  late SectionCardChild5Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild5Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        wrapWithModel(
          model: _model.settingRowModel1,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.download_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Export Garden Data',
            subtitle: 'JSON/CSV format',
            isLast: false,
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel2,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.cloud_upload_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Backup Account',
            subtitle: 'Last sync: 2h ago',
            isLast: false,
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel3,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.restore_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Restore Data',
            subtitle: '',
            isLast: true,
          ),
        ),
      ],
    );
  }
}
