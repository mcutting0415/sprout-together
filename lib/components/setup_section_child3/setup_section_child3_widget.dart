import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setup_section_child3_model.dart';
export 'setup_section_child3_model.dart';

class SetupSectionChild3Widget extends StatefulWidget {
  const SetupSectionChild3Widget({super.key});

  @override
  State<SetupSectionChild3Widget> createState() =>
      _SetupSectionChild3WidgetState();
}

class _SetupSectionChild3WidgetState extends State<SetupSectionChild3Widget> {
  late SetupSectionChild3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SetupSectionChild3Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: FlutterFlowChoiceChips(
            options: [
              ChipData('Raised Beds'),
              ChipData('Containers'),
              ChipData('In-Ground')
            ],
            onChanged: (val) async {
              safeSetState(() => _model.choiceChipsValues = val);
              FFAppState().setupGardenTypes =
                  _model.choiceChipsValues!.toList().cast<String>();
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
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
              iconColor: FlutterFlowTheme.of(context).secondaryText,
              iconSize: 16.0,
              elevation: 10.0,
              borderColor: FlutterFlowTheme.of(context).primaryText,
              borderRadius: BorderRadius.circular(8.0),
            ),
            chipSpacing: 20.0,
            rowSpacing: 20.0,
            multiselect: true,
            initialized: _model.choiceChipsValues != null,
            alignment: WrapAlignment.center,
            controller: _model.choiceChipsValueController ??=
                FormFieldController<List<String>>(
              ['Raised Beds'],
            ),
            wrapped: true,
          ),
        ),
      ],
    );
  }
}
