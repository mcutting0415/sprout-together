import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_child6_model.dart';
export 'section_card_child6_model.dart';

class SectionCardChild6Widget extends StatefulWidget {
  const SectionCardChild6Widget({super.key});

  @override
  State<SectionCardChild6Widget> createState() =>
      _SectionCardChild6WidgetState();
}

class _SectionCardChild6WidgetState extends State<SectionCardChild6Widget> {
  late SectionCardChild6Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild6Model());
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
              Icons.help_outline_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Help Center',
            subtitle: '',
            isLast: false,
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel2,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.forum_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Frequently Asked Questions',
            subtitle: '',
            isLast: false,
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel3,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.mail_outline_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Contact Support',
            subtitle: '',
            isLast: false,
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel4,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.rate_review_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Submit Feedback',
            subtitle: '',
            isLast: true,
          ),
        ),
      ],
    );
  }
}
