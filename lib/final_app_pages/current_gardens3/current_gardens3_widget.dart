import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/garden_card2/garden_card2_widget.dart';
import '/components/insight_item/insight_item_widget.dart';
import '/draft_pages/garden_detail_drawer/garden_detail_drawer_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'current_gardens3_model.dart';
export 'current_gardens3_model.dart';

class CurrentGardens3Widget extends StatefulWidget {
  const CurrentGardens3Widget({super.key});

  static String routeName = 'CurrentGardens3';
  static String routePath = '/currentGardens3';

  @override
  State<CurrentGardens3Widget> createState() => _CurrentGardens3WidgetState();
}

class _CurrentGardens3WidgetState extends State<CurrentGardens3Widget> {
  late CurrentGardens3Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CurrentGardens3Model());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.currentGardensQuery = await GardensTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'user_id',
              currentUserUid,
            )
            .eqOrNull(
              'is_archived',
              false,
            ),
      );
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  wrapWithModel(
                    model: _model.finalHeaderModel,
                    updateCallback: () => safeSetState(() {}),
                    child: FinalHeaderWidget(
                      pageTitle: 'Current Gardens',
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 10.0),
                    child: FutureBuilder<List<GardensRow>>(
                      future: GardensTable().queryRows(
                        queryFn: (q) => q.eqOrNull(
                          'user_id',
                          currentUserUid,
                        ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<GardensRow> listViewGardensRowList =
                            snapshot.data!;

                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewGardensRowList.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10.0),
                          itemBuilder: (context, listViewIndex) {
                            final listViewGardensRow =
                                listViewGardensRowList[listViewIndex];
                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                FFAppState().selectedGardenIDForDetail =
                                    listViewGardensRow.id!;
                                FFAppState().isGardenDetailOpen = true;
                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.gardenCardModels1.getModel(
                                  listViewIndex.toString(),
                                  listViewIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: GardenCard2Widget(
                                  key: Key(
                                    'Key53v_${listViewIndex.toString()}',
                                  ),
                                  emoji: '',
                                  title: listViewGardensRow.gardenName,
                                  count:
                                      '${listViewGardensRow.width?.toString()}${listViewGardensRow.length?.toString()}',
                                  status: '',
                                  plants: '',
                                  gardenID: listViewGardensRow.gardenName!,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.lightbulb_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                Text(
                                  'Garden Insights',
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
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                wrapWithModel(
                                  model: _model.insightItemModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InsightItemWidget(
                                    tone: FlutterFlowTheme.of(context).info,
                                    icon: Icon(
                                      Icons.water_drop_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    message: 'Water Patio Containers Tomorrow',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.insightItemModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InsightItemWidget(
                                    tone: FlutterFlowTheme.of(context).tertiary,
                                    icon: Icon(
                                      Icons.content_cut_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    message: 'Tomatoes Ready To Prune',
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.insightItemModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: InsightItemWidget(
                                    tone: FlutterFlowTheme.of(context).success,
                                    icon: Icon(
                                      Icons.eco_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    message: 'Basil Ready To Harvest',
                                  ),
                                ),
                              ].divide(SizedBox(height: 8.0)),
                            ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 24.0,
                  ),
                ],
              ),
            ),
            if (FFAppState().isGardenDetailOpen)
              FutureBuilder<List<GardensRow>>(
                future: GardensTable().querySingleRow(
                  queryFn: (q) => q.eqOrNull(
                    'user_id',
                    currentUserUid,
                  ),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<GardensRow> gardenDetailDrawerGardensRowList =
                      snapshot.data!;

                  final gardenDetailDrawerGardensRow =
                      gardenDetailDrawerGardensRowList.isNotEmpty
                          ? gardenDetailDrawerGardensRowList.first
                          : null;

                  return wrapWithModel(
                    model: _model.gardenDetailDrawerModel,
                    updateCallback: () => safeSetState(() {}),
                    child: GardenDetailDrawerWidget(
                      gardenID: gardenDetailDrawerGardensRow!.id!,
                      gardenName: gardenDetailDrawerGardensRow!.gardenName!,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
