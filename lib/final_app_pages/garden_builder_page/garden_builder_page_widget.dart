import '/backend/supabase/supabase.dart';
import '/components/plot_square/plot_square_widget.dart';
import '/draft_pages/side_menu/side_menu_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'garden_builder_page_model.dart';
export 'garden_builder_page_model.dart';
import '/services/companion_planting_service.dart';

class GardenBuilderPageWidget extends StatefulWidget {
  const GardenBuilderPageWidget({
    super.key,
    required this.gardenID,
  });

  final String? gardenID;

  static String routeName = 'GardenBuilderPage';
  static String routePath = '/gardenBuilderPage';

  @override
  State<GardenBuilderPageWidget> createState() =>
      _GardenBuilderPageWidgetState();
}

class _GardenBuilderPageWidgetState extends State<GardenBuilderPageWidget> {
  late GardenBuilderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenBuilderPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _loadPlots();
    });
  }

  final List<Map<String, dynamic>> _containers = [];

  // Combine Squares mode
  bool _combineMode = false;
  final Set<String> _combineSelectedIds = {};

  // Show companion planting info for a plot's plant
  Future<void> _showCompanionInfo(BuildContext context, String? plantId, String? plantName) async {
    if (plantId == null || plantId.isEmpty || plantName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Assign a plant to this square first.'),
          backgroundColor: FlutterFlowTheme.of(context).secondaryText,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final service = CompanionPlantingService.instance;
    final data = service.findCompanions(plantName);

    // Also get all plants currently in this garden to cross-check
    final plots = _model.gardenPlotQuery ?? [];
    final assignedPlantIds = plots
        .where((p) => p.plantId != null && p.plantId!.isNotEmpty && p.plantId != plantId)
        .map((p) => p.plantId!)
        .toSet()
        .toList();

    List<Map<String, dynamic>> gardenPlants = [];
    if (assignedPlantIds.isNotEmpty) {
      try {
        final rows = await PlantsTable().queryRows(
          queryFn: (q) => q.inFilterOrNull('id', assignedPlantIds),
        );
        gardenPlants = rows.map((r) => {
          'name': r.plantName ?? 'Unknown',
          'relationship': service.relationship(plantName, r.plantName ?? ''),
        }).toList();
      } catch (_) {}
    }

    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final good = (data?['good'] as List?)?.cast<String>() ?? [];
        final bad = (data?['bad'] as List?)?.cast<String>() ?? [];
        final tip = data?['tip'] as String?;

        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              Center(
                child: Container(
                  width: 40.0, height: 4.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).alternate,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 0.0),
                child: Row(
                  children: [
                    Icon(Icons.eco_rounded, color: FlutterFlowTheme.of(context).primary, size: 22.0),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        '$plantName Companions',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                    ),
                  ],
                ),
              ),
              if (tip != null) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('💡', style: TextStyle(fontSize: 14.0)),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(tip,
                              style: GoogleFonts.poppins(fontSize: 13.0, height: 1.5,
                                  color: FlutterFlowTheme.of(context).secondaryText)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              // Cross-check with plants already in this garden
              if (gardenPlants.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 4.0),
                  child: Text('In Your Garden',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13.0,
                          color: FlutterFlowTheme.of(context).secondaryText)),
                ),
                ...gardenPlants.map((gp) {
                  final rel = gp['relationship'] as String;
                  final icon = rel == 'good' ? '🟢' : rel == 'bad' ? '🔴' : '⚪';
                  final label = rel == 'good' ? 'Great neighbor' : rel == 'bad' ? 'Bad neighbor' : 'Neutral';
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    leading: Text(icon, style: const TextStyle(fontSize: 18.0)),
                    title: Text(gp['name'] as String,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14.0)),
                    trailing: Text(label,
                        style: GoogleFonts.poppins(fontSize: 12.0,
                            color: rel == 'good'
                                ? Colors.green.shade700
                                : rel == 'bad'
                                    ? Colors.red.shade700
                                    : FlutterFlowTheme.of(context).secondaryText)),
                  );
                }),
                Divider(color: FlutterFlowTheme.of(context).alternate, indent: 20.0, endIndent: 20.0),
              ],
              if (good.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 4.0),
                  child: Text('🟢 Good neighbors',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13.0,
                          color: Colors.green.shade700)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                  child: Text(good.map((g) => g[0].toUpperCase() + g.substring(1)).join('  •  '),
                      style: GoogleFonts.poppins(fontSize: 13.0,
                          color: FlutterFlowTheme.of(context).secondaryText)),
                ),
              ],
              if (bad.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
                  child: Text('🔴 Avoid planting near',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13.0,
                          color: Colors.red.shade700)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                  child: Text(bad.map((b) => b[0].toUpperCase() + b.substring(1)).join('  •  '),
                      style: GoogleFonts.poppins(fontSize: 13.0,
                          color: FlutterFlowTheme.of(context).secondaryText)),
                ),
              ],
              if (data == null)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('No companion planting data for $plantName yet.',
                      style: GoogleFonts.poppins(fontSize: 13.0,
                          color: FlutterFlowTheme.of(context).secondaryText)),
                ),
              const SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showAddContainerSheet() async {
    final nameController = TextEditingController();
    List<PlantsRow> allPlants = [];
    try {
      allPlants = await PlantsTable().queryRows(
        queryFn: (q) => q.order('plant_name', ascending: true),
      );
    } catch (_) {}
    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String selectedSize = 'Medium';
        String? selectedPlantId;
        String? selectedPlantName;
        String searchQuery = '';
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            final filtered = searchQuery.isEmpty
                ? allPlants
                : allPlants
                    .where((p) => (p.plantName ?? '')
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();
            return Padding(
              padding: MediaQuery.viewInsetsOf(sheetContext),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Center(
                      child: Container(
                        width: 40.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 0.0),
                      child: Row(
                        children: [
                          Icon(Icons.coffee_maker_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 20.0),
                          const SizedBox(width: 8.0),
                          Text('Add Container',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ],
                      ),
                    ),
                    Divider(
                        height: 20.0,
                        color: FlutterFlowTheme.of(context).alternate,
                        indent: 20.0,
                        endIndent: 20.0),
                    Expanded(
                      child: SingleChildScrollView(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Container Name',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText)),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'e.g. Terracotta Pot #1',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).primary,
                                        width: 1.5)),
                              ),
                              style: GoogleFonts.poppins(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText),
                            ),
                            const SizedBox(height: 16.0),
                            Text('Container Size',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText)),
                            const SizedBox(height: 8.0),
                            Wrap(
                              spacing: 8.0,
                              children:
                                  ['Small', 'Medium', 'Large', 'XL'].map((size) {
                                final isSelected = selectedSize == size;
                                return GestureDetector(
                                  onTap: () =>
                                      setSheetState(() => selectedSize = size),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF6F8F72)
                                          : FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      borderRadius:
                                          BorderRadius.circular(20.0),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF6F8F72)
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      size,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? Colors.white
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20.0),
                            Text('Assign Plant (Optional)',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText)),
                            const SizedBox(height: 8.0),
                            if (selectedPlantId != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                decoration: BoxDecoration(
                                  color: const Color(0x1A6F8F72),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: const Color(0xFF6F8F72)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.local_florist_rounded,
                                        color: Color(0xFF6F8F72), size: 14.0),
                                    const SizedBox(width: 6.0),
                                    Text(selectedPlantName ?? '',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13.0,
                                            color: const Color(0xFF6F8F72),
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 6.0),
                                    GestureDetector(
                                      onTap: () => setSheetState(() {
                                        selectedPlantId = null;
                                        selectedPlantName = null;
                                      }),
                                      child: const Icon(Icons.close,
                                          size: 14.0,
                                          color: Color(0xFF6F8F72)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            TextField(
                              onChanged: (v) =>
                                  setSheetState(() => searchQuery = v),
                              decoration: InputDecoration(
                                hintText: 'Search plants...',
                                prefixIcon:
                                    const Icon(Icons.search, size: 18.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .alternate)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).primary,
                                        width: 1.5)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10.0),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            ...filtered.map((plant) => ListTile(
                                  dense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 4.0),
                                  leading: Container(
                                    width: 32.0,
                                    height: 32.0,
                                    decoration: BoxDecoration(
                                        color: const Color(0x1A6F8F72),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: const Icon(
                                        Icons.local_florist_rounded,
                                        color: Color(0xFF6F8F72),
                                        size: 16.0),
                                  ),
                                  title: Text(plant.plantName ?? 'Unknown',
                                      style: GoogleFonts.poppins(fontSize: 13.0)),
                                  trailing: selectedPlantId == plant.id
                                      ? const Icon(Icons.check_circle_rounded,
                                          color: Color(0xFF6F8F72), size: 18.0)
                                      : null,
                                  onTap: () => setSheetState(() {
                                        selectedPlantId = plant.id;
                                        selectedPlantName = plant.plantName;
                                      }),
                                )),
                            const SizedBox(height: 24.0),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 24.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            final name = nameController.text.trim().isEmpty
                                ? 'Container ${_containers.length + 1}'
                                : nameController.text.trim();
                            safeSetState(() {
                              _containers.add({
                                'name': name,
                                'size': selectedSize,
                                'plantId': selectedPlantId,
                                'plantName': selectedPlantName,
                              });
                            });
                            Navigator.pop(sheetContext);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0)),
                          ),
                          child: Text('Add Container',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    nameController.dispose();
  }

  Widget _buildContainerCard(Map<String, dynamic> container) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: container['plantId'] != null
            ? const Color(0x1A6F8F72)
            : FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: container['plantId'] != null
              ? const Color(0xFF6F8F72)
              : FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
                color: const Color(0x1A6F8F72),
                borderRadius: BorderRadius.circular(12.0)),
            child: const Icon(Icons.coffee_maker_rounded,
                color: Color(0xFF6F8F72), size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(container['name'] as String,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 14.0)),
                Text(
                    '${container['size']} · ${container['plantName'] ?? 'No plant assigned'}',
                    style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        color: FlutterFlowTheme.of(context).secondaryText)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 18.0),
            color: FlutterFlowTheme.of(context).secondaryText,
            onPressed: () =>
                safeSetState(() => _containers.remove(container)),
          ),
        ],
      ),
    );
  }

  Future<void> _applyCombineSelected() async {
    if (_combineSelectedIds.isEmpty) return;

    // Pre-fetch plants so search doesn't flicker
    List<PlantsRow> allPlants = [];
    try {
      allPlants = await PlantsTable().queryRows(
          queryFn: (q) => q.order('plant_name', ascending: true));
    } catch (_) {}
    if (!context.mounted) return;

    PlantsRow? selectedPlant;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            final filtered = searchQuery.isEmpty
                ? allPlants
                : allPlants
                    .where((p) => (p.plantName ?? '')
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  Container(
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.grid_view_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 20.0),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            'Assign plant to ${_combineSelectedIds.length} square${_combineSelectedIds.length == 1 ? '' : 's'}',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                    child: TextField(
                      onChanged: (v) =>
                          setSheetState(() => searchQuery = v),
                      decoration: InputDecoration(
                        hintText: 'Search plants...',
                        prefixIcon: const Icon(Icons.search, size: 18.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color:
                                    FlutterFlowTheme.of(context).alternate)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.5)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 10.0),
                      ),
                    ),
                  ),
                  Divider(
                      height: 1.0,
                      color: FlutterFlowTheme.of(context).alternate),
                  Expanded(
                    child: filtered.isEmpty
                        ? Center(
                            child: Text('No plants found',
                                style: GoogleFonts.poppins(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText)))
                        : ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(vertical: 8.0),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final plant = filtered[index];
                              return ListTile(
                                leading: Container(
                                  width: 36.0,
                                  height: 36.0,
                                  decoration: BoxDecoration(
                                      color: const Color(0x1A6F8F72),
                                      borderRadius:
                                          BorderRadius.circular(8.0)),
                                  child: Icon(Icons.local_florist_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 18.0),
                                ),
                                title: Text(plant.plantName ?? 'Unknown',
                                    style:
                                        GoogleFonts.poppins(fontSize: 14.0)),
                                onTap: () {
                                  selectedPlant = plant;
                                  Navigator.of(sheetContext).pop();
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (selectedPlant == null) return;
    for (final plotId in _combineSelectedIds) {
      await GardenPlotsTable().update(
        data: {'plant_id': selectedPlant!.id},
        matchingRows: (rows) => rows.eqOrNull('id', plotId),
      );
    }
    safeSetState(() {
      _combineMode = false;
      _combineSelectedIds.clear();
    });
    await _loadPlots();
  }

  Future<void> _loadPlots() async {
    final plots = await GardenPlotsTable().queryRows(
      queryFn: (q) => q
          .eqOrNull('garden_id', widget!.gardenID)
          .order('row_index', ascending: true)
          .order('col_index', ascending: true),
    );
    safeSetState(() {
      _model.gardenPlotQuery = plots;
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<GardensRow>>(
      future: GardensTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'id',
          widget!.gardenID,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<GardensRow> gardenBuilderPageGardensRowList = snapshot.data!;

        final gardenBuilderPageGardensRow =
            gardenBuilderPageGardensRowList.isNotEmpty
                ? gardenBuilderPageGardensRowList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Stack(
              children: [
                SingleChildScrollView(
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
                          pageTitle: 'Garden Builder',
                          saveAction: () {
                            context.pushNamed('CurrentGardens3');
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0x0D6F8F72),
                            borderRadius: BorderRadius.circular(24.0),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color(0x336F8F72),
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 56.0,
                                    height: 56.0,
                                    decoration: BoxDecoration(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius: BorderRadius.circular(16.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Icon(
                                      Icons.local_florist_rounded,
                                      color: Colors.white,
                                      size: 28.0,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            gardenBuilderPageGardensRow
                                                ?.gardenName,
                                            'Loading . . .',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                font: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleMedium
                                                        .fontStyle,
                                                lineHeight: 1.4,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            gardenBuilderPageGardensRow
                                                ?.gardenType,
                                            'Loading . . .',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.poppins(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.grid_view_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 14.0,
                                            ),
                                            Text(
                                              '${gardenBuilderPageGardensRow?.width?.toString() ?? '?'} × ${gardenBuilderPageGardensRow?.length?.toString() ?? '?'} ft',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodySmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '${valueOrDefault<String>(_model.gardenPlotQuery?.length?.toString(), '0')} squares',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                  ),
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    fillColor: Colors.transparent,
                                    icon: Icon(
                                      Icons.edit_rounded,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                    onPressed: () async {
                                      final currentName = gardenBuilderPageGardensRow?.gardenName ?? '';
                                      final currentWidth = gardenBuilderPageGardensRow?.width?.toString() ?? '';
                                      final currentLength = gardenBuilderPageGardensRow?.length?.toString() ?? '';
                                      final nameController = TextEditingController(text: currentName);
                                      final widthController = TextEditingController(text: currentWidth);
                                      final lengthController = TextEditingController(text: currentLength);
                                      await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (ctx) => Padding(
                                          padding: MediaQuery.viewInsetsOf(ctx),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                              borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
                                            ),
                                            child: SafeArea(
                                              top: false,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: 40.0, height: 4.0,
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme.of(context).alternate,
                                                          borderRadius: BorderRadius.circular(2.0),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16.0),
                                                    Text('Edit Garden',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 18.0,
                                                            fontWeight: FontWeight.bold,
                                                            color: FlutterFlowTheme.of(context).primaryText)),
                                                    const SizedBox(height: 16.0),
                                                    Text('Garden Name',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w600,
                                                            color: FlutterFlowTheme.of(context).secondaryText)),
                                                    const SizedBox(height: 6.0),
                                                    TextField(
                                                      controller: nameController,
                                                      autofocus: true,
                                                      decoration: InputDecoration(
                                                        hintText: 'Garden name',
                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(12.0),
                                                          borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(12.0),
                                                          borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.5),
                                                        ),
                                                      ),
                                                      style: GoogleFonts.poppins(color: FlutterFlowTheme.of(context).primaryText),
                                                    ),
                                                    const SizedBox(height: 14.0),
                                                    Text('Dimensions (ft)',
                                                        style: GoogleFonts.poppins(
                                                            fontSize: 12.0,
                                                            fontWeight: FontWeight.w600,
                                                            color: FlutterFlowTheme.of(context).secondaryText)),
                                                    const SizedBox(height: 6.0),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextField(
                                                            controller: widthController,
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              labelText: 'Width',
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12.0),
                                                                borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12.0),
                                                                borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.5),
                                                              ),
                                                            ),
                                                            style: GoogleFonts.poppins(color: FlutterFlowTheme.of(context).primaryText),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                                          child: Text('×', style: TextStyle(fontSize: 18.0)),
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            controller: lengthController,
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              labelText: 'Length',
                                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12.0),
                                                                borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12.0),
                                                                borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.5),
                                                              ),
                                                            ),
                                                            style: GoogleFonts.poppins(color: FlutterFlowTheme.of(context).primaryText),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20.0),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          final newName = nameController.text.trim();
                                                          final newWidth = int.tryParse(widthController.text.trim()) ?? double.tryParse(widthController.text.trim())?.toInt();
                                                          final newLength = int.tryParse(lengthController.text.trim()) ?? double.tryParse(lengthController.text.trim())?.toInt();
                                                          final data = <String, dynamic>{};
                                                          if (newName.isNotEmpty) data['garden_name'] = newName;
                                                          if (newWidth != null) data['width'] = newWidth;
                                                          if (newLength != null) data['length'] = newLength;
                                                          if (data.isNotEmpty) {
                                                            await GardensTable().update(
                                                              data: data,
                                                              matchingRows: (rows) =>
                                                                  rows.eqOrNull('id', widget!.gardenID),
                                                            );
                                                          }
                                                          if (ctx.mounted) Navigator.pop(ctx);
                                                          safeSetState(() {});
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: FlutterFlowTheme.of(context).primary,
                                                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                                                        ),
                                                        child: Text('Save Changes',
                                                            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15.0)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Garden Layout',
                                  textAlign: TextAlign.start,
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 24.0,
                                ),
                                Text(
                                  'Tap a square to assign a plant',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.0,
                                    fontStyle: FontStyle.italic,
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final plotItem =
                                _model.gardenPlotQuery?.toList() ?? [];

                            if (plotItem.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Center(
                                  child: Text(
                                    'No plots yet — create a garden first.',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.poppins(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              );
                            }

                            final colCount = (gardenBuilderPageGardensRow?.width?.toInt() ?? 4).clamp(1, 8);
                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: colCount,
                                crossAxisSpacing: 6.0,
                                mainAxisSpacing: 6.0,
                                childAspectRatio: 1.0,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: plotItem.length,
                              itemBuilder: (context, plotItemIndex) {
                                final plotItemItem = plotItem[plotItemIndex];
                                final plotId = plotItemItem.id!;
                                final isSelected = _combineSelectedIds.contains(plotId);

                                final squareWidget = Container(
                                  key: ValueKey(plotItemIndex.toString()),
                                  child: wrapWithModel(
                                    model: _model.plotSquareModels.getModel(
                                      plotItemIndex.toString(),
                                      plotItemIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: PlotSquareWidget(
                                      key: Key('Keyeqt_${plotItemItem.id}'),
                                      isEmpty: plotItemItem.plantId == null ||
                                          plotItemItem.plantId!.isEmpty,
                                      icon: FaIcon(FontAwesomeIcons.seedling),
                                      gardenID: widget!.gardenID!,
                                      plotID: plotId,
                                      plantId: plotItemItem.plantId,
                                      rowIndex: plotItemItem.rowIndex!,
                                      colIndex: plotItemItem.colIndex!,
                                      onPlantAssigned: () => _loadPlots(),
                                    ),
                                  ),
                                );

                                if (!_combineMode) {
                                  // Long press shows companion planting info
                                  return GestureDetector(
                                    onLongPress: () {
                                      final plantId = plotItemItem.plantId;
                                      // Fetch plant name async, then show sheet
                                      if (plantId != null && plantId.isNotEmpty) {
                                        PlantsTable().queryRows(
                                          queryFn: (q) => q.eqOrNull('id', plantId),
                                        ).then((rows) {
                                          final name = rows.firstOrNull?.plantName;
                                          if (context.mounted) {
                                            _showCompanionInfo(context, plantId, name);
                                          }
                                        });
                                      } else {
                                        _showCompanionInfo(context, null, null);
                                      }
                                    },
                                    child: squareWidget,
                                  );
                                }

                                return GestureDetector(
                                  onTap: () {
                                    safeSetState(() {
                                      if (isSelected) {
                                        _combineSelectedIds.remove(plotId);
                                      } else {
                                        _combineSelectedIds.add(plotId);
                                      }
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      AbsorbPointer(child: squareWidget),
                                      Positioned.fill(
                                        child: AnimatedContainer(
                                          duration: const Duration(milliseconds: 150),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? const Color(0xFF6F8F72).withOpacity(0.55)
                                                : Colors.black.withOpacity(0.04),
                                            borderRadius: BorderRadius.circular(14.0),
                                            border: Border.all(
                                              color: isSelected
                                                  ? const Color(0xFF6F8F72)
                                                  : const Color(0xFF6F8F72).withOpacity(0.25),
                                              width: isSelected ? 2.5 : 1.5,
                                            ),
                                          ),
                                          child: isSelected
                                              ? const Center(child: Icon(Icons.check_circle_rounded, color: Colors.white, size: 22.0))
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 24.0, 0.0, 24.0),
                        child: Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final plots = _model.gardenPlotQuery ?? [];
                                  for (final plot in plots) {
                                    await GardenPlotsTable().update(
                                      data: {'plant_id': null},
                                      matchingRows: (rows) =>
                                          rows.eqOrNull('id', plot.id),
                                    );
                                  }
                                  await _loadPlots();
                                },
                                text: 'Clear Layout',
                                icon: FaIcon(FontAwesomeIcons.eraser, size: 15.0),
                                options: FFButtonOptions(
                                  height: 48.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.0),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () {
                                  safeSetState(() {
                                    _combineMode = !_combineMode;
                                    _combineSelectedIds.clear();
                                  });
                                },
                                text: _combineMode ? 'Cancel' : 'Combine Squares',
                                icon: Icon(
                                  _combineMode ? Icons.close : Icons.grid_view_rounded,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  height: 48.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                  color: _combineMode
                                      ? FlutterFlowTheme.of(context).error
                                      : const Color(0xFF3D7A8A),
                                  textStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.0),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_combineMode)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0.0),
                          child: _combineSelectedIds.isEmpty
                              ? Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0x1A6F8F72),
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: const Color(0x336F8F72)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.touch_app_rounded, color: Color(0xFF6F8F72), size: 18.0),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text('Tap squares to select them, then assign a plant to all at once.',
                                            style: GoogleFonts.poppins(fontSize: 12.0, color: const Color(0xFF6F8F72))),
                                      ),
                                    ],
                                  ),
                                )
                              : FFButtonWidget(
                                  onPressed: _applyCombineSelected,
                                  text: 'Assign Plant to ${_combineSelectedIds.length} Square${_combineSelectedIds.length == 1 ? '' : 's'}',
                                  icon: const Icon(Icons.local_florist_rounded, size: 15.0),
                                  options: FFButtonOptions(
                                    height: 48.0,
                                    width: double.infinity,
                                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                    color: const Color(0xFF6F8F72),
                                    textStyle: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.0),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                        ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Individual Containers',
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                            OutlinedButton.icon(
                              onPressed: _showAddContainerSheet,
                              icon: const Icon(Icons.add_rounded, size: 18.0),
                              label: Text('Add Container',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    FlutterFlowTheme.of(context).primary,
                                side: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12.0),
                              ),
                            ),
                            if (_containers.isNotEmpty)
                              ..._containers
                                  .map((c) => _buildContainerCard(c)),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(24.0),
                              shape: BoxShape.rectangle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total Plants',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '${_model.gardenPlotQuery?.where((p) => p.plantId != null && p.plantId!.isNotEmpty).length ?? 0} Assigned',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                        Container(
                                          width: 1.0,
                                          height: 32.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Available',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '${(_model.gardenPlotQuery?.length ?? 0) - (_model.gardenPlotQuery?.where((p) => p.plantId != null && p.plantId!.isNotEmpty).length ?? 0)} Spaces',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                        Container(
                                          width: 1.0,
                                          height: 32.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Dimensions',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelSmall
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelSmall
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                            Text(
                                              '${((gardenBuilderPageGardensRow?.width ?? 0) * (gardenBuilderPageGardensRow?.length ?? 0)).toStringAsFixed(0)} sq ft',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyLarge
                                                  .override(
                                                    font: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .fontStyle,
                                                    lineHeight: 1.4,
                                                  ),
                                            ),
                                          ].divide(SizedBox(height: 4.0)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 16.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                    ],
                  ),
                ),
                if (FFAppState().isSideMenuOpen)
                  wrapWithModel(
                    model: _model.sideMenuModel,
                    updateCallback: () => safeSetState(() {}),
                    child: SideMenuWidget(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
