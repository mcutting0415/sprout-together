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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              wrapWithModel(
                model: _model.finalHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: FinalHeaderWidget(
                  pageTitle: 'Companion Plants',
                ),
              ),
              // ── Selected plant name ──
              FutureBuilder<List<PlantsRow>>(
                future: PlantsTable().querySingleRow(
                  queryFn: (q) => q.eqOrNull('id', widget!.plantID),
                ),
                builder: (context, snapshot) {
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
                  final columnPlantsRow = snapshot.data!.isNotEmpty
                      ? snapshot.data!.first
                      : null;

                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16.0, 16.0, 16.0, 8.0),
                    child: Text(
                      valueOrDefault<String>(
                        columnPlantsRow?.plantName,
                        'Plant Name',
                      ),
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  );
                },
              ),
              // ── Good Companions header ──
              Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.check_circle_outline_rounded,
                        color: FlutterFlowTheme.of(context).success,
                        size: 20.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Good Companions',
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
                  ],
                ),
              ),
              // ── Good Companions list ──
              FutureBuilder<List<PlantCompanionsRow>>(
                future: PlantCompanionsTable().queryRows(
                  queryFn: (q) => q
                      .eqOrNull('plant_id', widget!.plantID)
                      .eqOrNull('relationship_type', 'good'),
                ),
                builder: (context, snapshot) {
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
                  final companions = snapshot.data!;

                  if (companions.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'No companion planting data yet for this plant.',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
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

                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(companions.length, (i) {
                        final companion = companions[i];
                        return FutureBuilder<List<PlantsRow>>(
                          future: PlantsTable().querySingleRow(
                            queryFn: (q) =>
                                q.eqOrNull('id', companion.relatedPlantId),
                          ),
                          builder: (context, snapshot) {
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
                            final plant = snapshot.data!.isNotEmpty
                                ? snapshot.data!.first
                                : null;

                            return wrapWithModel(
                              model: _model.relationshipCardModels1
                                  .getModel(i.toString(), i),
                              updateCallback: () => safeSetState(() {}),
                              child: RelationshipCardWidget(
                                key: Key('Keyvdo_${i.toString()}'),
                                tone: FlutterFlowTheme.of(context).success,
                                icon: Icon(
                                  Icons.agriculture_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 18.0,
                                ),
                                name: plant?.plantName,
                                reason: companion.reason,
                              ),
                            );
                          },
                        );
                      }).divide(SizedBox(height: 16.0)),
                    ),
                  );
                },
              ),
              // ── Plants to Avoid header ──
              Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: FlutterFlowTheme.of(context).error, size: 20.0),
                    SizedBox(width: 8.0),
                    Text(
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
                  ],
                ),
              ),
              // ── Plants to Avoid list ──
              Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 8.0),
                child: Container(
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
                    child: FutureBuilder<List<PlantCompanionsRow>>(
                      future: PlantCompanionsTable().queryRows(
                        queryFn: (q) => q
                            .eqOrNull('plant_id', widget!.plantID)
                            .eqOrNull('relationship_type', 'bad'),
                      ),
                      builder: (context, snapshot) {
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
                        final badCompanions = snapshot.data!;

                        if (badCompanions.isEmpty) {
                          return Center(
                            child: Text(
                              'No incompatible plants listed for this plant.',
                              textAlign: TextAlign.center,
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
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          );
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: List.generate(badCompanions.length, (i) {
                            final companion = badCompanions[i];
                            return FutureBuilder<List<PlantsRow>>(
                              future: PlantsTable().querySingleRow(
                                queryFn: (q) =>
                                    q.eqOrNull('id', companion.relatedPlantId),
                              ),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                final plant = snapshot.data!.isNotEmpty
                                    ? snapshot.data!.first
                                    : null;

                                return wrapWithModel(
                                  model: _model.relationshipCardModels2
                                      .getModel(i.toString(), i),
                                  updateCallback: () => safeSetState(() {}),
                                  child: RelationshipCardWidget(
                                    key: Key('Keyd7y_${i.toString()}'),
                                    tone: FlutterFlowTheme.of(context).error,
                                    icon: Icon(
                                      Icons.warning_amber_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    name: plant?.plantName,
                                    reason: companion.reason,
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
              // ── Gardener's Tip ──
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
                                    color:
                                        FlutterFlowTheme.of(context).primaryText,
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
            ],
          ),
        ),
      ),
    );
  }
}
