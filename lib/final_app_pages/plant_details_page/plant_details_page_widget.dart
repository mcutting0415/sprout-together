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
import 'plant_knowledge_base.dart';
import '/final_app_pages/plant_library_page/plant_images.dart';

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
  bool _addingToGarden = false;
  bool _addedToGarden = false;
  List<Map<String, dynamic>> _purchaseLinks = [];
  List<String> _goodCompanions = [];
  List<String> _avoidCompanions = [];
  PlantKnowledge? _knowledge;

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
          _knowledge = lookupPlantKnowledge(plant?.plantName);
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

  /// Determines watering interval in days from water_requirement text.
  int _wateringIntervalDays(String? waterReq) {
    final w = (waterReq ?? '').toLowerCase();
    if (w.contains('high')) return 2;
    if (w.contains('low to moderate') || w.contains('low to mod')) return 5;
    if (w.contains('low')) return 7;
    // default: regular / moderate
    return 3;
  }

  Future<void> _addToGarden() async {
    if (_addingToGarden || _addedToGarden) return;
    final plant = _plant;
    if (plant == null) return;

    setState(() => _addingToGarden = true);
    try {
      // Check if already added
      final existing = await SupaFlow.client
          .from('user_selected_plants')
          .select('id')
          .eq('user_id', currentUserUid)
          .eq('plant_id', plant.id!)
          .limit(1);
      if ((existing as List).isEmpty) {
        await UserSelectedPlantsTable().insert({
          'user_id': currentUserUid,
          'plant_id': plant.id!,
        });
      }
      if (!mounted) return;
      setState(() {
        _addingToGarden = false;
        _addedToGarden = true;
      });
      // Offer auto-schedule
      final shouldSchedule = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Text('✅ ${plant.plantName ?? 'Plant'} added to your grow list!',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Text(
              'Would you like to auto-schedule care tasks for this plant?',
              style: GoogleFonts.poppins(fontSize: 14.0)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text('Skip',
                  style: GoogleFonts.poppins(
                      color: FlutterFlowTheme.of(context).secondaryText)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text('Schedule',
                  style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        ),
      );

      if (shouldSchedule == true && mounted) {
        await _autoScheduleTasks(plant);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _addingToGarden = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding plant: $e'),
            backgroundColor: FlutterFlowTheme.of(context).error,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
        );
      }
    }
  }

  Future<void> _autoScheduleTasks(PlantsRow plant) async {
    try {
      // Fetch the user's most recent active garden
      final gardens = await GardensTable().queryRows(
        queryFn: (q) => q
            .eq('user_id', currentUserUid)
            .eq('is_archived', false)
            .order('created_at', ascending: false)
            .limit(1),
      );
      if (!mounted) return;
      if (gardens.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'No active garden found. Create a garden first to schedule tasks.'),
            backgroundColor: FlutterFlowTheme.of(context).secondaryText,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            duration: const Duration(seconds: 4),
          ),
        );
        return;
      }
      final gardenId = gardens.first.id!;
      final userId = currentUserUid;
      final plantName = plant.plantName ?? 'Plant';
      final today = DateTime.now();
      final tasks = <Map<String, dynamic>>[];

      // 1. Plant date task
      tasks.add({
        'task_name': 'Plant $plantName',
        'task_type': 'plant',
        'due_date': supaSerialize<DateTime>(today),
        'notes': 'Time to get $plantName in the ground!',
        'user_id': userId,
        'garden_id': gardenId,
        'completed': false,
      });

      // 2. Watering tasks — 4 weeks starting tomorrow
      final intervalDays = _wateringIntervalDays(plant.waterRequirement);
      final endDate = today.add(const Duration(days: 28));
      DateTime waterDate = today.add(Duration(days: intervalDays));
      while (!waterDate.isAfter(endDate)) {
        tasks.add({
          'task_name': 'Water $plantName',
          'task_type': 'water',
          'due_date': supaSerialize<DateTime>(waterDate),
          'notes': plant.waterRequirement ?? '',
          'user_id': userId,
          'garden_id': gardenId,
          'completed': false,
        });
        waterDate = waterDate.add(Duration(days: intervalDays));
      }

      // 3. Harvest watch task
      if (plant.daysToHarvest != null) {
        final harvestDate = today.add(Duration(days: plant.daysToHarvest!));
        tasks.add({
          'task_name': 'Check $plantName for harvest',
          'task_type': 'harvest',
          'due_date': supaSerialize<DateTime>(harvestDate),
          'notes': 'Expected harvest around ${plant.daysToHarvest} days after planting.',
          'user_id': userId,
          'garden_id': gardenId,
          'completed': false,
        });
      }

      // Batch insert all tasks
      for (final task in tasks) {
        await GardenTasksTable().insert(task);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '🌱 ${tasks.length} care tasks scheduled for $plantName!'),
            backgroundColor: FlutterFlowTheme.of(context).primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not create tasks: $e'),
            backgroundColor: FlutterFlowTheme.of(context).error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  /// Renders a knowledge section card with an icon, title, and body text.
  Widget _knowledgeCard({
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Color borderColor,
    required String title,
    required String body,
  }) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(icon, color: iconColor, size: 18.0),
                ),
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              body,
              style: GoogleFonts.poppins(
                fontSize: 13.5,
                color: theme.primaryText,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
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
                        : () {
                            final rawUrl = plant?.imageUrl ?? '';
                            // bestPlantImageUrl skips Wikipedia/Wikimedia
                            // URLs (blocked by hotlink policy) and falls back
                            // to the Unsplash map keyed by plant name.
                            final displayUrl = bestPlantImageUrl(
                              rawUrl.isNotEmpty ? rawUrl : null,
                              plant?.plantName,
                            );
                            if (displayUrl != null) {
                              return CachedNetworkImage(
                                fadeInDuration: Duration.zero,
                                fadeOutDuration: Duration.zero,
                                imageUrl: displayUrl,
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
                              );
                            }
                            return Container(
                              height: 300.0,
                              color: theme.primary.withOpacity(0.12),
                              child: const Center(
                                  child: Text('🌱',
                                      style: TextStyle(fontSize: 64.0))),
                            );
                          }(),
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

                    // ── Knowledge Base sections ──────────────────────────
                    if (_knowledge != null) ...[
                      // How & When to Harvest
                      _knowledgeCard(
                        icon: Icons.agriculture_rounded,
                        iconColor: const Color(0xFF7BA05B),
                        bgColor: const Color(0x0D7BA05B),
                        borderColor: const Color(0x337BA05B),
                        title: 'How & When to Harvest',
                        body: '🌿 Signs of Ripeness\n${_knowledge!.harvestSigns}\n\n✂️ How to Harvest\n${_knowledge!.harvestHow}',
                      ),
                      const SizedBox(height: 16.0),

                      // Best Season to Plant
                      _knowledgeCard(
                        icon: Icons.wb_sunny_rounded,
                        iconColor: const Color(0xFFE8A838),
                        bgColor: const Color(0x0DE8A838),
                        borderColor: const Color(0x33E8A838),
                        title: 'Best Season to Plant',
                        body: _knowledge!.bestSeason,
                      ),
                      const SizedBox(height: 16.0),

                      // Soil Preparation
                      _knowledgeCard(
                        icon: Icons.grass_rounded,
                        iconColor: const Color(0xFF795548),
                        bgColor: const Color(0x0D795548),
                        borderColor: const Color(0x33795548),
                        title: 'Soil Preparation',
                        body: _knowledge!.soilPrep,
                      ),
                      const SizedBox(height: 16.0),

                      // Fertilizing Guide
                      _knowledgeCard(
                        icon: Icons.science_rounded,
                        iconColor: const Color(0xFF4A90A4),
                        bgColor: const Color(0x0D4A90A4),
                        borderColor: const Color(0x334A90A4),
                        title: 'Fertilizing Guide',
                        body: _knowledge!.fertilizing,
                      ),
                      const SizedBox(height: 16.0),

                      // Common Problems
                      _knowledgeCard(
                        icon: Icons.bug_report_rounded,
                        iconColor: const Color(0xFFE57373),
                        bgColor: const Color(0x0DE57373),
                        borderColor: const Color(0x33E57373),
                        title: 'Common Problems',
                        body: _knowledge!.commonProblems,
                      ),
                      const SizedBox(height: 16.0),

                      // Storage & Use
                      _knowledgeCard(
                        icon: Icons.kitchen_rounded,
                        iconColor: const Color(0xFF9C6ADE),
                        bgColor: const Color(0x0D9C6ADE),
                        borderColor: const Color(0x339C6ADE),
                        title: 'Storage & Use',
                        body: _knowledge!.storageUse,
                      ),
                      const SizedBox(height: 20.0),
                    ],

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

                    // ── Add to Garden button ──────────────────────────────
                    if (!_loadingPlant && _plant != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52.0,
                          child: ElevatedButton.icon(
                            onPressed: _addingToGarden ? null : _addToGarden,
                            icon: _addingToGarden
                                ? const SizedBox(
                                    width: 18.0,
                                    height: 18.0,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        color: Colors.white),
                                  )
                                : Icon(
                                    _addedToGarden
                                        ? Icons.check_circle_rounded
                                        : Icons.add_circle_outline_rounded,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                            label: Text(
                              _addedToGarden
                                  ? 'Added to My Plants'
                                  : 'Add to Plants I Want to Grow',
                              style: GoogleFonts.poppins(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _addedToGarden
                                  ? const Color(0xFF4CAF50)
                                  : theme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0)),
                              elevation: 4.0,
                            ),
                          ),
                        ),
                      ),

                    const SizedBox(height: 12.0),

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
