import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_child4_model.dart';
export 'section_card_child4_model.dart';

class SectionCardChild4Widget extends StatefulWidget {
  const SectionCardChild4Widget({super.key});

  @override
  State<SectionCardChild4Widget> createState() =>
      _SectionCardChild4WidgetState();
}

class _SectionCardChild4WidgetState extends State<SectionCardChild4Widget> {
  late SectionCardChild4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild4Model());
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
              Icons.grid_view_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Current Gardens',
            subtitle: 'View and manage active gardens',
            isLast: false,
            onTap: () => context.pushNamed(CurrentGardens3Widget.routeName),
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel2,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.archive_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Past Gardens',
            subtitle: 'Browse previous seasons',
            isLast: false,
            onTap: () => context.pushNamed(PreviousGardensPage2Widget.routeName),
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel3,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Garden Templates',
            subtitle: 'Coming soon',
            isLast: true,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Garden Templates coming soon!')),
            ),
          ),
        ),
      ],
    );
  }
}
