import '/components/journal_entry/journal_entry_widget.dart';
import '/components/stat_pill/stat_pill_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'garden_journal_page2_model.dart';
export 'garden_journal_page2_model.dart';

/// Create an alternative version of my Garden Journal page for
/// SproutTogether.
///
/// Goal:
/// Create a gardening journal where users can document their garden's
/// progress throughout the growing season.
///
/// Use the existing SproutTogether theme, colors, typography, spacing, and
/// design style.
///
/// Requirements:
///
/// Page Header:
///
/// * Garden Journal
///
/// Quick Actions:
///
/// * New Journal Entry button
/// * Add Photo button
///
/// Journal Timeline Section:
///
/// * Display journal entries in reverse chronological order
/// * Show date for each entry
/// * Show photo thumbnail if available
/// * Show entry title
/// * Show notes preview
///
/// Entry Card Layout:
///
/// * Photo
/// * Date
/// * Garden Name
/// * Notes Preview
/// * View Entry button
///
/// Filter Options:
///
/// * All Entries
/// * By Garden
/// * By Plant
/// * By Month
///
/// Statistics Section:
///
/// * Total Entries
/// * Photos Added
/// * Gardens Tracked
///
/// Design Goals:
///
/// * Feel like a gardening scrapbook.
/// * Clean and modern.
/// * Easy to browse.
/// * Friendly and encouraging.
/// * Mobile-friendly.
/// * Use cards and timeline-style layouts.
/// * Plenty of spacing.
///
/// Do not add functionality, database actions, or navigation.
/// Focus only on page structure and visual design.
class GardenJournalPage2Widget extends StatefulWidget {
  const GardenJournalPage2Widget({super.key});

  static String routeName = 'GardenJournalPage2';
  static String routePath = '/gardenJournalPage2';

  @override
  State<GardenJournalPage2Widget> createState() =>
      _GardenJournalPage2WidgetState();
}

class _GardenJournalPage2WidgetState extends State<GardenJournalPage2Widget> {
  late GardenJournalPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenJournalPage2Model());
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
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    wrapWithModel(
                      model: _model.finalHeaderModel,
                      updateCallback: () => safeSetState(() {}),
                      child: FinalHeaderWidget(
                        pageTitle: 'Garden Journal',
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 16.0),
                          child: Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.statPillModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatPillWidget(
                                      icon: Icon(
                                        Icons.auto_stories_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 16.0,
                                      ),
                                      value: '24',
                                      label: 'Entries',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.statPillModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatPillWidget(
                                      icon: Icon(
                                        Icons.image_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 16.0,
                                      ),
                                      value: '86',
                                      label: 'Photos',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.statPillModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StatPillWidget(
                                      icon: Icon(
                                        Icons.local_florist_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 16.0,
                                      ),
                                      value: '3',
                                      label: 'Gardens',
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 16.0, 24.0, 16.0),
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.check_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 16.0,
                                      ),
                                      Text(
                                        'All Entries',
                                        style: FlutterFlowTheme.of(context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'By Garden',
                                        style: FlutterFlowTheme.of(context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'By Plant',
                                        style: FlutterFlowTheme.of(context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ),
                              ),
                              Container(
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'By Month',
                                        style: FlutterFlowTheme.of(context)
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                              lineHeight: 1.4,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 6.0)),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    wrapWithModel(
                      model: _model.journalEntryModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: JournalEntryWidget(
                        imgDesc:
                            'https://dimg.dreamflow.cloud/v1/image/basket%20of%20red%20tomatoes%20on%20a%20wooden%20bench',
                        date: 'October 12, 2023',
                        garden: 'Backyard Veggies',
                        title: 'First Tomato Harvest!',
                        preview:
                            'Finally picked the Early Girl tomatoes today. The flavor is incredible compared to store-bought.',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.journalEntryModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: JournalEntryWidget(
                        imgDesc:
                            'https://dimg.dreamflow.cloud/v1/image/orange%20butterfly%20on%20a%20purple%20flower',
                        date: 'October 08, 2023',
                        garden: 'Front Porch',
                        title: 'Monarch Butterfly Visit',
                        preview:
                            'Spotted two Monarchs on the Milkweed this morning. The pollinators are loving the late bloom.',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.journalEntryModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: JournalEntryWidget(
                        imgDesc:
                            'https://dimg.dreamflow.cloud/v1/image/hand%20holding%20fresh%20green%20basil%20leaves',
                        date: 'September 30, 2023',
                        garden: 'Herb Spiral',
                        title: 'Pruning the Basil',
                        preview:
                            'Cut back the Thai Basil before the first frost. Made a huge batch of pesto for the freezer.',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.journalEntryModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: JournalEntryWidget(
                        imgDesc:
                            'https://dimg.dreamflow.cloud/v1/image/large%20orange%20pumpkin%20in%20a%20vine-covered%20patch',
                        date: 'September 22, 2023',
                        garden: 'Backyard Veggies',
                        title: 'Pumpkin Watch',
                        preview:
                            'The Jack-O-Lantern pumpkins are finally turning orange! Just in time for the spooky season.',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    child: Container(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.eco_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 32.0,
                          ),
                          Text(
                            'End of 2023 Season',
                            style: FlutterFlowTheme.of(context)
                                .labelLarge
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
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
