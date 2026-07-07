import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
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
import 'section_card_child3_model.dart';
export 'section_card_child3_model.dart';

class SectionCardChild3Widget extends StatefulWidget {
  const SectionCardChild3Widget({super.key});

  @override
  State<SectionCardChild3Widget> createState() =>
      _SectionCardChild3WidgetState();
}

class _SectionCardChild3WidgetState extends State<SectionCardChild3Widget> {
  late SectionCardChild3Model _model;

  static String _zipToZone(String zip) {
    if (zip.length < 3) return '';
    final prefix = int.tryParse(zip.substring(0, 3));
    if (prefix == null) return '';
    if (prefix <= 9) return '';
    if (prefix <= 19) return 'Zone 5';  // MA
    if (prefix <= 29) return 'Zone 6';  // RI/MA
    if (prefix <= 39) return 'Zone 5';  // NH
    if (prefix <= 49) return 'Zone 5';  // ME
    if (prefix <= 59) return 'Zone 4';  // VT
    if (prefix <= 69) return 'Zone 6';  // CT
    if (prefix <= 98) return 'Zone 7';  // NJ
    if (prefix <= 119) return 'Zone 7'; // NYC
    if (prefix <= 149) return 'Zone 5'; // Upstate NY
    if (prefix <= 168) return 'Zone 6'; // PA
    if (prefix <= 219) return 'Zone 7'; // DE/MD/DC
    if (prefix <= 246) return 'Zone 7'; // VA
    if (prefix <= 268) return 'Zone 6'; // WV
    if (prefix <= 289) return 'Zone 7'; // NC
    if (prefix <= 299) return 'Zone 8'; // SC
    if (prefix <= 319) return 'Zone 8'; // GA
    if (prefix <= 349) return 'Zone 9'; // FL
    if (prefix <= 369) return 'Zone 8'; // AL
    if (prefix <= 385) return 'Zone 7'; // TN/MS north
    if (prefix <= 399) return 'Zone 8'; // MS south
    if (prefix <= 427) return 'Zone 6'; // KY
    if (prefix <= 458) return 'Zone 6'; // OH
    if (prefix <= 479) return 'Zone 6'; // IN
    if (prefix <= 499) return 'Zone 5'; // MI
    if (prefix <= 528) return 'Zone 5'; // IA
    if (prefix <= 549) return 'Zone 4'; // WI
    if (prefix <= 567) return 'Zone 4'; // MN
    if (prefix <= 577) return 'Zone 4'; // SD
    if (prefix <= 588) return 'Zone 3'; // ND
    if (prefix <= 599) return 'Zone 4'; // MT
    if (prefix <= 629) return 'Zone 5'; // IL
    if (prefix <= 658) return 'Zone 6'; // MO
    if (prefix <= 679) return 'Zone 6'; // KS
    if (prefix <= 693) return 'Zone 5'; // NE
    if (prefix <= 714) return 'Zone 9'; // LA
    if (prefix <= 729) return 'Zone 8'; // AR
    if (prefix <= 749) return 'Zone 7'; // OK
    if (prefix <= 769) return 'Zone 8'; // TX east
    if (prefix <= 799) return 'Zone 9'; // TX south/west
    if (prefix <= 816) return 'Zone 5'; // CO
    if (prefix <= 831) return 'Zone 4'; // WY
    if (prefix <= 838) return 'Zone 6'; // ID
    if (prefix <= 847) return 'Zone 7'; // UT
    if (prefix <= 865) return 'Zone 9'; // AZ
    if (prefix <= 884) return 'Zone 7'; // NM
    if (prefix <= 898) return 'Zone 8'; // NV
    if (prefix <= 961) return 'Zone 9'; // CA
    if (prefix <= 979) return 'Zone 8'; // OR
    if (prefix <= 994) return 'Zone 8'; // WA
    if (prefix <= 999) return 'Zone 4'; // AK
    return '';
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild3Model());

    // Pre-fill zip code from account setup
    final appState = FFAppState();
    _model.textController ??= TextEditingController(
      text: appState.setupZipCode.isNotEmpty ? appState.setupZipCode : '',
    );
    _model.textFieldFocusNode ??= FocusNode();

    // Auto-update zone whenever zip changes
    _model.textController!.addListener(() {
      if (mounted) {
        final zone = _zipToZone(_model.textController!.text);
        if (zone.isNotEmpty) FFAppState().setupGardeningZone = zone;
        safeSetState(() {});
      }
    });

