import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/benefit_badge_widget.dart';
import '/components/requirement_row_widget.dart';
import '/components/timeline_item2_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'plant_details_page_model.dart';
export 'plant_details_page_model.dart';

class PlantDetailsPageWidget extends StatefulWidget {
  const PlantDetailsPageWidget({
    super.key,
    required this.plantID,
  });

  final String? plantID;

  static String routeName = 'PlantDetailsPage';
  static String routePath = '/plantDetailsPage';

  @override
  State<PlantDetailsPageWidget> createState() => _PlantDetailsPageWidgetState();
}

class _PlantDetailsPageWidgetState extends State<PlantDetailsPageWidget> {
  late PlantDetailsPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  PlantsRow? _plant;
  bool _loadingPlant = true;
  List<Map<String, dynamic>> _purchaseLinks = [];
  List<String> _goodCompanions = [];
  List<String> _avoidCompanions = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantDetailsPageModel());
    _loadPlant();
    _loadPurchaseLinks();
  }

  Future<void> _loadPlant() async {
    if (widget.plantID == null) {
      if (mounted) setState(() => _loadingPlant = false);
      return;
    }
    try {
      final rows = await PlantsTable().querySingleRow(
        queryFn: (q) => q.eqOrNull('id', widget.plantID),
      );
      final plant = rows.firstOrNull;
      if (mounted) {
        setState(() {
          _plant = plant;
          _loadingPlant = false;
        });
      }
      if (plant?.id != null) await _loadCompanions(plant!.id!);
    } catch (_) {
      if (mounted) setState(() => _loadingPlant = false);
    }
  }

  Future<void> _loadCompanions(String plantId) async {
    try {
      final response = await SupaFlow.client
          .from('plant_companions')
          .select('relationship_type, related_plant:plants!related_plant_id(plant_name)')
          .eq('plant_id', plantId);
      final rows = List<Map<String, dynamic>>.from(response as List);
      final good = <String>[];
      final avoid = <String>[];
      for (final row in rows) {
        final name = (row['related_plant'] as Map?)?['plant_name'] as String? ?? '';
        if (name.isEmpty) continue;
        if (row['relationship_type'] == 'avoid') {
          avoid.add(name);
        } else {
          good.add(name);
        }
      }
      if (mounted) {
        setState(() {
          _goodCompanions = good;
          _avoidCompanions = avoid;
        });
      }
    } catch (_) {}
  }

  Future<void> _loadPurchaseLinks() async {
    if (widget.plantID == null) return;
    try {
      final response = await SupaFlow.client
          .from('plant_purchase_links')
          .select()
          .eq('plant_id', widget.plantID!)
          .eq('is_active', true)
          .order('link_type');
      if (mounted) {
        setState(() {
          _purchaseLinks = List<Map<String, dynamic>>.from(response as List);
        });
      }
    } catch (_) {}
  }

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _chipTag(String text, Color borderColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Text(text,
          style: GoogleFonts.poppins(fontSize: 12.0, color: textColor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);
    final plant = _plant;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Hero image ──────────────────────────────────────────────
              Container(
                height: 340.0,
                child: Stack(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  children: [
                    _loadingPlant
                        ? Container(
                            height: 300.0,
                            color: theme.primary.withOpacity(0.12),
                            child: const Center(
                                child: Text('🌱',
                                    style: TextStyle(fontSize: 64.0))),
                          )
                        : CachedNetworkImage(
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                            imageUrl: () {
                              final url = plant?.imageUrl ?? '';
                              if (url.startsWith('http')) return url;
                              final name = Uri.encodeComponent(
                                  'Lush ${plant?.plantName ?? 'garden plant'} plant growing outdoors');
                              return 'https://dimg.dreamflow.cloud/v1/image/$name';
                            }(),
                            height: 300.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              height: 300.0,
                              color: theme.primary.withOpacity(0.12),
                              child: const Center(
                                  child: Text('🌱',
                                      style: TextStyle(fontSize: 64.0))),
                            ),
                            errorWidget: (_, __, ___) => Container(
                              height: 300.0,
                              color: theme.primary.withOpacity(0.12),
                              child: const Center(
                                  child: Text('🌱',
                                      style: TextStyle(fontSize: 64.0))),
                            ),
                          ),
                    // Fade gradient
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Container(
                        height: 80.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [theme.primaryBackground, Colors.transparent],
                            stops: const [0.0, 1.0],
                            begin: AlignmentDirectional(0.0, 1.0),
                            end: AlignmentDirectional(0, -1.0),
                          ),
                        ),
                      ),
                    ),
                    // Back button
                    Align(
                      alignment: AlignmentDirectional(-1.0, -1.0),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 9999.0,
                            buttonSize: 40.0,
                            fillColor: const Color(0xCCFFFFFF),
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: theme.primaryText,
                              size: 20.0,
                            ),
                            onPressed: () async => context.safePop(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Content ─────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Plant name + category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            _loadingPlant
                                ? 'Loading…'
                                : (plant?.plantName ?? 'Unknown Plant'),
                            style: theme.headlineMedium.override(
                              font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                              color: theme.primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              lineHeight: 1.3,
                            ),
                          ),
                        ),
                        if ((plant?.category ?? '').isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: theme.primary,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              plant!.category!,
                              style: GoogleFonts.poppins(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8.0),

                    // Description
                    if ((plant?.description ?? '').isNotEmpty)
                      Text(
                        plant!.description!,
                        style: theme.bodyMedium.override(
                          font: GoogleFonts.poppins(),
                          color: theme.secondaryText,
                          letterSpacing: 0.0,
                          lineHeight: 1.5,
                        ),
                      ),

                    const SizedBox(height: 20.0),

                    // ── Growing Requirements ─────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Growing Requirements',
                              style: theme.titleMedium.override(
                                font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                                color: theme.primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                lineHeight: 1.4,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            wrapWithModel(
                              model: _model.requirementRowModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: RequirementRowWidget(
                                icon: Icon(Icons.light_mode_rounded,
                                    color: theme.primary, size: 20.0),
                                label: 'Sunlight',
                                value: plant?.sunRequirement ?? '–',
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            wrapWithModel(
                              model: _model.requirementRowModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: RequirementRowWidget(
                                icon: Icon(Icons.water_drop_rounded,
                                    color: theme.primary, size: 20.0),
                                label: 'Watering',
                                value: plant?.waterRequirement ?? '–',
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            wrapWithModel(
                              model: _model.requirementRowModel4,
                              updateCallback: () => safeSetState(() {}),
                              child: RequirementRowWidget(
                                icon: Icon(Icons.straight_rounded,
                                    color: theme.primary, size: 20.0),
                                label: 'Spacing',
                                value: plant?.spacing != null
                                    ? '${plant!.spacing} inches apart'
                                    : '–',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // ── Growth Timeline ──────────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Growth Timeline',
                              style: theme.titleMedium.override(
                                font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold),
                                color: theme.primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                lineHeight: 1.4,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                Expanded(
                                  child: wrapWithModel(
                                    model: _model.timelineItemModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TimelineItem2Widget(
                                      label: 'Days to Harvest',
                                      value: plant?.daysToHarvest != null
                                          ? '${plant!.daysToHarvest} days'
                                          : '–',
                                      isLast: false,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: wrapWithModel(
                                    model: _model.timelineItemModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: TimelineItem2Widget(
                                      label: 'Growing Timeline',
                                      value: plant?.growingTimeline ?? '–',
                                      isLast: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // ── Companion Planting ───────────────────────────────
                    if (_goodCompanions.isNotEmpty || _avoidCompanions.isNotEmpty) ...[
                      Text(
                        'Companion Planting',
                        style: theme.titleMedium.override(
                          font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          color: theme.primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          lineHeight: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: const Color(0x1A7BA05B),
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: theme.primary),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(Icons.favorite_rounded,
                                        color: theme.primary, size: 14.0),
                                    const SizedBox(width: 4.0),
                                    Text('Good Friends',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                            color: theme.primaryText)),
                                  ]),
                                  const SizedBox(height: 8.0),
                                  _goodCompanions.isEmpty
                                      ? Text('–',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.0,
                                              color: theme.secondaryText))
                                      : Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          children: _goodCompanions
                                              .map((n) => _chipTag(
                                                  n,
                                                  theme.primary,
                                                  theme.primaryText))
                                              .toList(),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: theme.secondaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: theme.error),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Icon(Icons.warning_rounded,
                                        color: theme.error, size: 14.0),
                                    const SizedBox(width: 4.0),
                                    Text('Avoid',
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0,
                                            color: theme.primaryText)),
                                  ]),
                                  const SizedBox(height: 8.0),
                                  _avoidCompanions.isEmpty
                                      ? Text('–',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12.0,
                                              color: theme.secondaryText))
                                      : Wrap(
                                          spacing: 6.0,
                                          runSpacing: 6.0,
                                          children: _avoidCompanions
                                              .map((n) =>
                                                  _chipTag(n, theme.error, theme.error))
                                              .toList(),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],

                    // ── Expert Tips ──────────────────────────────────────
                    if ((plant?.expertTips ?? '').trim().isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0x0D6F8F72),
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                              color: const Color(0x336F8F72), width: 1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Expert Tips',
                                style: theme.titleMedium.override(
                                  font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                  color: theme.primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  lineHeight: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              ...plant!.expertTips!
                                  .trim()
                                  .split('\n')
                                  .where((l) => l.trim().isNotEmpty)
                                  .map((line) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.tips_and_updates_rounded,
                                                color: theme.primary, size: 18.0),
                                            const SizedBox(width: 8.0),
                                            Expanded(
                                              child: Text(
                                                line.trim(),
                                                style: theme.bodySmall.override(
                                                  font: GoogleFonts.poppins(),
                                                  color: theme.primaryText,
                                                  letterSpacing: 0.0,
                                                  lineHeight: 1.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 20.0),

                    // ── Why Grow This ────────────────────────────────────
                    if ((plant?.whyGrow ?? '').trim().isNotEmpty) ...[
                      Text(
                        'Why Grow This?',
                        style: theme.titleMedium.override(
                          font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                          color: theme.primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          lineHeight: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: theme.secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: theme.alternate),
                        ),
                        child: Text(
                          plant!.whyGrow!.trim(),
                          style: theme.bodyMedium.override(
                            font: GoogleFonts.poppins(),
                            color: theme.primaryText,
                            letterSpacing: 0.0,
                            lineHeight: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],

                    // ── Affiliate links ──────────────────────────────────
                    if (_purchaseLinks.isNotEmpty) ...[
                      Builder(builder: (context) {
                        final seedLinks = _purchaseLinks
                            .where((l) => l['link_type'] == 'seeds')
                            .toList();
                        final helperLinks = _purchaseLinks
                            .where((l) => l['link_type'] == 'helper')
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (seedLinks.isNotEmpty) ...[
                              Text('🌱 Buy Seeds',
                                  style: theme.titleMedium.override(
                                    font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                    color: theme.primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1.4,
                                  )),
                              const SizedBox(height: 8.0),
                              ...seedLinks.map((link) => _AffiliateLinkTile(
                                    productName: link['product_name'] ?? '',
                                    storeName: link['store_name'] ?? '',
                                    icon: Icons.storefront_outlined,
                                    accentColor: theme.primary,
                                    onTap: () =>
                                        _openLink(link['affiliate_url'] ?? ''),
                                  )),
                            ],
                            if (helperLinks.isNotEmpty) ...[
                              const SizedBox(height: 16.0),
                              Text('🛒 Recommended Helpers',
                                  style: theme.titleMedium.override(
                                    font: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold),
                                    color: theme.primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    lineHeight: 1.4,
                                  )),
                              const SizedBox(height: 8.0),
                              ...helperLinks.map((link) => _AffiliateLinkTile(
                                    productName: link['product_name'] ?? '',
                                    storeName: link['store_name'] ?? '',
                                    icon: Icons.handyman_outlined,
                                    accentColor: const Color(0xFF4A90A4),
                                    onTap: () =>
                                        _openLink(link['affiliate_url'] ?? ''),
                                  )),
                            ],
                          ],
                        );
                      }),
                      const SizedBox(height: 20.0),
                    ],

                    // ── View companion guide button ───────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(
                            CompanionGuidePage2Widget.routeName,
                            queryParameters: {
                              'plantID': serializeParam(
                                widget.plantID,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        text: 'View Companion Plants',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: theme.primary,
                          textStyle: theme.titleSmall.override(
                            font: GoogleFonts.poppins(),
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AffiliateLinkTile extends StatelessWidget {
  final String productName;
  final String storeName;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _AffiliateLinkTile({
    required this.productName,
    required this.storeName,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
                color: accentColor.withOpacity(0.3), width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6.0,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:
                    Icon(icon, color: accentColor, size: 20.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(productName,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 13.0,
                            color: FlutterFlowTheme.of(context).primaryText)),
                    if (storeName.isNotEmpty)
                      Text(storeName,
                          style: GoogleFonts.poppins(
                              fontSize: 11.0,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryText)),
                  ],
                ),
              ),
              Icon(Icons.open_in_new_rounded,
                  color: accentColor, size: 18.0),
            ],
          ),
        ),
      ),
    );
  }
}
