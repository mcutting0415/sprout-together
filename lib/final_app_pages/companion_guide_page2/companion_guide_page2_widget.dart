import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/services/companion_planting_service.dart';
import '/final_app_pages/paywall/paywall_widget.dart';
import '/services/subscription_service.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'companion_guide_page2_model.dart';
export 'companion_guide_page2_model.dart';

class CompanionGuidePage2Widget extends StatefulWidget {
  const CompanionGuidePage2Widget({
    super.key,
    this.plantID,
  });

  final String? plantID;

  static String routeName = 'CompanionGuidePage2';
  static String routePath = '/companionGuidePage2';

  @override
  State<CompanionGuidePage2Widget> createState() =>
      _CompanionGuidePage2WidgetState();
}

class _CompanionGuidePage2WidgetState
    extends State<CompanionGuidePage2Widget> {
  late CompanionGuidePage2Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // All plants from DB
  List<PlantsRow> _allPlants = [];
  bool _plantsLoading = true;

  // Currently selected plant
  PlantsRow? _selectedPlant;
  List<String> _goodCompanions = [];
  List<String> _badCompanions = [];
  String? _companionTip;

  // Search
  final _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showSearch = false;

  // Toggle: true = Good, false = Bad
  bool _showGood = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompanionGuidePage2Model());
    _loadPlants();
    // Feature gate: companion guide requires premium
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isPremium = await SubscriptionService.instance.isPremium();
      if (!isPremium && mounted) {
        final subscribed = await Navigator.of(context).pushNamed(
          PaywallWidget.routeName,
        );
        if (subscribed != true && mounted) {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPlants() async {
    try {
      final plants = await PlantsTable().queryRows(
        queryFn: (q) => q.order('plant_name', ascending: true),
      );

      // Always preserve the target plant (plantID), even if duplicate name.
      // Other names are deduplicated keeping the first occurrence.
      final seen = <String>{};
      final unique = <PlantsRow>[];
      PlantsRow? targetPlant;

      // First pass: grab the target plant so it's always in the list.
      if (widget.plantID != null && widget.plantID!.isNotEmpty) {
        targetPlant =
            plants.where((p) => p.id == widget.plantID).firstOrNull;
        if (targetPlant != null) {
          seen.add((targetPlant.plantName ?? '').toLowerCase());
          unique.add(targetPlant);
        }
      }

      // Second pass: add remaining unique-named plants.
      for (final p in plants) {
        if (p.id == widget.plantID) continue; // already handled above
        final name = (p.plantName ?? '').toLowerCase();
        if (name.isNotEmpty && seen.add(name)) unique.add(p);
      }

      if (!mounted) return;
      setState(() {
        _allPlants = unique;
        _plantsLoading = false;
      });

      if (targetPlant != null) _selectPlant(targetPlant);
    } catch (_) {
      if (mounted) setState(() => _plantsLoading = false);
    }
  }

  Future<void> _selectPlant(PlantsRow plant) async {
    // Dismiss keyboard immediately when a plant is tapped.
    FocusScope.of(context).unfocus();

    // 1. Try the local companion service first (instant, offline-friendly).
    final data = CompanionPlantingService.instance
        .findCompanions(plant.plantName ?? '');

    var good = List<String>.from(data?['good'] as List? ?? []);
    var bad = List<String>.from(data?['bad'] as List? ?? []);
    var tip = data?['tip'] as String?;

    // 2. If the local service has no data for this plant, fall back to
    //    the Supabase plant_companions table (same source as the details page).
    if (good.isEmpty && bad.isEmpty && plant.id != null) {
      try {
        final response = await SupaFlow.client
            .from('plant_companions')
            .select(
                'relationship_type, related_plant:plants!related_plant_id(plant_name)')
            .eq('plant_id', plant.id!);
        for (final row
            in List<Map<String, dynamic>>.from(response as List)) {
          final name =
              (row['related_plant'] as Map?)?['plant_name'] as String? ?? '';
          if (name.isEmpty) continue;
          if (row['relationship_type'] == 'avoid') {
            bad.add(name);
          } else {
            good.add(name);
          }
        }
      } catch (_) {}
    }

    if (!mounted) return;
    setState(() {
      _selectedPlant = plant;
      _showSearch = false;
      _searchQuery = '';
      _searchController.clear();
      _goodCompanions = good;
      _badCompanions = bad;
      _companionTip = tip;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedPlant = null;
      _goodCompanions = [];
      _badCompanions = [];
      _companionTip = null;
    });
  }

  List<PlantsRow> get _filteredPlants {
    if (_searchQuery.isEmpty) return _allPlants;
    final q = _searchQuery.toLowerCase();
    return _allPlants
        .where((p) => (p.plantName ?? '').toLowerCase().contains(q))
        .toList();
  }

  List<String> get _currentCompanions =>
      _showGood ? _goodCompanions : _badCompanions;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        body: Column(
          children: [
            wrapWithModel(
              model: _model.finalHeaderModel,
              updateCallback: () => safeSetState(() {}),
              child: const FinalHeaderWidget(
                pageTitle: 'Companion Plants',
              ),
            ),
            Expanded(
              child: _plantsLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            theme.primary),
                      ),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSearchBar(theme),
                          if (_showSearch)
                            _buildSearchResults(theme)
                          else ...[
                            if (_selectedPlant == null) ...[
                              _buildInstructionCard(theme),
                              _buildBrowseGrid(theme),
                            ],
                            if (_selectedPlant != null) ...[
                              _buildSelectedPlantHeader(theme),
                              _buildToggle(theme),
                              _buildCompanionList(theme),
                              if (_companionTip != null &&
                                  _companionTip!.isNotEmpty)
                                _buildTip(theme),
                            ],
                          ],
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ── SEARCH BAR ─────────────────────────────────────────────────────────────
  Widget _buildSearchBar(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() {
          _searchQuery = v;
          _showSearch = v.isNotEmpty;
          if (v.isNotEmpty) _selectedPlant = null;
        }),
        decoration: InputDecoration(
          hintText: 'Search plants…',
          hintStyle: GoogleFonts.poppins(color: theme.secondaryText),
          prefixIcon:
              Icon(Icons.search_rounded, color: theme.secondaryText),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_rounded,
                      color: theme.secondaryText),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                      _showSearch = false;
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: theme.secondaryBackground,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: theme.alternate),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: theme.alternate),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: theme.primary, width: 1.5),
          ),
        ),
        style: GoogleFonts.poppins(color: theme.primaryText),
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  // ── INSTRUCTION CARD ───────────────────────────────────────────────────────
  Widget _buildInstructionCard(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.primary.withOpacity(0.10),
              const Color(0xFF4E7A2E).withOpacity(0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: theme.primary.withOpacity(0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: theme.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.local_florist_rounded,
                      color: theme.primary, size: 22.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Companion Planting Guide',
                        style: GoogleFonts.poppins(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryText,
                        ),
                      ),
                      Text(
                        'Grow a healthier garden, naturally',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            _buildStep(theme, '1', Icons.search_rounded,
                'Search or browse all plants below'),
            const SizedBox(height: 8.0),
            _buildStep(theme, '2', Icons.touch_app_rounded,
                'Tap any plant to see its best companions and which ones to avoid'),
            const SizedBox(height: 8.0),
            _buildStep(theme, '3', Icons.hub_outlined,
                'Tap a companion chip to explore that plant\'s relationships too'),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(
      FlutterFlowTheme theme, String step, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: theme.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: GoogleFonts.poppins(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: theme.primaryText,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  // ── BROWSE GRID ────────────────────────────────────────────────────────────
  Widget _buildBrowseGrid(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Plants',
            style: GoogleFonts.poppins(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: theme.secondaryText,
            ),
          ),
          const SizedBox(height: 6.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2.5,
            ),
            itemCount: _allPlants.length,
            itemBuilder: (context, i) {
              final plant = _allPlants[i];
              return GestureDetector(
                onTap: () => _selectPlant(plant),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: theme.alternate),
                  ),
                  child: Text(
                    plant.plantName ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 11.5, color: theme.primaryText),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── SEARCH RESULTS ─────────────────────────────────────────────────────────
  Widget _buildSearchResults(FlutterFlowTheme theme) {
    final results = _filteredPlants;
    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text('No plants found.',
              style:
                  GoogleFonts.poppins(color: theme.secondaryText)),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: results.map((plant) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 2.0),
            leading: Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: theme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.local_florist_rounded,
                  color: theme.primary, size: 18.0),
            ),
            title: Text(plant.plantName ?? 'Unknown',
                style: GoogleFonts.poppins(fontSize: 14.0)),
            onTap: () => _selectPlant(plant),
          );
        }).toList(),
      ),
    );
  }

  // ── SELECTED PLANT HEADER ──────────────────────────────────────────────────
  Widget _buildSelectedPlantHeader(FlutterFlowTheme theme) {
    final plant = _selectedPlant!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: _clearSelection,
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(Icons.arrow_back_ios_rounded,
                  color: theme.primary, size: 18.0),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              plant.plantName ?? 'Plant',
              style: GoogleFonts.poppins(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: theme.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── GOOD / BAD TOGGLE ─────────────────────────────────────────────────────
  Widget _buildToggle(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.secondaryBackground,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: theme.alternate),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _showGood = true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: _showGood
                        ? const Color(0xFF4E7A2E)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.thumb_up_rounded,
                          size: 16.0,
                          color: _showGood
                              ? Colors.white
                              : theme.secondaryText),
                      const SizedBox(width: 6.0),
                      Text(
                        'Good Companions',
                        style: GoogleFonts.poppins(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: _showGood
                              ? Colors.white
                              : theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _showGood = false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: !_showGood
                        ? const Color(0xFFD9534F)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.thumb_down_rounded,
                          size: 16.0,
                          color: !_showGood
                              ? Colors.white
                              : theme.secondaryText),
                      const SizedBox(width: 6.0),
                      Text(
                        'Plants to Avoid',
                        style: GoogleFonts.poppins(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: !_showGood
                              ? Colors.white
                              : theme.secondaryText,
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

  // ── COMPANION LIST ─────────────────────────────────────────────────────────
  Widget _buildCompanionList(FlutterFlowTheme theme) {
    final companions = _currentCompanions;
    final isGood = _showGood;
    final accentColor =
        isGood ? const Color(0xFF4E7A2E) : const Color(0xFFD9534F);

    if (companions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: theme.alternate),
          ),
          child: Column(
            children: [
              Icon(
                isGood
                    ? Icons.thumb_up_outlined
                    : Icons.thumb_down_outlined,
                color: theme.secondaryText,
                size: 32.0,
              ),
              const SizedBox(height: 8.0),
              Text(
                isGood
                    ? 'No good companions listed yet.'
                    : 'No incompatible plants listed yet.',
                style: GoogleFonts.poppins(
                    color: theme.secondaryText, fontSize: 13.0),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: companions.map((name) {
          // Capitalize each word
          final displayName = name
              .split(' ')
              .map((w) => w.isEmpty
                  ? ''
                  : w[0].toUpperCase() + w.substring(1))
              .join(' ');
          // If this companion is in the plant library, chip is tappable
          final libraryPlant = _allPlants
              .where((p) =>
                  (p.plantName ?? '').toLowerCase() ==
                  name.toLowerCase())
              .firstOrNull;
          return GestureDetector(
            onTap: libraryPlant != null
                ? () => _selectPlant(libraryPlant)
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20.0),
                border:
                    Border.all(color: accentColor.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isGood
                        ? Icons.check_circle_outline_rounded
                        : Icons.cancel_outlined,
                    color: accentColor,
                    size: 15.0,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    displayName,
                    style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                      color: theme.primaryText,
                    ),
                  ),
                  if (libraryPlant != null) ...[
                    const SizedBox(width: 4.0),
                    Icon(Icons.arrow_forward_ios_rounded,
                        size: 10.0, color: theme.secondaryText),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── GARDENER'S TIP ─────────────────────────────────────────────────────────
  Widget _buildTip(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.tertiary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: theme.tertiary.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb_outline_rounded,
                color: theme.tertiary, size: 22.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gardener\'s Tip',
                    style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: theme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    _companionTip ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: theme.primaryText,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
