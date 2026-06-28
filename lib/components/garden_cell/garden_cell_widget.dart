import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'garden_cell_model.dart';
export 'garden_cell_model.dart';

class GardenCellWidget extends StatefulWidget {
  const GardenCellWidget({
    super.key,
    bool? selected,
    Color? tone,
    this.iconName,
    String? plant,
  })  : this.selected = selected ?? false,
        this.tone = tone ?? const Color(0x00000000),
        this.plant = plant ?? 'Tomatoes';

  final bool selected;
  final Color tone;
  final Widget? iconName;
  final String plant;

  @override
  State<GardenCellWidget> createState() => _GardenCellWidgetState();
}

class _GardenCellWidgetState extends State<GardenCellWidget> {
  late GardenCellModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GardenCellModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          color: valueOrDefault<Color>(
            valueOrDefault<bool>(
              widget!.selected,
              false,
            )
                ? Color(0x1A6F8F72)
                : Color(0x00000000),
            Color(0x00000000),
          ),
          borderRadius: BorderRadius.circular(16.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: valueOrDefault<Color>(
              valueOrDefault<bool>(
                widget!.selected,
                false,
              )
                  ? FlutterFlowTheme.of(context).primary
                  : FlutterFlowTheme.of(context).alternate,
              Color(0x00000000),
            ),
            width: 2.0,
          ),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget!.iconName!,
            if (valueOrDefault<bool>(
              valueOrDefault<String>(
                        widget!.plant,
                        'Tomatoes',
                      ) !=
                      ''
                  ? true
                  : false,
              true,
            ))
              Text(
                valueOrDefault<String>(
                  widget!.plant,
                  'Tomatoes',
                ),
                maxLines: 1,
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
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
