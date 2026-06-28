import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_header2_model.dart';
export 'section_header2_model.dart';

class SectionHeader2Widget extends StatefulWidget {
  const SectionHeader2Widget({
    super.key,
    String? title,
    String? subtitle,
  })  : this.title = title ?? 'Garden Name',
        this.subtitle = subtitle ?? 'Give your green space a personality';

  final String title;
  final String subtitle;

  @override
  State<SectionHeader2Widget> createState() => _SectionHeader2WidgetState();
}

class _SectionHeader2WidgetState extends State<SectionHeader2Widget> {
  late SectionHeader2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionHeader2Model());
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget!.title,
            'Garden Name',
          ),
          style: FlutterFlowTheme.of(context).titleMedium.override(
                font: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        Text(
          valueOrDefault<String>(
            widget!.subtitle,
            'Give your green space a personality',
          ),
          style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.poppins(
                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
