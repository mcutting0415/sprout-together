import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plot_square_model.dart';
export 'plot_square_model.dart';

class PlotSquareWidget extends StatefulWidget {
  const PlotSquareWidget({
    super.key,
    bool? isEmpty,
    this.icon,
    String? plantName,
    this.plantId,
    required this.gardenID,
    required this.plotID,
    required this.rowIndex,
    required this.colIndex,
    this.onPlantAssigned,
  })  : this.isEmpty = isEmpty ?? false,
        this.plantName = plantName ?? '';

  final bool isEmpty;
  final Widget? icon;
  final String plantName;
  final String? plantId;
  final String? gardenID;
  final String? plotID;
  final int? rowIndex;
  final int? colIndex;
  final VoidCallback? onPlantAssigned;

  @override
  State<PlotSquareWidget> createState() => _PlotSquareWidgetState();
}

class _PlotSquareWidgetState extends State<PlotSquareWidget> {
  late PlotSquareModel _model;
  String? _displayName;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlotSquareModel());
    if (!widget.isEmpty && widget.plantId != null && widget.plantId!.isNotEmpty) {
      _loadPlantName(widget.plantId!);
    }
  }

  @override
  void didUpdateWidget(PlotSquareWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.plantId != oldWidget.plantId) {
      if (!widget.isEmpty && widget.plantId != null && widget.plantId!.isNotEmpty) {
        _loadPlantName(widget.plantId!);
      } else {
        setState(() => _displayName = null);
      }
    }
  }

  Future<void> _loadPlantName(String plantId) async {
    try {
      final rows = await PlantsTable().querySingleRow(
        queryFn: (q) => q.eqOrNull('id', plantId),
      );
      final plant = rows.firstOrNull;
      if (mounted && plant?.plantName != null) {
        setState(() => _displayName = plant!.plantName);
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Future<void> _showPlantPicker() async {
    final bool? assigned = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
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
                    Icon(Icons.local_florist_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0),
                    const SizedBox(width: 8.0),
                    Text(
                      'Pick a Plant',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    if (!widget.isEmpty)
                      TextButton(
                        onPressed: () async {
                          await GardenPlotsTable().update(
                            data: {'plant_id': ''},
                            matchingRows: (rows) =>
                                rows.eqOrNull('id', widget.plotID),
                          );
                          Navigator.of(sheetContext).pop(true);
                        },
                        child: Text(
                          'Clear',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                font: GoogleFonts.poppins(
                                  fontWeight:
                                      FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                ),
                                color: FlutterFlowTheme.of(context).error,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
              Divider(
                  height: 1.0,
                  color: FlutterFlowTheme.of(context).alternate),
              Expanded(
                child: FutureBuilder<List<PlantsRow>>(
                  future: PlantsTable().queryRows(
                    queryFn: (q) => q.order('plant_name', ascending: true),
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      );
                    }
                    final plants = snapshot.data!;
                    if (plants.isEmpty) {
                      return Center(
                        child: Text(
                          'No plants in library yet.',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: plants.length,
                      itemBuilder: (context, index) {
                        final plant = plants[index];
                        return ListTile(
                          leading: Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: BoxDecoration(
                              color: Color(0x1A6F8F72),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              Icons.local_florist_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 18.0,
                            ),
                          ),
                          title: Text(
                            plant.plantName ?? 'Unknown Plant',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                ),
                          ),
                          onTap: () async {
                            await GardenPlotsTable().update(
                              data: {'plant_id': plant.id},
                              matchingRows: (rows) =>
                                  rows.eqOrNull('id', widget.plotID),
                            );
                            if (mounted) {
                              setState(() => _displayName = plant.plantName);
                            }
                            Navigator.of(sheetContext).pop(true);
                          },
                        );
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

    if (assigned == true) {
      widget.onPlantAssigned?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        await _showPlantPicker();
      },
      child: Container(
        width: 64.0,
        height: 64.0,
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            valueOrDefault<bool>(
              widget!.isEmpty,
              false,
            )
                ? FlutterFlowTheme.of(context).secondaryBackground
                : Color(0x1A6F8F72),
            Color(0x1A6F8F72),
          ),
          borderRadius: BorderRadius.circular(16.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: valueOrDefault<Color>(
              widget!.isEmpty ? Color(0xFFD8D2CB) : Color(0xFF6F8F72),
              Color(0x4D6F8F72),
            ),
            width: 1.0,
          ),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: widget!.isEmpty
            ? Icon(
                Icons.add,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget!.icon!,
                  Text(
                    valueOrDefault<String>(
                      _displayName ?? widget.plantName,
                      'Plant',
                    ),
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontStyle,
                          lineHeight: 1.4,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ].divide(SizedBox(height: 4.0)),
              ),
      ),
    );
  }
}
