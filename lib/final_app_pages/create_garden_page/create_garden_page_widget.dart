import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_garden_page_model.dart';
export 'create_garden_page_model.dart';

/// Create an alternative version of my Create Garden page for SproutTogether.
///
/// Goal:
/// Make creating a garden feel simple, exciting, and beginner-friendly.
///
/// Requirements:
///
/// * Use the existing SproutTogether theme, colors, and typography.
/// * Match the style of the rest of the application.
/// * Mobile-first design.
/// * Clean layout with generous spacing.
/// * Use cards and icons where appropriate.
///
/// Include:
///
/// 1. Garden Name
///
///    * Text field
///
/// 2. Garden Type
///
///    * Choice chips:
///
///      * 🛏️ Raised Bed
///      * 🪴 Container Garden
///      * 🌱 In-Ground Garden
///
/// 3. Garden Size
///
///    * Width field
///    * Length field
///    * Units selector (feet or meters)
///
/// 4. Garden Orientation
///
///    * Horizontal
///    * Vertical
///
/// 5. Optional Notes
///
///    * Multi-line text field
///
/// 6. Next Button
///
///    * Leads to Garden Builder
///
/// Design Goals:
///
/// * Make the page feel welcoming and easy to understand.
/// * Reduce clutter.
/// * Group related information together.
/// * Include brief helper text explaining each section.
/// * Use gardening-themed icons.
/// * Make it obvious what information is required.
///
/// Do not add any actions, logic, or database connections.
/// Focus only on layout, usability, and visual design.
class CreateGardenPageWidget extends StatefulWidget {
  const CreateGardenPageWidget({
    super.key,
    String? title,
    String? raisedBeds,
  })  : this.title = title ?? 'Naming',
        this.raisedBeds = raisedBeds ?? 'raisedBeds';

  final String title;
  final String raisedBeds;

  static String routeName = 'CreateGardenPage';
  static String routePath = '/createGardenPage';

  @override
  State<CreateGardenPageWidget> createState() => _CreateGardenPageWidgetState();
}

