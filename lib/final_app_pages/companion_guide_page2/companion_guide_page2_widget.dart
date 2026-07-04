import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'companion_guide_page2_model.dart';
export 'companion_guide_page2_model.dart';

const _popularPlants = [
  'Basil',
  'Tomato',
  'Pepper',
  'Carrot',
  'Marigold',
  'Cucumber',
  'Rose',
  'Garlic',
];

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

class _CompanionGuidePage2WidgetState extends State<CompanionGuidePage2Widget> {
  late CompanionGuidePage2Model _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // All plants from DB
  List<PlantsRow> _allPlants = [];
  bool _plantsLoading = true;

  // Currently selected plant
  PlantsRow? _selectedPlant;

  // Search
  final _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showSearch = false;

  // Toggle: true = Good, false = Bad
  bool _showGood = true;

  // Companion data for selected plant
  List<PlantCompanionsRow> _companions = [];
  bool _companionsLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompanionGuidePage2Model());
    _loadPlants();
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
      if (!mounted) return;
      setState(() {
        _allPlants = plants;
        _plantsLoading = false;
      });

      // If a plantID was passed in, select that plant
      if (widget.plantID != null && widget.plantID!.isNotEmpty) {
        final match = plants.where((p) => p.id == widget.plantID).firstOrNull;
        if (match != null) _selectPlant(match);
      }
      // Otherwise show the search/browse UI with no plant pre-selected
    } catch (_) {
      if (mounted) setState(() => _plantsLoading = false);
    }
  }

  Future<void> _selectPlant(PlantsRow plant) async {
    setState(() {
      _selectedPlant = plant;
      _companions = [];
      _companionsLoading = true;
      _showSearch = false;
      _searchQuery = '';
      _searchController.clear();
    });
    try {
      final companions = await PlantCompanionsTable().queryRows(
        queryFn: (q) => q.eqOrNull('plant_id', plant.id),
      );
      if (!mounted) return;
      setState(() {
        _companions = companions;
        _companionsLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => _companionsLoading = false);
    }
  }

  List<PlantsRow> get _filteredPlants {
    if (_searchQuery.isEmpty) return _allPlants;
    final q = _searchQuery.toLowerCase();
    return _allPlants
        .where((p) => (p.plantName ?? '').toLowerCase().contains(q))
        .toList();
  }

  List<PlantCompanionsRow> get _filteredCompanions {
    final type = _showGood ? 'good' : 'bad';
    return _companions.where((c) => c.relationshipType == type).toList();
  }

  PlantsRow? _plantById(String? id) {
    if (id == null) return null;
    try {
      return _allPlants.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(theme),
                    if (!_showSearch) _buildPopularChips(theme),
                    if (_showSearch) _buildSearchResults(theme),
                    if (!_showSearch && _selectedPlant != null) ...[
                      _buildSelectedPlantHeader(theme),
                      _buildToggle(theme),
                      _buildCompanionList(theme),
                      _buildTip(theme),
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
        }),
        decoration: InputDecoration(
          hintText: 'Search plants…',
          hintStyle: GoogleFonts.poppins(color: theme.secondaryText),
          prefixIcon: Icon(Icons.search_rounded, color: theme.secondaryText),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear_rounded, color: theme.secondaryText),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
      ),
    );
  }

  // ── POPULAR PLANT CHIPS ────────────────────────────────────────────────────
  Widget _buildPopularChips(FlutterFlowTheme theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular',
            style: GoogleFonts.poppins(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: theme.secondaryText,
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _popularPlants.map((name) {
              final plant = _allPlants
                  .where((p) =>
                      (p.plantName ?? '').toLowerCase() == name.toLowerCase())
                  .firstOrNull;
              final isSelected =
                  _selectedPlant?.plantName?.toLowerCase() == name.toLowerCase();
              return GestureDetector(
                onTap: plant != null ? () => _selectPlant(plant) : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.primary.withOpacity(0.15)
                        : theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: isSelected
                          ? theme.primary
                          : theme.alternate,
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 13.0,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color:
                          isSelected ? theme.primary : theme.primaryText,
                    ),
                  ),
                ),
              );
            }).toList(),
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
              style: GoogleFonts.poppins(color: theme.secondaryText)),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: results.map((plant) {
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
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
      child: Text(
        plant.plantName ?? 'Plant',
        style: GoogleFonts.poppins(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: theme.primaryText,
        ),
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: _showGood
                        ? const Color(0xFF4E7A2E)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_up_rounded,
                        size: 16.0,
                        color: _showGood ? Colors.white : theme.secondaryText,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Good Companions',
                        style: GoogleFonts.poppins(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: _showGood ? Colors.white : theme.secondaryText,
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
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: !_showGood
                        ? const Color(0xFFD9534F)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.thumb_down_rounded,
                        size: 16.0,
                        color: !_showGood ? Colors.white : theme.secondaryText,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Plants to Avoid',
                        style: GoogleFonts.poppins(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color:
                              !_showGood ? Colors.white : theme.secondaryText,
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
    if (_companionsLoading) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
          ),
        ),
      );
    }

    final companions = _filteredCompanions;
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
                isGood ? Icons.thumb_up_outlined : Icons.thumb_down_outlined,
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
      child: Column(
        children: companions.map((companion) {
          final relatedPlant = _plantById(companion.relatedPlantId);
          final name = relatedPlant?.plantName ?? 'Unknown Plant';
          final reason = companion.reason;
          return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: accentColor.withOpacity(0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isGood
                        ? Icons.thumb_up_rounded
                        : Icons.thumb_down_rounded,
                    color: accentColor,
                    size: 18.0,
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                      if (reason != null && reason.isNotEmpty) ...[
                        const SizedBox(height: 4.0),
                        Text(
                          reason,
                          style: GoogleFonts.poppins(
                            fontSize: 12.0,
                            color: theme.secondaryText,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
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
                    'Companion planting works by creating a mini-ecosystem. Some plants fix nitrogen, while others act as \'trap crops\' to lure pests away from your main harvest.',
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
