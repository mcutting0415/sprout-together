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

  /// Maps a 5-digit US zip code to an approximate USDA hardiness zone string.
  String _zoneFromZip(String zip) {
    final n = int.tryParse(zip.padLeft(5, '0').substring(0, 5)) ?? -1;
    if (n < 0) return 'Zone 6';
    if (n < 1000) return 'Zone 10-11'; // 00xxx = PR
    if (n < 3000) return 'Zone 6'; // MA, RI
    if (n < 4000) return 'Zone 5'; // NH
    if (n < 6000) return 'Zone 5'; // ME, VT
    if (n < 7000) return 'Zone 6'; // CT
    if (n < 9000) return 'Zone 7a'; // NJ
    if (n < 10000) return 'Zone 6'; // misc
    if (n < 15000) return 'Zone 6'; // NY
    if (n < 20000) return 'Zone 6'; // PA
    if (n < 25000) return 'Zone 7a'; // DC, MD, VA
    if (n < 27000) return 'Zone 6'; // WV
    if (n < 29000) return 'Zone 7b'; // NC
    if (n < 32000) return 'Zone 8'; // SC, GA
    if (n < 35000) return 'Zone 9'; // FL
    if (n < 37000) return 'Zone 8'; // AL
    if (n < 38000) return 'Zone 7a'; // TN
    if (n < 40000) return 'Zone 8'; // MS
    if (n < 43000) return 'Zone 6'; // KY
    if (n < 46000) return 'Zone 6'; // OH
    if (n < 48000) return 'Zone 5'; // IN
    if (n < 50000) return 'Zone 5'; // MI
    if (n < 53000) return 'Zone 5'; // IA
    if (n < 55000) return 'Zone 5'; // WI
    if (n < 57000) return 'Zone 4'; // MN
    if (n < 58000) return 'Zone 4'; // SD
    if (n < 59000) return 'Zone 1-3'; // ND
    if (n < 60000) return 'Zone 4'; // MT
    if (n < 63000) return 'Zone 5'; // IL
    if (n < 66000) return 'Zone 6'; // MO
    if (n < 68000) return 'Zone 6'; // KS
    if (n < 70000) return 'Zone 5'; // NE
    if (n < 72000) return 'Zone 9'; // LA
    if (n < 73000) return 'Zone 7a'; // AR
    if (n < 75000) return 'Zone 7a'; // OK
    if (n < 80000) return 'Zone 8'; // TX
    if (n < 82000) return 'Zone 5'; // CO
    if (n < 83000) return 'Zone 4'; // WY
    if (n < 84000) return 'Zone 5'; // ID
    if (n < 85000) return 'Zone 6'; // UT
    if (n < 87000) return 'Zone 9'; // AZ
    if (n < 89000) return 'Zone 6'; // NM
    if (n < 90000) return 'Zone 8'; // NV
    if (n < 97000) return 'Zone 9'; // CA
    if (n < 98000) return 'Zone 8'; // OR
    if (n < 99500) return 'Zone 8'; // WA
    return 'Zone 1-3'; // AK
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
                    onChanged: (val) {
                      FFAppState().setupZipCode = val;
                    },
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
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  final zip = _model.textController.text.trim();
                  if (zip.length < 5) return;
                  final zone = _zoneFromZip(zip);
                  safeSetState(() {
                    _model.dropdownValue = zone;
                    _model.dropdownValueController.value = zone;
                  });
                  FFAppState().setupGardeningZone = zone;
                  FFAppState().setupZipCode = zip;
                  safeSetState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                ),
                child: Text(
                  'Auto-detect',
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .bodySmall
                              .fontStyle,
                        ),
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
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
