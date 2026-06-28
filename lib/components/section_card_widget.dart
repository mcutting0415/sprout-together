import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_model.dart';
export 'section_card_model.dart';

class SectionCardWidget extends StatefulWidget {
  const SectionCardWidget({
    super.key,
    String? title,
    this.child,
  }) : this.title = title ?? 'Account';

  final String title;
  final Widget Function()? child;

  @override
  State<SectionCardWidget> createState() => _SectionCardWidgetState();
}

class _SectionCardWidgetState extends State<SectionCardWidget> {
  late SectionCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardModel());
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
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
          child: Container(
            child: Text(
              valueOrDefault<String>(
                widget!.title,
                'Account',
              ),
              style: FlutterFlowTheme.of(context).labelLarge.override(
                    font: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelLarge.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Color(0x1A000000),
                  offset: Offset(
                    1.0,
                    1.0,
                  ),
                  spreadRadius: 0.0,
                )
              ],
              borderRadius: BorderRadius.circular(40.0),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: FlutterFlowTheme.of(context).secondaryText,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
              child: Container(
                child: Builder(builder: (_) {
                  return widget.child != null
                      ? widget.child!()
                      : SizedBox.shrink();
                }),
              ),
            ),
          ),
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
