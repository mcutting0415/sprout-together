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
import 'final_header_model.dart';
export 'final_header_model.dart';

class FinalHeaderWidget extends StatefulWidget {
  const FinalHeaderWidget({
    super.key,
    String? pageTitle,
    this.saveAction,
    this.backAction,
    this.menuReplaceBackAction,
  }) : this.pageTitle = pageTitle ?? 'Page Title';

  final String pageTitle;
  /// When set, shows a green checkmark Save button (Garden Builder).
  final VoidCallback? saveAction;
  /// When set, shows a back arrow button on the RIGHT (e.g. sub-pages returning to Insights).
  final VoidCallback? backAction;
  /// When set, replaces the LEFT menu icon with a back arrow (e.g. Garden Insights from Planner).
  final VoidCallback? menuReplaceBackAction;

  @override
  State<FinalHeaderWidget> createState() => _FinalHeaderWidgetState();
}

class _FinalHeaderWidgetState extends State<FinalHeaderWidget> {
  late FinalHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FinalHeaderModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Material(
        color: Colors.transparent,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Container(
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
              color: FlutterFlowTheme.of(context).alternate,
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.88, 0.73),
                  child: widget.menuReplaceBackAction != null
                      ? FlutterFlowIconButton(
                          borderRadius: 8.0,
                          buttonSize: 48.0,
                          fillColor: FlutterFlowTheme.of(context).primaryBackground,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 24.0,
                          ),
                          onPressed: widget.menuReplaceBackAction,
                        )
                      : FlutterFlowIconButton(
                    borderRadius: 8.0,
                    buttonSize: 48.0,
                    fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    icon: Icon(
                      Icons.menu,
                      color: FlutterFlowTheme.of(context).primary,
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
                            margin:
                                EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                              border: Border.all(
                                color:
                                    FlutterFlowTheme.of(context).primaryText,
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
                                // 1. My Profile
                                ListTile(
                                  leading: Icon(Icons.person_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('My Profile',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(ProfilePage2Widget.routeName);
                                  },
                                ),
                                // 2. My Planner
                                ListTile(
                                  leading: Icon(Icons.eco_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('My Planner',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(PlannerOverviewPageWidget.routeName);
                                  },
                                ),
                                // 3. Plant Library
                                ListTile(
                                  leading: Icon(Icons.local_florist_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Plant Library',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(PlantLibraryPageWidget.routeName);
                                  },
                                ),
                                // 4. Companion Plants
                                ListTile(
                                  leading: Icon(Icons.people_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Companion Plants',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(CompanionGuidePage2Widget.routeName);
                                  },
                                ),
                                // 5. Growing Calendar
                                ListTile(
                                  leading: Icon(Icons.calendar_month_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Growing Calendar',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(GrowingCalendarWidget.routeName);
                                  },
                                ),
                                // 6. Garden Journal
                                ListTile(
                                  leading: Icon(Icons.book_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Garden Journal',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(GardenJournalPage2Widget.routeName);
                                  },
                                ),
                                // 7. Current Gardens
                                ListTile(
                                  leading: Icon(Icons.grid_view_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Current Gardens',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(CurrentGardens3Widget.routeName);
                                  },
                                ),
                                // 8. Your Archive
                                ListTile(
                                  leading: Icon(Icons.archive_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Your Archive',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(PreviousGardensPage2Widget.routeName);
                                  },
                                ),
                                // 9. Garden Tips
                                ListTile(
                                  leading: Icon(Icons.lightbulb_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Garden Tips',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(GardenTipsPageWidget.routeName);
                                  },
                                ),
                                // 10. Garden Goals
                                ListTile(
                                  leading: Icon(Icons.flag_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Garden Goals',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(GardenGoalsPageWidget.routeName);
                                  },
                                ),
                                // 11. Garden Shop
                                ListTile(
                                  leading: Icon(Icons.storefront_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Garden Shop',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(ShopPageWidget.routeName);
                                  },
                                ),
                                // 12. Help Center
                                ListTile(
                                  leading: Icon(Icons.help_outline_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Help Center',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(HelpPageWidget.routeName);
                                  },
                                ),
                                // 13. Settings
                                ListTile(
                                  leading: Icon(Icons.settings_rounded,
                                      color: FlutterFlowTheme.of(context).primary),
                                  title: Text('Settings',
                                      style: FlutterFlowTheme.of(context).bodyLarge),
                                  trailing: Icon(Icons.chevron_right_rounded,
                                      color: FlutterFlowTheme.of(context).secondaryText),
                                  onTap: () {
                                    Navigator.pop(ctx);
                                    context.pushNamed(SettingsPage2Widget.routeName);
                                  },
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(ctx).padding.bottom +
                                            16),
                              ],
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.46, 0.5),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 0.0, 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.seedling,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.16, 0.58),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                    child: Text(
                      'SproutTogether',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.23, 0.94),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'Learn • Plant • Grow • Share',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14.0,
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
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.18, -0.32),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 40.0, 0.0),
                    child: Text(
                      widget!.pageTitle,
                      textAlign: TextAlign.center,
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 26.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                    ),
                  ),
                ),
                // Save button (garden builder)
                if (widget.saveAction != null)
                  Align(
                    alignment: AlignmentDirectional(0.88, 0.73),
                    child: FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).primary,
                      icon: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 20.0,
                      ),
                      onPressed: widget.saveAction,
                    ),
                  ),
                // Back button (sub-pages like Goals, Tips, Journal)
                if (widget.backAction != null)
                  Align(
                    alignment: AlignmentDirectional(0.88, 0.73),
                    child: FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                      onPressed: widget.backAction,
                    ),
                  ),
                // No automatic back button — navigation lives in the menu.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
