import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'privacy_page_toggles_model.dart';
export 'privacy_page_toggles_model.dart';

class PrivacyPageTogglesWidget extends StatefulWidget {
  const PrivacyPageTogglesWidget({super.key});

  @override
  State<PrivacyPageTogglesWidget> createState() =>
      _PrivacyPageTogglesWidgetState();
}

class _PrivacyPageTogglesWidgetState extends State<PrivacyPageTogglesWidget> {
  late PrivacyPageTogglesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivacyPageTogglesModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                child: Text(
                  'Data & Privacy Settings',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 2.0, 20.0),
              child: Material(
                color: Colors.transparent,
                child: SwitchListTile.adaptive(
                  value: _model.switchListTileValue1 ??= true,
                  onChanged: (newValue) async {
                    safeSetState(() => _model.switchListTileValue1 = newValue!);
                  },
                  title: Text(
                    'Share Analytics',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  tileColor: FlutterFlowTheme.of(context).alternate,
                  activeColor: FlutterFlowTheme.of(context).alternate,
                  activeTrackColor: FlutterFlowTheme.of(context).primary,
                  dense: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
              child: Material(
                color: Colors.transparent,
                child: SwitchListTile.adaptive(
                  value: _model.switchListTileValue2 ??= true,
                  onChanged: (newValue) async {
                    safeSetState(() => _model.switchListTileValue2 = newValue!);
                  },
                  title: Text(
                    'Personalized Recommendations',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                  tileColor: FlutterFlowTheme.of(context).alternate,
                  activeColor: FlutterFlowTheme.of(context).alternate,
                  activeTrackColor: FlutterFlowTheme.of(context).primary,
                  dense: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
