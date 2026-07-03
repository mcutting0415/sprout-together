import '/backend/supabase/supabase.dart';
import '/components/plot_square/plot_square_widget.dart';
import '/draft_pages/side_menu/side_menu_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'garden_builder_page_model.dart';
export 'garden_builder_page_model.dart';

class GardenBuilderPageWidget extends StatefulWidget {
  const GardenBuilderPageWidget({
    super.key,
    required this.gardenID,
  });

  final String? gardenID;

  static String routeName = 'GardenBuilderPage';
  static String routePath = '/gardenBuilderPage';

  @override
  State<GardenBuilderPageWidget> createState() =>
      _GardenBuilderPageWidgetState();
}

class _GardenBuilderPageWidgetState extends State<GardenBuilderPageWidget> {
  late GardenBuilderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenBuilderPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _loadPlots();
    });
  }

  Future<void> _loadPlots() async {
    final plots = await GardenPlotsTable().queryRows(
      queryFn: (q) => q.eqOrNull('garden_id', widget!.gardenID),
    );
    safeSetState(() {
      _model.gardenPlotQuery = plots;
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<GardensRow>>(
      future: GardensTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id',
          widget!.gardenID,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<GardensRow> gardenBuilderPageGardensRowList = snapshot.data!;

        final gardenBuilderPageGardensRow =
            gardenBuilderPageGardensRowList.isNotEmpty
                ? gardenBuilderPageGardensRowList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              children: [
                SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      wrapWithModel(
                        model: _model.finalHeaderModel,
                        updateCallback: () => safeSetState(() {}),
                        child: FinalHeaderWidget(
                          pageTitle: 'Garden Builder',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x0D6F8F72),
                            borderRadius: BorderRadius.circular(24.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0x336F8F72),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 56.0,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(16.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.local_florist_rounded,
                                      color: Colors.white,
                                      size: 28.0,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            gardenBuilderPageGardensRow
                                                ?.gardenName,
                                            'Loading . . .',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            gardenBuilderPageGardensRow
                                                ?.gardenType,
                                            'Loading . . .',
                                          ),
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12.0,
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
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.grid_view_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 14.0,
                                            ),
                                            Text(
                                              '${gardenBuilderPageGardensRow?.width?.toString() ?? '?'} × ${gardenBuilderPageGardensRow?.length?.toString() ?? '?'} ft',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                _model.gardenPlotQuery?.length
                                                    ?.toString(),
                                                '0',
                                              ),
                                              style: FlutterFlowTheme.of(
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
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.edit_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Garden Layout',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Text(
                                  'Tap a square to \n             assign plant',
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final plotItem =
                                _model.gardenPlotQuery?.toList() ?? [];

                            if (plotItem.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Center(
                                  child: Text(
                                    'No plots yet — create a garden first.',
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
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              );
                            }

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 1.0,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: plotItem.length,
                              itemBuilder: (context, plotItemIndex) {
                                final plotItemItem = plotItem[plotItemIndex];
                                return Container(
                                  key: ValueKey(plotItemIndex.toString()),
                                  child: wrapWithModel(
                                    model: _model.plotSquareModels.getModel(
                                      plotItemIndex.toString(),
                                      plotItemIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: PlotSquareWidget(
                                      key: Key(
                                        'Keyeqt_${plotItemIndex.toString()}',
                                      ),
                                      isEmpty: plotItemItem.plantId == null ||
                                          plotItemItem.plantId!.isEmpty,
                                      icon: FaIcon(
                                        FontAwesomeIcons.seedling,
                                      ),
                                      gardenID: widget!.gardenID!,
                                      plotID: plotItemItem.id!,
                                      rowIndex: plotItemItem.rowIndex!,
                                      colIndex: plotItemItem.colIndex!,
                                      onPlantAssigned: () => _loadPlots(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 24.0),
                        child: Container(),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      0,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      0,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      0,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      1,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      0,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      2,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      0,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      3,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      1,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      0,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      1,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      1,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      1,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      2,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      1,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      3,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      2,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      0,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      2,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      1,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      2,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      2,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      2,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      3,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      3,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      0,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      3,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      1,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      3,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      2,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      3,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      3,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      4,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      0,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      4,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      1,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      4,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      2,
                                    ),
                              );
                              await GardenPlotsTable().update(
                                data: {
                                  'plant_id': '',
                                },
                                matchingRows: (rows) => rows
                                    .eqOrNull(
                                      'garden_id',
                                      widget!.gardenID,
                                    )
                                    .eqOrNull(
                                      'row_index',
                                      4,
                                    )
                                    .eqOrNull(
                                      'col_index',
                                      3,
                                    ),
                              );
                            },
                            text: 'Clear Layout',
                            icon: FaIcon(
                              FontAwesomeIcons.eraser,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              height: 48.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
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
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Individual Containers',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
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
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 56.0,
                                        height: 56.0,
                                        decoration: BoxDecoration(
                                          color: Color(0x1ADADEE4),
                                          borderRadius:
                                              BorderRadius.circular(9999.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color(0x4DDADEE4),
                                            width: 1.0,
                                          ),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Icon(
                                          Icons.coffee_maker_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          size: 24.0,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Terracotta Pot #1',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              'Tap to assign plant',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                      ),
                                      Icon(
                                        Icons.add_circle_outline_rounded,
                                        color: FlutterFlowTheme.of(context).primary,
                                        size: 24.0,
                                      ),
                                    ].divide(SizedBox(width: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(24.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total Plants',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '${_model.gardenPlotQuery?.where((p) => p.plantId != null && p.plantId!.isNotEmpty).length ?? 0} Assigned',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                        Container(
                                          width: 1.0,
                                          height: 32.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Available',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '${(_model.gardenPlotQuery?.length ?? 0) - (_model.gardenPlotQuery?.where((p) => p.plantId != null && p.plantId!.isNotEmpty).length ?? 0)} Spaces',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                        Container(
                                          width: 1.0,
                                          height: 32.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Dimensions',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '${((gardenBuilderPageGardensRow?.width ?? 0) * (gardenBuilderPageGardensRow?.length ?? 0)).toStringAsFixed(0)} sq ft',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                    ],
                  ),
                ),
                if (FFAppState().isSideMenuOpen)
                  wrapWithModel(
                    model: _model.sideMenuModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SideMenuWidget(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
