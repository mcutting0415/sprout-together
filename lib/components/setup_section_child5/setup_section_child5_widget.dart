import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setup_section_child5_model.dart';
export 'setup_section_child5_model.dart';

class SetupSectionChild5Widget extends StatefulWidget {
  const SetupSectionChild5Widget({super.key});

  @override
  State<SetupSectionChild5Widget> createState() =>
      _SetupSectionChild5WidgetState();
}

class _SetupSectionChild5WidgetState extends State<SetupSectionChild5Widget> {
  late SetupSectionChild5Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SetupSectionChild5Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
              ),
              child: CheckboxListTile(
                value: _model.checkboxListTileValue1 ??= false,
                onChanged: (newValue) async {
                  safeSetState(() => _model.checkboxListTileValue1 = newValue!);
                  if (newValue!) {
                    FFAppState().addToSetupGoals('Grow Food');
                    safeSetState(() {});
                  } else {
                    FFAppState().removeFromSetupGoals('Grow Food');
                    safeSetState(() {});
                  }
                },
                title: Text(
                  'Grow Food',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
              ),
              child: CheckboxListTile(
                value: _model.checkboxListTileValue2 ??= false,
                onChanged: (newValue) async {
                  safeSetState(() => _model.checkboxListTileValue2 = newValue!);
                  if (newValue!) {
                    FFAppState().addToSetupGoals('Beautify Home');
                    safeSetState(() {});
                  } else {
                    FFAppState().removeFromSetupGoals('Beautify Home');
                    safeSetState(() {});
                  }
                },
                title: Text(
                  'Beautify Home',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
              ),
              child: CheckboxListTile(
                value: _model.checkboxListTileValue3 ??= false,
                onChanged: (newValue) async {
                  safeSetState(() => _model.checkboxListTileValue3 = newValue!);
                  if (newValue!) {
                    FFAppState().addToSetupGoals('Save Money');
                    safeSetState(() {});
                  } else {
                    FFAppState().removeFromSetupGoals('Save Money');
                    safeSetState(() {});
                  }
                },
                title: Text(
                  'Save Money',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
              ),
              child: CheckboxListTile(
                value: _model.checkboxListTileValue4 ??= false,
                onChanged: (newValue) async {
                  safeSetState(() => _model.checkboxListTileValue4 = newValue!);
                  if (newValue!) {
                    FFAppState().addToSetupGoals('Pollinator Friendly');
                    safeSetState(() {});
                  } else {
                    FFAppState().removeFromSetupGoals('Pollinator Friendly');
                    safeSetState(() {});
                  }
                },
                title: Text(
                  'Pollinator Friendly',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
              ),
              child: CheckboxListTile(
                value: _model.checkboxListTileValue5 ??= false,
                onChanged: (newValue) async {
                  safeSetState(() => _model.checkboxListTileValue5 = newValue!);
                  if (newValue!) {
                    FFAppState().addToSetupGoals('Stress Relief');
                    safeSetState(() {});
                  } else {
                    FFAppState().removeFromSetupGoals('Stress Relief');
                    safeSetState(() {});
                  }
                },
                title: Text(
                  'Stress Relief',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
              ),
              child: CheckboxListTile(
                value: _model.checkboxListTileValue6 ??= false,
                onChanged: (newValue) async {
                  safeSetState(() => _model.checkboxListTileValue6 = newValue!);
                  if (newValue!) {
                    FFAppState().addToSetupGoals('Fun');
                    safeSetState(() {});
                  } else {
                    FFAppState().removeFromSetupGoals('Fun');
                    safeSetState(() {});
                  }
                },
                title: Text(
                  'Fun',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                ),
                tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                activeColor: FlutterFlowTheme.of(context).primary,
                checkColor: FlutterFlowTheme.of(context).info,
                dense: false,
                controlAffinity: ListTileControlAffinity.trailing,
                contentPadding:
                    EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
