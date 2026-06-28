import '/backend/supabase/supabase.dart';
import '/components/relationship_card/relationship_card_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'companion_guide_page2_model.dart';
export 'companion_guide_page2_model.dart';

/// Create an alternative version of my Companion Planting page for
/// SproutTogether.
///
/// Requirements:
///
/// * Use the existing SproutTogether theme, colors, and typography.
/// * Make the page feel clean, modern, and easy to understand.
/// * Reduce clutter and improve visual organization.
/// * Use cards and sections with plenty of spacing.
///
/// Include:
///
/// * A plant search bar at the top.
/// * A plant selection area.
/// * A section for Companion Plants (Good Matches).
/// * A section for Plants to Avoid.
/// * A section explaining why the plants are compatible or incompatible.
/// * Companion plants should use positive visual indicators.
/// * Plants to avoid should use warning indicators.
///
/// Design Goals:
///
/// * Make it easy for beginner gardeners to understand.
/// * Prioritize readability.
/// * Use gardening-themed icons and visual cues.
/// * Make the page feel educational and helpful.
/// * Use cards instead of long lists where possible.
///
/// Do not add logic, actions, or database connections.
/// Focus only on layout, visual hierarchy, and user experience.
class CompanionGuidePage2Widget extends StatefulWidget {
  const CompanionGuidePage2Widget({
    super.key,
    required this.plantID,
  });

  final String? plantID;

  static String routeName = 'CompanionGuidePage2';
  static String routePath = '/companionGuidePage2';

  @override
  State<CompanionGuidePage2Widget> createState() =>
      _CompanionGuidePage2WidgetState();
}

class _CompanionGuidePage2WidgetState extends State<CompanionGuidePage2Widget> {
  late CompanionGuidePage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompanionGuidePage2Model());
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional(0.0, -1.21),
                  child: wrapWithModel(
                    model: _model.finalHeaderModel,
                    updateCallback: () => safeSetState(() {}),
                    child: FinalHeaderWidget(
                      pageTitle: 'Companion Plants',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder<List<PlantsRow>>(
                  future: PlantsTable().querySingleRow(
                    queryFn: (q) => q.eqOrNull(
                      'id',
                      widget!.plantID,
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
                    List<PlantsRow> columnPlantsRowList = snapshot.data!;

                    final columnPlantsRow = columnPlantsRowList.isNotEmpty
                        ? columnPlantsRowList.first
                        : null;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            columnPlantsRow?.plantName,
                            'Plant Name',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                        ),
                      ].divide(SizedBox(height: 4.0)),
                    );
                  },
                ),
              ),
              FutureBuilder<List<PlantCompanionsRow>>(
                future: PlantCompanionsTable().queryRows(
                  queryFn: (q) => q
                      .eqOrNull(
                        'plant_id',
                        widget!.plantID,
                      )
                      .eqOrNull(
                        'relationship_type',
                        'good',
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
                  List<PlantCompanionsRow> columnPlantCompanionsRowList =
                      snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(columnPlantCompanionsRowList.length,
                        (columnIndex) {
                      final columnPlantCompanionsRow =
                          columnPlantCompanionsRowList[columnIndex];
                      return FutureBuilder<List<PlantsRow>>(
                        future: PlantsTable().querySingleRow(
                          queryFn: (q) => q.eqOrNull(
                            'id',
                            columnPlantCompanionsRow.relatedPlantId,
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
                          List<PlantsRow> relationshipCardPlantsRowList =
                              snapshot.data!;

                          final relationshipCardPlantsRow =
                              relationshipCardPlantsRowList.isNotEmpty
                                  ? relationshipCardPlantsRowList.first
                                  : null;

                          return wrapWithModel(
                            model: _model.relationshipCardModels1.getModel(
                              columnIndex.toString(),
                              columnIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: RelationshipCardWidget(
                              key: Key(
                                'Keyvdo_${columnIndex.toString()}',
                              ),
                              tone: FlutterFlowTheme.of(context).success,
                              icon: Icon(
                                Icons.agriculture_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 18.0,
                              ),
                              name: relationshipCardPlantsRow?.plantName,
                              reason: columnPlantCompanionsRow.reason,
                            ),
                          );
                        },
                      );
                    }).divide(SizedBox(height: 16.0)),
                  );
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Text(
                          'Plants to Avoid',
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0x0DFF5963),
                      borderRadius: BorderRadius.circular(24.0),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0x33FF5963),
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        child: FutureBuilder<List<PlantCompanionsRow>>(
                          future: PlantCompanionsTable().queryRows(
                            queryFn: (q) => q
                                .eqOrNull(
                                  'plant_id',
                                  widget!.plantID,
                                )
                                .eqOrNull(
                                  'relationship_type',
                                  'bad',
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
                            List<PlantCompanionsRow>
                                columnPlantCompanionsRowList = snapshot.data!;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                  columnPlantCompanionsRowList.length,
                                  (columnIndex) {
                                final columnPlantCompanionsRow =
                                    columnPlantCompanionsRowList[columnIndex];
                                return FutureBuilder<List<PlantsRow>>(
                                  future: PlantsTable().querySingleRow(
                                    queryFn: (q) => q.eqOrNull(
                                      'id',
                                      columnPlantCompanionsRow.relatedPlantId,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<PlantsRow>
                                        relationshipCardPlantsRowList =
                                        snapshot.data!;

                                    final relationshipCardPlantsRow =
                                        relationshipCardPlantsRowList.isNotEmpty
                                            ? relationshipCardPlantsRowList
                                                .first
                                            : null;

                                    return wrapWithModel(
                                      model: _model.relationshipCardModels2
                                          .getModel(
                                        columnIndex.toString(),
                                        columnIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: RelationshipCardWidget(
                                        key: Key(
                                          'Keyd7y_${columnIndex.toString()}',
                                        ),
                                        tone:
                                            FlutterFlowTheme.of(context).error,
                                        icon: Icon(
                                          Icons.warning_amber_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 18.0,
                                        ),
                                        name: relationshipCardPlantsRow
                                            ?.plantName,
                                        reason: columnPlantCompanionsRow.reason,
                                      ),
                                    );
                                  },
                                );
                              }).divide(SizedBox(height: 16.0)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          color: FlutterFlowTheme.of(context).tertiary,
                          size: 24.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Gardener\'s Tip',
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                              ),
                              Text(
                                'Companion planting works by creating a mini-ecosystem. Some plants fix nitrogen, while others act as \'trap crops\' to lure pests away from your main harvest.',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .override(
                                      font: GoogleFonts.poppins(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
