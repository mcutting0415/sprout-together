import '/final_app_pages/final_header/final_header_widget.dart';
import '/final_app_pages/paywall/paywall_widget.dart';
import '/final_app_pages/seed_inventory_page/seed_inventory_page_widget.dart';
import '/final_app_pages/seed_starting_guide/seed_starting_guide_widget.dart';
import '/final_app_pages/indoor_growing/indoor_growing_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/subscription_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tools_page_model.dart';
export 'tools_page_model.dart';

class ToolsPageWidget extends StatefulWidget {
  const ToolsPageWidget({super.key});

  static String routeName = 'ToolsPage';
  static String routePath = '/toolsPage';

  @override
  State<ToolsPageWidget> createState() => _ToolsPageWidgetState();
}

class _ToolsPageWidgetState extends State<ToolsPageWidget> {
  late ToolsPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ToolsPageModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.finalHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: const FinalHeaderWidget(pageTitle: 'Tools'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20.0,
                          ),
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 2.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFD700),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(
                                      'PRO',
                                      style: GoogleFonts.poppins(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF7A5C00),
                                      ),
                                    ),
                                  );

                              return Column(
                                children: [
                                  // ── Seed Inventory ──────────────────────
                                  InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: isPro
                                        ? () => context.pushNamed(
                                            SeedInventoryPageWidget.routeName)
                                        : openPaywall,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0x1A6F8F72),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Icon(
                                              Icons.inventory_2_rounded,
                                              color: FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(width: 16.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Seed Inventory',
                                                      style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    if (!isPro) ...[
                                                      const SizedBox(width: 8),
                                                      proBadge(),
                                                    ],
                                                  ],
                                                ),
                                                Text(
                                                  'Track your seed collection',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.0,
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .secondaryText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            isPro
                                                ? Icons.chevron_right_rounded
                                                : Icons.lock_outline_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  // ── Seed Starting Guide ──────────────────
                                  InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: isPro
                                        ? () => context.pushNamed(
                                            SeedStartingGuideWidget.routeName)
                                        : openPaywall,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0x1A6F8F72),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Icon(
                                              Icons.calendar_today_rounded,
                                              color: FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(width: 16.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Seed Starting Guide',
                                                      style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                    if (!isPro) ...[
                                                      const SizedBox(width: 8),
                                                      proBadge(),
                                                    ],
                                                  ],
                                                ),
                                                Text(
                                                  'Frost-date planting schedule',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.0,
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .secondaryText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            isPro
                                                ? Icons.chevron_right_rounded
                                                : Icons.lock_outline_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 20.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  // ── Indoor Growing ────────────────────────
                                  InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () => context
                                        .pushNamed(IndoorGrowingWidget.routeName),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color: const Color(0x1A6F8F72),
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Icon(
                                              Icons.house_outlined,
                                              color: FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 20.0,
                                            ),
                                          ),
                                          const SizedBox(width: 16.0),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Indoor Growing',
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                Text(
                                                  'Grow herbs & veggies year-round',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.0,
                                                    color:
                                                        FlutterFlowTheme.of(context)
                                                            .secondaryText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right_rounded,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 20.0,
                                          ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
