import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'header_model.dart';
export 'header_model.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    super.key,
    String? title,
  }) : this.title = title ?? 'Settings';

  final String title;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late HeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 16.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.seedling,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      Text(
                        'SproutTogether',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                      ),
                    ],
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget!.title,
                      'Settings',
                    ),
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FontWeight.w800,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w800,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                          lineHeight: 1.4,
                        ),
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                icon: Icon(
                  Icons.menu,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    enableDrag: true,
                    isDismissible: true,
                    context: context,
                    builder: (ctx) {
                      return Container(
                        margin: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText
                                      .withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.person_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primary),
                              title: Text('My Profile',
                                  style:
                                      FlutterFlowTheme.of(context).bodyLarge),
                              trailing: Icon(Icons.chevron_right_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              onTap: () {
                                Navigator.pop(ctx);
                                context
                                    .pushNamed(ProfilePage2Widget.routeName);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.eco_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primary),
                              title: Text('My Planner',
                                  style:
                                      FlutterFlowTheme.of(context).bodyLarge),
                              trailing: Icon(Icons.chevron_right_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              onTap: () {
                                Navigator.pop(ctx);
                                context.pushNamed(
                                    PlannerOverviewPageWidget.routeName);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.local_florist_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primary),
                              title: Text('Plant Library',
                                  style:
                                      FlutterFlowTheme.of(context).bodyLarge),
                              trailing: Icon(Icons.chevron_right_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              onTap: () {
                                Navigator.pop(ctx);
                                context.pushNamed(
                                    PlantLibraryPageWidget.routeName);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.people_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primary),
                              title: Text('Companion Guide',
                                  style:
                                      FlutterFlowTheme.of(context).bodyLarge),
                              trailing: Icon(Icons.chevron_right_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              onTap: () {
                                Navigator.pop(ctx);
                                context.pushNamed(
                                    CompanionGuidePage2Widget.routeName);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.book_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primary),
                              title: Text('Garden Journal',
                                  style:
                                      FlutterFlowTheme.of(context).bodyLarge),
                              trailing: Icon(Icons.chevron_right_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              onTap: () {
                                Navigator.pop(ctx);
                                context.pushNamed(
                                    GardenJournalPage2Widget.routeName);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.settings_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).primary),
                              title: Text('Settings',
                                  style:
                                      FlutterFlowTheme.of(context).bodyLarge),
                              trailing: Icon(Icons.chevron_right_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText),
                              onTap: () {
                                Navigator.pop(ctx);
                                context
                                    .pushNamed(SettingsPage2Widget.routeName);
                              },
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(ctx).padding.bottom + 16),
                          ],
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
