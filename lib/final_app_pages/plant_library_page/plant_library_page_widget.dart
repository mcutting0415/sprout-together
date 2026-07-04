import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/final_app_pages/plant_library_card/plant_library_card_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plant_library_page_model.dart';
export 'plant_library_page_model.dart';

class PlantLibraryPageWidget extends StatefulWidget {
  const PlantLibraryPageWidget({
    super.key,
    required this.plotNumber,
    required this.gardenID,
    this.plantID,
  });

  final int? plotNumber;
  final String? gardenID;
  final String? plantID;

  static String routeName = 'PlantLibraryPage';
  static String routePath = '/plantLibraryPage';

  @override
  State<PlantLibraryPageWidget> createState() => _PlantLibraryPageWidgetState();
}

class _PlantLibraryPageWidgetState extends State<PlantLibraryPageWidget> {
  late PlantLibraryPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Set<String> _addedPlantIds = {};

  // "Wish list mode" — arriving from Planner's Add Plants button (gardenID empty)
  bool get _wishListMode =>
      (widget.gardenID == null || widget.gardenID!.isEmpty) &&
      (widget.plotNumber == null || widget.plotNumber == 0);

  Future<void> _addToWishList(BuildContext context, String plantId, String plantName) async {
    try {
      // Check if already added
      final existing = await UserSelectedPlantsTable().queryRows(
        queryFn: (q) =>
            q.eqOrNull('user_id', currentUserUid).eqOrNull('plant_id', plantId),
      );
      if (existing.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$plantName is already in your list!'),
            backgroundColor: FlutterFlowTheme.of(context).secondaryText,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }
      await UserSelectedPlantsTable().insert({
        'user_id': currentUserUid,
        'plant_id': plantId,
      });
      if (mounted) {
        setState(() => _addedPlantIds.add(plantId));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ $plantName added to your list!'),
            backgroundColor: FlutterFlowTheme.of(context).primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not add plant. Try again.')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantLibraryPageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Header
            wrapWithModel(
              model: _model.finalHeaderModel,
              updateCallback: () => safeSetState(() {}),
              child: FinalHeaderWidget(
                pageTitle: 'Plant Library',
              ),
            ),

            // Search bar
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Container(
                width: double.infinity,
                height: 56.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6.0,
                      color: Color(0x0D000000),
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 14.0),
                    Icon(
                      Icons.search_rounded,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 22.0,
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: _model.textController,
                        focusNode: _model.textFieldFocusNode,
                        autofocus: false,
                        obscureText: false,
                        onChanged: (_) => safeSetState(() {}),
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Search plants…',
                          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                ),
                                letterSpacing: 0.0,
                              ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                              ),
                              letterSpacing: 0.0,
                            ),
                        cursorColor: FlutterFlowTheme.of(context).primary,
                        validator: _model.textControllerValidator.asValidator(context),
                      ),
                    ),
                    if (_model.textController?.text.isNotEmpty == true)
                      IconButton(
                        icon: Icon(Icons.clear_rounded, size: 18.0, color: FlutterFlowTheme.of(context).secondaryText),
                        onPressed: () {
                          _model.textController?.clear();
                          safeSetState(() {});
                        },
                      ),
                  ],
                ),
              ),
            ),

            // Category chips
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Browse Categories',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 12.0),
              child: FlutterFlowChoiceChips(
                options: [
                  ChipData('All'),
                  ChipData('Vegetables'),
                  ChipData('Herbs'),
                  ChipData('Fruit'),
                  ChipData('Flowers')
                ],
                onChanged: (val) => safeSetState(() => _model.choiceChipsValue = val?.firstOrNull),
                selectedChipStyle: ChipStyle(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight),
                        color: FlutterFlowTheme.of(context).info,
                        letterSpacing: 0.0,
                      ),
                  iconColor: FlutterFlowTheme.of(context).info,
                  iconSize: 16.0,
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                unselectedChipStyle: ChipStyle(
                  backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                      ),
                  iconColor: FlutterFlowTheme.of(context).secondaryText,
                  iconSize: 16.0,
                  elevation: 0.0,
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                chipSpacing: 8.0,
                rowSpacing: 8.0,
                multiselect: false,
                alignment: WrapAlignment.start,
                controller: _model.choiceChipsValueController ??=
                    FormFieldController<List<String>>([]),
                wrapped: true,
              ),
            ),

            // Plant grid
            FutureBuilder<List<PlantsRow>>(
              future: PlantsTable().queryRows(
                queryFn: (q) {
                  final category = _model.choiceChipsValue;
                  var query = q;
                  if (category != null && category != 'All') {
                    query = query.eqOrNull('category', category);
                  }
                  return query;
                },
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
                    child: Column(
                      children: [
                        Icon(Icons.error_outline_rounded,
                            color: FlutterFlowTheme.of(context).error, size: 48.0),
                        SizedBox(height: 12.0),
                        Text(
                          'Could not load plants',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                letterSpacing: 0.0,
                              ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Please check your connection and try again.',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight),
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                final search = (_model.textController?.text ?? '').trim().toLowerCase();
                final plants = snapshot.data!
                    .where((p) =>
                        search.isEmpty ||
                        (p.plantName ?? '').toLowerCase().contains(search))
                    .toList();

                if (plants.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.0),
                    child: Column(
                      children: [
                        Icon(Icons.search_off_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText, size: 48.0),
                        SizedBox(height: 12.0),
                        Text(
                          'No plants found',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                letterSpacing: 0.0,
                              ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          'Try a different search or category',
                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight),
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemCount: plants.length,
                    itemBuilder: (context, index) {
                      final plant = plants[index];
                      final pid = plant.id ?? '';
                      final pname = plant.plantName ?? 'Plant';
                      final isAdded = _addedPlantIds.contains(pid);
                      final card = PlantLibraryCardWidget(
                        key: ValueKey(pid),
                        plantImage: plant.imageUrl ?? '',
                        plantName: pname,
                        sunRequirement: plant.sunRequirement ?? 'Full Sun',
                        waterRequirement: plant.waterRequirement ?? 'Moderate',
                        plantID: pid,
                      );
                      if (!_wishListMode) return card;
                      // Wish-list mode: overlay a "+" add button
                      return Stack(
                        children: [
                          card,
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _addToWishList(context, pid, pname),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: isAdded
                                      ? FlutterFlowTheme.of(context).primary
                                      : Colors.white.withOpacity(0.92),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  isAdded ? Icons.check_rounded : Icons.add_rounded,
                                  color: isAdded
                                      ? Colors.white
                                      : FlutterFlowTheme.of(context).primary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