class _CreateGardenPageWidgetState extends State<CreateGardenPageWidget> {
  late CreateGardenPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateGardenPageModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 175.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                            onPressed: () async {
                              context.pushNamed(
                                  PlannerOverviewPageWidget.routeName);
                            },
                          ),
                          Container(
                            width: 40.0,
                          ),
                        ],
                      ),
                      Text(
                        'Create Your Garden',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                      Text(
                        'Let\'s start with the basics to help your plants thrive.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                              lineHeight: 1.4,
                            ),
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            icon: Icon(
                              Icons.eco_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            title: widget!.title,
                            subtitle: 'Give your green space a personality',
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Container(
                      width: 100.0,
                      child: TextFormField(
                        controller: _model.textController1,
                        focusNode: _model.textFieldFocusNode1,
                        autofocus: false,
                        enabled: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelStyle:
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
                          hintText: 'Enter Garden Name...',
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
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        enableInteractiveSelection: true,
                        validator: _model.textController1Validator
                            .asValidator(context),
                      ),
                    ),
                    wrapWithModel(
                      model: _model.sectionHeaderModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: SectionHeaderWidget(
                        icon: Icon(
                          Icons.yard_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 22.0,
                        ),
                        title: 'Garden Type',
                        subtitle: 'Where will your seeds grow?',
                      ),
                    ),
                    FlutterFlowChoiceChips(
                      options: [
                        ChipData('Raised Beds'),
                        ChipData('Containers'),
                        ChipData('In-Ground')
                      ],
                      onChanged: (val) => safeSetState(
                          () => _model.choiceChipsValue1 = val?.firstOrNull),
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                        iconColor: FlutterFlowTheme.of(context).info,
                        iconSize: 16.0,
                        elevation: 0.0,
                        borderColor: FlutterFlowTheme.of(context).primaryText,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
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
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        iconColor: FlutterFlowTheme.of(context).secondaryText,
                        iconSize: 16.0,
                        elevation: 0.0,
                        borderColor: FlutterFlowTheme.of(context).primaryText,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      chipSpacing: 8.0,
                      rowSpacing: 8.0,
                      multiselect: false,
                      alignment: WrapAlignment.center,
                      controller: _model.choiceChipsValueController1 ??=
                          FormFieldController<List<String>>(
                        [],
                      ),
                      wrapped: true,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            icon: Icon(
                              Icons.square_foot_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            title: 'Dimensions',
                            subtitle: 'How much space do we have?',
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Text(
                                            'Measurement Units',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                  lineHeight: 1.4,
                                                ),
                                          ),
                                        ),
                                        Flexible(
                                          child: FlutterFlowChoiceChips(
                                            options: [
                                              ChipData('Ft'),
                                              ChipData('m')
                                            ],
                                            onChanged: (val) => safeSetState(
                                                () => _model.choiceChipsValue2 =
                                                    val?.firstOrNull),
                                            selectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              iconSize: 0.0,
                                              elevation: 0.0,
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            unselectedChipStyle: ChipStyle(
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              iconColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              iconSize: 0.0,
                                              elevation: 0.0,
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                            ),
                                            chipSpacing: 8.0,
                                            rowSpacing: 8.0,
                                            multiselect: false,
                                            alignment: WrapAlignment.center,
                                            controller: _model
                                                    .choiceChipsValueController2 ??=
                                                FormFieldController<
                                                    List<String>>(
                                              [],
                                            ),
                                            wrapped: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    controller: _model.textController2,
                                    focusNode: _model.textFieldFocusNode2,
                                    autofocus: false,
                                    enabled: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Set Width',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      hintText: 'Width',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model.textController2Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    controller: _model.textController3,
                                    focusNode: _model.textFieldFocusNode3,
                                    autofocus: false,
                                    enabled: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Set Length',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      hintText: 'Length',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.poppins(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    enableInteractiveSelection: true,
                                    validator: _model.textController3Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel4,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            icon: Icon(
                              Icons.light_mode_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            title: 'Garden Layout',
                            subtitle: 'Important details for later...',
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    FlutterFlowChoiceChips(
                      options: [
                        ChipData('Horizontal', Icons.border_horizontal),
                        ChipData('Vertical', Icons.border_vertical)
                      ],
                      onChanged: (val) => safeSetState(
                          () => _model.choiceChipsValue3 = val?.firstOrNull),
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                        iconColor: FlutterFlowTheme.of(context).info,
                        iconSize: 16.0,
                        elevation: 0.0,
                        borderColor: FlutterFlowTheme.of(context).primaryText,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
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
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        iconColor: FlutterFlowTheme.of(context).secondaryText,
                        iconSize: 16.0,
                        elevation: 0.0,
                        borderColor: FlutterFlowTheme.of(context).primaryText,
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      chipSpacing: 8.0,
                      rowSpacing: 8.0,
                      multiselect: false,
                      alignment: WrapAlignment.center,
                      controller: _model.choiceChipsValueController3 ??=
                          FormFieldController<List<String>>(
                        [],
                      ),
                      wrapped: true,
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: FlutterFlowChoiceChips(
                        options: [
                          ChipData('Full Sun'),
                          ChipData('Partial Sun'),
                          ChipData('Partial Shade'),
                          ChipData('Shade')
                        ],
                        onChanged: (val) => safeSetState(
                            () => _model.choiceChipsValue4 = val?.firstOrNull),
                        selectedChipStyle: ChipStyle(
                          backgroundColor: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          iconColor: FlutterFlowTheme.of(context).info,
                          iconSize: 0.0,
                          elevation: 0.0,
                          borderColor: FlutterFlowTheme.of(context).primaryText,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        unselectedChipStyle: ChipStyle(
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                          iconColor: FlutterFlowTheme.of(context).secondaryText,
                          iconSize: 16.0,
                          elevation: 0.0,
                          borderColor: FlutterFlowTheme.of(context).primaryText,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        chipSpacing: 8.0,
                        rowSpacing: 8.0,
                        multiselect: false,
                        alignment: WrapAlignment.center,
                        controller: _model.choiceChipsValueController4 ??=
                            FormFieldController<List<String>>(
                          [],
                        ),
                        wrapped: true,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: FlutterFlowChoiceChips(
                        options: [
                          ChipData('North'),
                          ChipData('South'),
                          ChipData('East'),
                          ChipData('West')
                        ],
                        onChanged: (val) => safeSetState(
                            () => _model.choiceChipsValue5 = val?.firstOrNull),
                        selectedChipStyle: ChipStyle(
                          backgroundColor: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                          iconColor: FlutterFlowTheme.of(context).info,
                          iconSize: 0.0,
                          elevation: 0.0,
                          borderColor: FlutterFlowTheme.of(context).primaryText,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        unselectedChipStyle: ChipStyle(
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                          iconColor: FlutterFlowTheme.of(context).secondaryText,
                          iconSize: 16.0,
                          elevation: 0.0,
                          borderColor: FlutterFlowTheme.of(context).primaryText,
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        chipSpacing: 20.0,
                        rowSpacing: 8.0,
                        multiselect: false,
                        alignment: WrapAlignment.center,
                        controller: _model.choiceChipsValueController5 ??=
                            FormFieldController<List<String>>(
                          [],
                        ),
                        wrapped: true,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.sectionHeaderModel5,
                          updateCallback: () => safeSetState(() {}),
                          child: SectionHeaderWidget(
                            icon: Icon(
                              Icons.edit_note_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 22.0,
                            ),
                            title: 'Optional Notes',
                            subtitle: 'Any special details to remember?',
                          ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        controller: _model.textController4,
                        focusNode: _model.textFieldFocusNode4,
                        autofocus: false,
                        enabled: true,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
                        obscureText: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Enter Notes (Optional)',
                          labelStyle:
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
                          hintText: 'Notes...',
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
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        textAlign: TextAlign.start,
                        maxLines: null,
                        cursorColor: FlutterFlowTheme.of(context).primaryText,
                        enableInteractiveSelection: true,
                        validator: _model.textController4Validator
                            .asValidator(context),
                        inputFormatters: [
                          if (!isAndroid && !isiOS)
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              return TextEditingValue(
                                selection: newValue.selection,
                                text: newValue.text.toCapitalization(
                                    TextCapitalization.sentences),
                              );
                            }),
                        ],
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        _model.newGarden = await GardensTable().insert({
                          'garden_name': _model.textController1.text,
                          'garden_type': _model.choiceChipsValue1,
                          'measurement_unit': _model.choiceChipsValue2,
                          'width': int.tryParse(_model.textController2.text),
                          'length': int.tryParse(_model.textController3.text),
                          'orientation': _model.choiceChipsValue3,
                          'user_id': currentUserUid,
                        });
                        FFAppState().currentGardenID = _model.newGarden!.id!;
                        safeSetState(() {});
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 0,
                          'col_index': 0,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 0,
                          'col_index': 1,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 0,
                          'col_index': 2,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 0,
                          'col_index': 3,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 1,
                          'col_index': 0,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 1,
                          'col_index': 1,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 1,
                          'col_index': 2,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 1,
                          'col_index': 3,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 2,
                          'col_index': 0,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 2,
                          'col_index': 1,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 2,
                          'col_index': 2,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 2,
                          'col_index': 3,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 3,
                          'col_index': 0,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 3,
                          'col_index': 1,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 3,
                          'col_index': 2,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 3,
                          'col_index': 3,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 4,
                          'col_index': 0,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 4,
                          'col_index': 1,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 4,
                          'col_index': 2,
                          'plant_id': '',
                        });
                        await GardenPlotsTable().insert({
                          'id': '',
                          'garden_id': _model.newGarden?.id,
                          'row_index': 4,
                          'col_index': 3,
                          'plant_id': '',
                        });

                        context.pushNamed(
                          GardenBuilderPageWidget.routeName,
                          queryParameters: {
                            'gardenID': serializeParam(
                              '',
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );

                        safeSetState(() {});
                      },
                      text: 'Create Garden',
                      icon: Icon(
                        Icons.handyman,
                        size: 20.0,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconAlignment: IconAlignment.end,
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Container(
                          child: Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
