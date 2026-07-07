import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  // Persisted toggle values — loaded from SharedPreferences
  bool _watering = true;
  bool _planting = true;
  bool _harvest = true;
  bool _frost = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild2Model());
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    safeSetState(() {
      _watering = prefs.getBool('pref_watering_reminders') ?? true;
      _planting = prefs.getBool('pref_planting_reminders') ?? true;
      _harvest  = prefs.getBool('pref_harvest_reminders')  ?? true;
      _frost    = prefs.getBool('pref_frost_reminders')    ?? true;
    });
  }

  Future<void> _savePref(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
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
              value: _watering,
              onChanged: (newValue) async {
                safeSetState(() => _watering = newValue!);
                await _savePref('pref_watering_reminders', newValue!);
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
              value: _planting,
              onChanged: (newValue) async {
                safeSetState(() => _planting = newValue!);
                await _savePref('pref_planting_reminders', newValue!);
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
              value: _harvest,
              onChanged: (newValue) async {
                safeSetState(() => _harvest = newValue!);
                await _savePref('pref_harvest_reminders', newValue!);
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
              value: _frost,
              onChanged: (newValue) async {
                safeSetState(() => _frost = newValue!);
                await _savePref('pref_frost_reminders', newValue!);
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
