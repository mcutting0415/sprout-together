import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setup_section_child4_model.dart';
export 'setup_section_child4_model.dart';

class SetupSectionChild4Widget extends StatefulWidget {
  const SetupSectionChild4Widget({super.key});

  @override
  State<SetupSectionChild4Widget> createState() =>
      _SetupSectionChild4WidgetState();
}

class _SetupSectionChild4WidgetState extends State<SetupSectionChild4Widget> {
  late SetupSectionChild4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SetupSectionChild4Model());
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
        FlutterFlowChoiceChips(
          options: [
            ChipData('Newbie'),
            ChipData('Beginner'),
            ChipData('Intermediate'),
            ChipData('Advanced'),
            ChipData('Expert')
          ],
          onChanged: (val) async {
            safeSetState(() => _model.choiceChipsValue = val?.firstOrNull);
            FFAppState().setupExperienceLevel = _model.choiceChipsValue!;
            safeSetState(() {});
          },
          selectedChipStyle: ChipStyle(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).info,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
            iconColor: FlutterFlowTheme.of(context).info,
            iconSize: 16.0,
            elevation: 10.0,
            borderColor: FlutterFlowTheme.of(context).primaryText,
            borderRadius: BorderRadius.circular(16.0),
          ),
          unselectedChipStyle: ChipStyle(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
            iconColor: FlutterFlowTheme.of(context).secondaryText,
            iconSize: 16.0,
            elevation: 0.0,
            borderColor: FlutterFlowTheme.of(context).primaryText,
            borderRadius: BorderRadius.circular(16.0),
          ),
          chipSpacing: 8.0,
          rowSpacing: 8.0,
          multiselect: false,
          alignment: WrapAlignment.center,
          controller: _model.choiceChipsValueController ??=
              FormFieldController<List<String>>(
            [],
          ),
          wrapped: true,
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
