import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setup_section_child2_model.dart';
export 'setup_section_child2_model.dart';

class SetupSectionChild2Widget extends StatefulWidget {
  const SetupSectionChild2Widget({super.key});

  @override
  State<SetupSectionChild2Widget> createState() =>
      _SetupSectionChild2WidgetState();
}

class _SetupSectionChild2WidgetState extends State<SetupSectionChild2Widget> {
  late SetupSectionChild2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SetupSectionChild2Model());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: FlutterFlowDropDown<String>(
            controller: _model.dropdownValueController ??=
                FormFieldController<String>(null),
            options: List<String>.from([
              'Zone 1-3',
              'Zone 4',
              'Zone 5',
              'Zone 6',
              'Zone 7a',
              'Zone 7b',
              'Zone 8',
              'Zone 9',
              'Zone 10-11'
            ]),
            optionLabels: [
              'Zone 1-3',
              'Zone 4',
              'Zone 5',
              'Zone 6',
              'Zone 7a',
              'Zone 7b',
              'Zone 8',
              'Zone 9',
              'Zone 10-11'
            ],
            onChanged: (val) async {
              safeSetState(() => _model.dropdownValue = val);
              FFAppState().setupGardeningZone = _model.dropdownValue!;
              safeSetState(() {});
            },
            width: 200.0,
            height: 40.0,
            textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.poppins(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  lineHeight: 1.4,
                ),
            hintText: 'Zone 1-3',
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24.0,
            ),
            fillColor: FlutterFlowTheme.of(context).alternate,
            elevation: 2.0,
            borderColor: FlutterFlowTheme.of(context).alternate,
            borderWidth: 1.0,
            borderRadius: 16.0,
            margin: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            hidesUnderline: true,
            isOverButton: false,
            isSearchable: false,
            isMultiSelect: false,
          ),
        ),
        Text(
          'Not sure? We\'ll calculate it from your zip code.',
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primary,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: 150.0,
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    onFieldSubmitted: (_) async {
                      FFAppState().setupZipCode = _model.textController.text;
                      safeSetState(() {});
                    },
                    autofocus: false,
                    enabled: true,
                    textInputAction: TextInputAction.next,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'Zip',
                      hintText: 'Enter Zip',
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    enableInteractiveSelection: true,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
