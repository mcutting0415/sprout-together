import '/components/header_widget.dart';
import '/components/section_card_child2_widget.dart';
import '/components/section_card_child3_widget.dart';
import '/components/section_card_child4_widget.dart';
import '/components/section_card_child5_widget.dart';
import '/components/section_card_child6_widget.dart';
import '/components/section_card_child7_widget.dart';
import '/components/section_card_child_widget.dart';
import '/components/section_card_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'settings_page2_model.dart';
export 'settings_page2_model.dart';

/// Create a Settings Page for my gardening app called SproutTogether.
///
/// IMPORTANT: This page MUST match my existing app design exactly.
///
/// Current Design Style:
///
/// * Soft sage green color palette
/// * Cream/off-white backgrounds
/// * Rounded corners (16-24 radius)
/// * Subtle shadows
/// * Modern gardening aesthetic
/// * Friendly and welcoming
/// * Consistent with Plant Library, Garden Builder, Companion Guide, and
/// Planner pages
/// * Mobile-first design
/// * Use my reusable SproutTogether header component at the top
/// * Do NOT use dark mode styling
/// * Do NOT use bright colors
/// * Do NOT use sharp corners
///
/// Page Layout:
///
/// HEADER
///
/// * Space for my reusable SproutTogether header component
/// * Page title: Settings
///
/// ACCOUNT SECTION
/// Rounded card containing:
///
/// * Profile Picture
/// * User Name
/// * Email Address
/// * Edit Profile Button
///
/// APP PREFERENCES SECTION
/// Rounded card containing:
///
/// * Notifications Toggle
/// * Watering Reminders Toggle
/// * Garden Task Reminders Toggle
/// * Companion Planting Alerts Toggle
/// * Dark Mode Toggle (future use)
///
/// MY GARDENS SECTION
/// Rounded card containing:
///
/// * Saved Gardens
/// * Archived Gardens
/// * Garden Templates
///
/// DATA & STORAGE SECTION
/// Rounded card containing:
///
/// * Export Garden Data
/// * Backup Account
/// * Restore Data
///
/// SUPPORT SECTION
/// Rounded card containing:
///
/// * Help Center
/// * Frequently Asked Questions
/// * Contact Support
/// * Submit Feedback
///
/// ABOUT SECTION
/// Rounded card containing:
///
/// * App Version
/// * Privacy Policy
/// * Terms of Service
///
/// ACCOUNT ACTIONS
/// At the bottom:
///
/// * Sign Out Button
/// * Delete Account Button (outlined warning style)
///
/// Design Requirements:
///
/// * Every section should be inside soft rounded cards.
/// * Use icons for each setting row.
/// * Use clean list-tile style rows.
/// * Plenty of spacing between sections.
/// * Consistent typography with existing pages.
/// * Sage green primary buttons.
/// * Cream background.
/// * Professional gardening app appearance.
///
/// The page should feel like it belongs in the same app as the Plant Library
/// and Garden Builder pages.
/// Since gardening is my focus, aloso add
///
/// Watering reminders
///
/// Frost warning notifications
///
/// Garden journal reminders
///
/// Harvest reminders
///
/// Planting calendar alerts
///
/// Companion planting recommendations
class SettingsPage2Widget extends StatefulWidget {
  const SettingsPage2Widget({super.key});

  static String routeName = 'SettingsPage2';
  static String routePath = '/settingsPage2';

  @override
  State<SettingsPage2Widget> createState() => _SettingsPage2WidgetState();
}

class _SettingsPage2WidgetState extends State<SettingsPage2Widget> {
  late SettingsPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsPage2Model());
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                wrapWithModel(
                  model: _model.headerModel,
                  updateCallback: () => safeSetState(() {}),
                  child: HeaderWidget(
                    title: 'Settings',
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      wrapWithModel(
                        model: _model.sectionCardModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionCardWidget(
                          title: 'Account',
                          child: () => SectionCardChildWidget(),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.sectionCardModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionCardWidget(
                          title: 'Gardening Alerts',
                          child: () => SectionCardChild2Widget(),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.sectionCardModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionCardWidget(
                          title: 'App Preferences',
                          child: () => SectionCardChild3Widget(),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.sectionCardModel4,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionCardWidget(
                          title: 'My Gardens',
                          child: () => SectionCardChild4Widget(),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.sectionCardModel5,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionCardWidget(
                          title: 'Data & Storage',
                          child: () => SectionCardChild5Widget(),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.sectionCardModel6,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionCardWidget(
                          title: 'Support',
                          child: () => SectionCardChild6Widget(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 24.0),
                        child: Container(
                          child: Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.sectionCardChild7Model,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionCardChild7Widget(),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ),
                Text(
                  'Learn • Plant • Grow • Share',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
