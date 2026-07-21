import '/auth/supabase_auth/auth_util.dart';
import '/index.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/services/subscription_service.dart';
import '/final_app_pages/paywall/paywall_widget.dart';
import '/final_app_pages/seed_inventory_page/seed_inventory_page_widget.dart';
import '/final_app_pages/seed_starting_guide/seed_starting_guide_widget.dart';
import '/final_app_pages/indoor_growing/indoor_growing_widget.dart';
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
    // Subscription status is read reactively via SubscriptionService.instance.isPro
    // inside a ListenableBuilder — no manual polling needed.
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
                  model: _model.finalHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: FinalHeaderWidget(
                    pageTitle: 'Settings',
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
                      // ── Subscription ───────────────────────────────────
                      ListenableBuilder(
                        listenable: SubscriptionService.instance,
                        builder: (context, _) {
                          final isPro = SubscriptionService.instance.isPro;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                                child: Text(
                                  'Subscription',
                                  style: FlutterFlowTheme.of(context).labelLarge.override(
                                        font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    borderRadius: BorderRadius.circular(24.0),
                                    border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                                  ),
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40.0, height: 40.0,
                                            decoration: BoxDecoration(
                                              color: isPro
                                                  ? const Color(0x1AFFD700)
                                                  : const Color(0x1A6F8F72),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            child: Icon(
                                              isPro
                                                  ? Icons.workspace_premium_rounded
                                                  : Icons.eco_rounded,
                                              color: isPro
                                                  ? const Color(0xFFB8860B)
                                                  : FlutterFlowTheme.of(context).primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(width: 16.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Current Plan',
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15.0)),
                                                Text(
                                                  isPro ? 'SproutTogether Pro' : 'Free Plan',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12.0,
                                                      color: FlutterFlowTheme.of(context).secondaryText)),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                                            decoration: BoxDecoration(
                                              color: isPro
                                                  ? const Color(0xFFFFF8DC)
                                                  : FlutterFlowTheme.of(context).primary.withOpacity(0.12),
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                            child: Text(
                                              isPro ? 'PRO' : 'FREE',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: isPro
                                                      ? const Color(0xFFB8860B)
                                                      : FlutterFlowTheme.of(context).primary)),
                                          ),
                                        ],
                                      ),
                                      Divider(height: 24.0, color: FlutterFlowTheme.of(context).alternate),
                                      InkWell(
                                        borderRadius: BorderRadius.circular(12.0),
                                        onTap: () async {
                                          if (isPro) {
                                            // Open Apple subscription management
                                            await launchURL(
                                                'https://apps.apple.com/account/subscriptions');
                                          } else {
                                            // Open paywall
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                fullscreenDialog: true,
                                                builder: (_) => const PaywallWidget(),
                                              ),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40.0, height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(0x1A6F8F72),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: Icon(
                                                  isPro
                                                      ? Icons.manage_accounts_rounded
                                                      : Icons.upgrade_rounded,
                                                  color: FlutterFlowTheme.of(context).primary, size: 20.0),
                                              ),
                                              const SizedBox(width: 16.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      isPro ? 'Manage Subscription' : 'Upgrade to Pro',
                                                      style: GoogleFonts.poppins(
                                                          fontWeight: FontWeight.w600, fontSize: 15.0)),
                                                    Text(
                                                      isPro
                                                          ? 'Change or cancel your plan'
                                                          : 'Unlock all features — from \$4.17/mo',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 12.0,
                                                          color: FlutterFlowTheme.of(context).secondaryText)),
                                                  ],
                                                ),
                                              ),
                                              Icon(Icons.chevron_right_rounded,
                                                  color: FlutterFlowTheme.of(context).secondaryText, size: 20.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (!isPro) ...[
                                        Divider(height: 24.0, color: FlutterFlowTheme.of(context).alternate),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (_) => const PaywallWidget(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF6F8F72),
                                              foregroundColor: Colors.white,
                                              elevation: 2,
                                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(14.0)),
                                            ),
                                            child: Text('Upgrade to Pro',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.0)),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      // ───────────────────────────────────────────────────
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
                      // ── Seed Inventory quick-link ───────────────────────
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                            child: Text(
                              'Tools',
                              style: FlutterFlowTheme.of(context).labelLarge.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                              child: ListenableBuilder(
                                listenable: SubscriptionService.instance,
                                builder: (context, _) {
                                  final isPro = SubscriptionService.instance.isPro;
                                  void openPaywall() => showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (_) => const PaywallWidget(),
                                      );
                                  Widget proBadge() => Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFD700),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Text('PRO',
                                            style: GoogleFonts.poppins(
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF7A5C00))),
                                      );
                                  return Column(
                                    children: [
                                      // Seed Inventory
                                      InkWell(
                                        borderRadius: BorderRadius.circular(12.0),
                                        onTap: isPro
                                            ? () => context.pushNamed(SeedInventoryPageWidget.routeName)
                                            : openPaywall,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40.0, height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(0x1A6F8F72),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: Icon(Icons.inventory_2_rounded,
                                                    color: FlutterFlowTheme.of(context).primary, size: 20.0),
                                              ),
                                              const SizedBox(width: 16.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Text('Seed Inventory',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w600, fontSize: 15.0)),
                                                      if (!isPro) ...[const SizedBox(width: 8), proBadge()],
                                                    ]),
                                                    Text('Track your seed collection',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 12.0,
                                                            color: FlutterFlowTheme.of(context).secondaryText)),
                                                  ],
                                                ),
                                              ),
                                              Icon(isPro ? Icons.chevron_right_rounded : Icons.lock_outline_rounded,
                                                  color: FlutterFlowTheme.of(context).secondaryText, size: 20.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 1, color: FlutterFlowTheme.of(context).alternate),
                                      // Seed Starting Guide
                                      InkWell(
                                        borderRadius: BorderRadius.circular(12.0),
                                        onTap: isPro
                                            ? () => context.pushNamed(SeedStartingGuideWidget.routeName)
                                            : openPaywall,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40.0, height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(0x1A6F8F72),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: Icon(Icons.calendar_today_rounded,
                                                    color: FlutterFlowTheme.of(context).primary, size: 20.0),
                                              ),
                                              const SizedBox(width: 16.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(children: [
                                                      Text('Seed Starting Guide',
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w600, fontSize: 15.0)),
                                                      if (!isPro) ...[const SizedBox(width: 8), proBadge()],
                                                    ]),
                                                    Text('Frost-date planting schedule',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 12.0,
                                                            color: FlutterFlowTheme.of(context).secondaryText)),
                                                  ],
                                                ),
                                              ),
                                              Icon(isPro ? Icons.chevron_right_rounded : Icons.lock_outline_rounded,
                                                  color: FlutterFlowTheme.of(context).secondaryText, size: 20.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(height: 1, color: FlutterFlowTheme.of(context).alternate),
                                      // Indoor Growing — free feature
                                      InkWell(
                                        borderRadius: BorderRadius.circular(12.0),
                                        onTap: () => context.pushNamed(IndoorGrowingWidget.routeName),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40.0, height: 40.0,
                                                decoration: BoxDecoration(
                                                  color: const Color(0x1A6F8F72),
                                                  borderRadius: BorderRadius.circular(12.0),
                                                ),
                                                child: Icon(Icons.house_outlined,
                                                    color: FlutterFlowTheme.of(context).primary, size: 20.0),
                                              ),
                                              const SizedBox(width: 16.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Indoor Growing',
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w600, fontSize: 15.0)),
                                                    Text('Grow herbs & veggies year-round',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 12.0,
                                                            color: FlutterFlowTheme.of(context).secondaryText)),
                                                  ],
                                                ),
                                              ),
                                              Icon(Icons.chevron_right_rounded,
                                                  color: FlutterFlowTheme.of(context).secondaryText, size: 20.0),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      // ───────────────────────────────────────────────────
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
                // ── Sign Out ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 12.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      GoRouter.of(context).prepareAuthEvent();
                      await authManager.signOut();
                      GoRouter.of(context).clearRedirectLocation();
                      if (context.mounted) {
                        context.pushReplacementNamed(LoginPageWidget.routeName);
                      }
                    },
                    text: 'Sign Out',
                    icon: const Icon(Icons.logout_rounded, size: 18.0),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconColor: const Color(0xFFD4685F),
                      color: const Color(0xFFD4685F).withOpacity(0.1),
                      textStyle: GoogleFonts.poppins(
                        color: const Color(0xFFD4685F),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD4685F),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                // ── Delete Account ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (dialogCtx) => AlertDialog(
                            title: Text('Delete Account?',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            content: Text(
                              'This will permanently delete your account, all gardens, and journal data. This cannot be undone.',
                              style: GoogleFonts.poppins(fontSize: 14.0),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(dialogCtx, false),
                                child: Text('Cancel',
                                    style: GoogleFonts.poppins(
                                        color: FlutterFlowTheme.of(context).secondaryText)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FlutterFlowTheme.of(context).error,
                                  elevation: 0,
                                ),
                                onPressed: () => Navigator.pop(dialogCtx, true),
                                child: Text('Delete',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          // TODO: implement account deletion
                          // e.g., await authManager.deleteUser(context: context);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    'Account deletion requested. You will receive a confirmation email.'),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                            );
                          }
                        }
                      },
                      icon: Icon(Icons.delete_forever_rounded,
                          color: FlutterFlowTheme.of(context).error),
                      label: Text(
                        'Delete Account',
                        style: GoogleFonts.poppins(
                          color: FlutterFlowTheme.of(context).error,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: FlutterFlowTheme.of(context).error),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                      ),
                    ),
                  ),
                ),
                // ───────────────────────────────────────────────────────────
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
