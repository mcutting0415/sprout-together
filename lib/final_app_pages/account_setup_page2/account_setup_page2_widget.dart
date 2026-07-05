import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/setup_section/setup_section_widget.dart';
import '/components/setup_section_child/setup_section_child_widget.dart';
import '/components/setup_section_child2/setup_section_child2_widget.dart';
import '/components/setup_section_child3/setup_section_child3_widget.dart';
import '/components/setup_section_child4/setup_section_child4_widget.dart';
import '/components/setup_section_child5/setup_section_child5_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'account_setup_page2_model.dart';
export 'account_setup_page2_model.dart';

/// Create a new version of my Account Setup page for SproutTogether.
///
/// Requirements:
///
/// * Use the existing app theme, colors, and typography.
///
/// * Keep the page mobile-friendly and easy to use.
///
/// * Make the layout feel less crowded and more modern.
///
/// * Use cards and spacing to separate sections clearly.
///
/// * Include the following information:
///
///   • Name
///   • Zip Code
///   • Gardening Zone
///   • Garden Types (Raised Bed, Container, In-Ground)
///   • Gardening Goals
///   • Experience Level
///
/// * Use choice chips where appropriate.
///
/// * Include helpful icons next to each section.
///
/// * Add brief descriptions under section headers to explain why the
/// information is being collected.
///
/// * Make the page feel welcoming to new gardeners.
///
/// * Use rounded corners and consistent spacing.
///
/// * Include a Save Profile button at the bottom.
///
/// Do not add any logic, actions, or database connections.
/// Focus only on creating a clean, professional layout that improves
/// usability and visual design.
class AccountSetupPage2Widget extends StatefulWidget {
  const AccountSetupPage2Widget({super.key});

  static String routeName = 'AccountSetupPage2';
  static String routePath = '/accountSetupPage2';

  @override
  State<AccountSetupPage2Widget> createState() =>
      _AccountSetupPage2WidgetState();
}

class _AccountSetupPage2WidgetState extends State<AccountSetupPage2Widget> {
  late AccountSetupPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountSetupPage2Model());
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome to ',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                150.0, 0.0, 0.0, 0.0),
                            child: FaIcon(
                              FontAwesomeIcons.seedling,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 50.0,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SproutTogether',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 28.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          'Let\'s personalize your gardening journey.',
                          style: FlutterFlowTheme.of(context)
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
                      ].divide(SizedBox(height: 4.0)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              wrapWithModel(
                                model: _model.setupSectionModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: SetupSectionWidget(
                                  icon: Icon(
                                    Icons.person_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20.0,
                                  ),
                                  title: 'The Basics',
                                  desc:
                                      'Used to identify you and find local gardening groups.',
                                  child: () => SetupSectionChildWidget(),
                                ),
                              ),
                              wrapWithModel(
                                model: _model.setupSectionModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: SetupSectionWidget(
                                  icon: Icon(
                                    Icons.energy_savings_leaf_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20.0,
                                  ),
                                  title: 'Gardening Zone',
                                  desc:
                                      'Helps us recommend the right plants for your climate.',
                                  child: () => SetupSectionChild2Widget(),
                                ),
                              ),
                              wrapWithModel(
                                model: _model.setupSectionModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: SetupSectionWidget(
                                  icon: Icon(
                                    Icons.deck_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20.0,
                                  ),
                                  title: 'Garden Setup',
                                  desc: 'Where are you growing your plants?',
                                  child: () => SetupSectionChild3Widget(),
                                ),
                              ),
                              wrapWithModel(
                                model: _model.setupSectionModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: SetupSectionWidget(
                                  icon: Icon(
                                    Icons.school_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20.0,
                                  ),
                                  title: 'Experience Level',
                                  desc:
                                      'We\'ll tailor our advice to your skill level.',
                                  child: () => SetupSectionChild4Widget(),
                                ),
                              ),
                              wrapWithModel(
                                model: _model.setupSectionModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: SetupSectionWidget(
                                  icon: Icon(
                                    Icons.star_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20.0,
                                  ),
                                  title: 'Your Goals',
                                  desc:
                                      'Select what you\'d like to achieve this season.',
                                  child: () => SetupSectionChild5Widget(),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  await ProfilesTable().update(
                                    data: {
                                      'id': currentUserUid,
                                      'full_name': FFAppState().setupNameInput,
                                      'town': FFAppState().setupTownInput,
                                      'profile_image_url':
                                          FFAppState().setupProfileImageURL,
                                      'gardening_zone':
                                          FFAppState().setupGardeningZone,
                                      'zip_code': FFAppState().setupZipCode,
                                      'garden_types':
                                          FFAppState().setupGardenTypes,
                                      'experience_level':
                                          FFAppState().setupExperienceLevel,
                                      'goals': FFAppState().setupGoals,
                                      'has_completed_setup': true,
                                    },
                                    matchingRows: (rows) => rows.eq('id', currentUserUid),
                                  );
                                  // Save selected goals to user_goals table
                                  for (final goal in FFAppState().setupGoals) {
                                    await UserGoalsTable().insert({
                                      'user_id': currentUserUid,
                                      'goal_text': goal,
                                      'goal_type': 'initial',
                                      'completed': false,
                                    });
                                  }
                                  FFAppState().hasCompletedProfileSetup = true;
                                  safeSetState(() {});

                                  context
                                      .pushNamed(ProfilePage2Widget.routeName);
                                },
                                text: 'Start Growing',
                                icon: Icon(
                                  Icons.grass,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  height: 40.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),

                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Container(
                                    child: Container(
                                      width: 0.0,
                                      height: 0.0,
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 24.0)),
                          ),
                        ),
                      ),
                      Text(
                        'Learn • Plant • Grow • Share',
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