    // If appState is empty (e.g. after app restart), load zip from database
    if (appState.setupZipCode.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final rows = await ProfilesTable().queryRows(
            queryFn: (q) => q.eqOrNull('id', currentUserUid),
          );
          if (rows.isNotEmpty && mounted) {
            final dbZip = rows.first.zipCode ?? '';
            if (dbZip.isNotEmpty) {
              safeSetState(() {
                _model.textController?.text = dbZip;
                FFAppState().setupZipCode = dbZip;
              });
            }
          }
        } catch (_) {}
      });
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detectedZone = _zipToZone(_model.textController?.text ?? '');

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 0.0,
          height: 0.0,
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
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.5,
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
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Zone:',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      decoration: TextDecoration.none,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: detectedZone.isNotEmpty
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  detectedZone.isNotEmpty ? detectedZone : 'Enter zip above',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 15.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        color: detectedZone.isNotEmpty
                            ? FlutterFlowTheme.of(context).primary
                            : FlutterFlowTheme.of(context).secondaryText,
                      ),
                ),
              ),
            ].divide(SizedBox(width: 10.0)),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30.0, 8.0, 0.0, 0.0),
                child: Text(
                  'Units:',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        decoration: TextDecoration.none,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: FlutterFlowChoiceChips(
                  options: [ChipData('Imperial'), ChipData('Metric')],
                  onChanged: (val) => safeSetState(
                      () => _model.choiceChipsValue = val?.firstOrNull),
                  selectedChipStyle: ChipStyle(
                    backgroundColor: FlutterFlowTheme.of(context).primaryText,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    iconColor: FlutterFlowTheme.of(context).info,
                    iconSize: 16.0,
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  unselectedChipStyle: ChipStyle(
                    backgroundColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    iconColor: FlutterFlowTheme.of(context).secondaryText,
                    iconSize: 16.0,
                    elevation: 0.0,
                    borderColor: FlutterFlowTheme.of(context).primaryText,
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  chipSpacing: 0.0,
                  rowSpacing: 8.0,
                  multiselect: false,
                  alignment: WrapAlignment.center,
                  controller: _model.choiceChipsValueController ??=
                      FormFieldController<List<String>>(
                    [],
                  ),
                  wrapped: false,
                ),
              ),
            ].divide(SizedBox(width: 50.0)),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.color_lens,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 28.0,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  'Appearance',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
            ].divide(SizedBox(width: 5.0)),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterFlowDropDown<String>(
                controller: _model.dropDownValueController2 ??=
                    FormFieldController<String>(
                  _model.dropDownValue2 ??= FlutterFlowTheme.colorTheme,
                ),
                options: List<String>.from(
                    ['Sprout Green', 'Earth Green', 'Ocean Blue', 'Lavender']),
                optionLabels: [
                  'Sprout Green',
                  'Earth Brown',
                  'Ocean Blue',
                  'Lavender'
                ],
                onChanged: (val) {
                  safeSetState(() => _model.dropDownValue2 = val);
                  if (val != null) {
                    FlutterFlowTheme.saveColorTheme(val);
                    // Notify FFAppState watchers so Goals/Profile rebuild immediately
                    FFAppState().update(() {});
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;
                    setDarkModeSetting(
                        context, isDark ? ThemeMode.dark : ThemeMode.light);
                  }
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
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                hintText: 'Select...',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                elevation: 2.0,
                borderColor: FlutterFlowTheme.of(context).primaryText,
                borderWidth: 1.5,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                hidesUnderline: true,
                isOverButton: false,
                isSearchable: false,
                isMultiSelect: false,
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Material(
                  color: Colors.transparent,
                  child: SwitchListTile.adaptive(
                    value: _model.switchListTileValue ??=
                        (Theme.of(context).brightness == Brightness.dark),
                    onChanged: (newValue) async {
                      safeSetState(
                          () => _model.switchListTileValue = newValue!);
                      setDarkModeSetting(
                          context,
                          newValue!
                              ? ThemeMode.dark
                              : ThemeMode.light);
                    },
                    title: Text(
                      'Dark Mode',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                            fontSize: 20.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                    ),
                    tileColor: FlutterFlowTheme.of(context).secondaryBackground,
                    activeColor: FlutterFlowTheme.of(context).alternate,
                    activeTrackColor: FlutterFlowTheme.of(context).primary,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
