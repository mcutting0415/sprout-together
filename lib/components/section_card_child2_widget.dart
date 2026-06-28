import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_child2_model.dart';
export 'section_card_child2_model.dart';

class SectionCardChild2Widget extends StatefulWidget {
  const SectionCardChild2Widget({super.key});

  @override
  State<SectionCardChild2Widget> createState() =>
      _SectionCardChild2WidgetState();
}

class _SectionCardChild2WidgetState extends State<SectionCardChild2Widget> {
  late SectionCardChild2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild2Model());
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
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: SwitchListTile.adaptive(
              value: _model.switchListTileValue1 ??= true,
              onChanged: (newValue) async {
                safeSetState(() => _model.switchListTileValue1 = newValue!);
              },
              title: Text(
                'Watering Reminders',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
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
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: SwitchListTile.adaptive(
              value: _model.switchListTileValue2 ??= true,
              onChanged: (newValue) async {
                safeSetState(() => _model.switchListTileValue2 = newValue!);
              },
              title: Text(
                'Planting Reminders',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
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
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: SwitchListTile.adaptive(
              value: _model.switchListTileValue3 ??= true,
              onChanged: (newValue) async {
                safeSetState(() => _model.switchListTileValue3 = newValue!);
              },
              title: Text(
                'Harvest Reminders',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
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
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
          child: Material(
            color: Colors.transparent,
            child: SwitchListTile.adaptive(
              value: _model.switchListTileValue4 ??= true,
              onChanged: (newValue) async {
                safeSetState(() => _model.switchListTileValue4 = newValue!);
              },
              title: Text(
                'Frost\nReminders',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleLarge.fontWeight,
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
    );
  }
}
