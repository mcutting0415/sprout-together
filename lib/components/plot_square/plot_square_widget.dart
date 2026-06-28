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
    required this.gardenID,
    required this.plotID,
    required this.rowIndex,
    required this.colIndex,
  })  : this.isEmpty = isEmpty ?? false,
        this.plantName = plantName ?? 'Tomato';

  final bool isEmpty;
  final Widget? icon;
  final String plantName;
  final String? gardenID;
  final String? plotID;
  final int? rowIndex;
  final int? colIndex;

  @override
  State<PlotSquareWidget> createState() => _PlotSquareWidgetState();
}

class _PlotSquareWidgetState extends State<PlotSquareWidget> {
  late PlotSquareModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlotSquareModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        _model.isSelected = !_model.isSelected;
        safeSetState(() {});
        if (_model.isSelected == true) {
          FFAppState().addToSelectedPlotIDs(widget!.plotID!);
          safeSetState(() {});
        } else {
          FFAppState().removeFromSelectedPlotIDs(widget!.plotID!);
          safeSetState(() {});
        }
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
              _model.isSelected ? Color(0xFFD4E8C4) : Color(0xFFD8D2CB),
              Color(0x4D6F8F72),
            ),
            width: 1.0,
          ),
        ),
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Visibility(
          visible: valueOrDefault<bool>(
            valueOrDefault<bool>(
              widget!.isEmpty,
              false,
            )
                ? false
                : true,
            true,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget!.isEmpty)
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Icon(
                    Icons.add,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                ),
              if (!widget!.isEmpty) widget!.icon!,
              if (!widget!.isEmpty)
                Text(
                  valueOrDefault<String>(
                    widget!.plantName,
                    'Tomato',
                  ),
                  maxLines: 1,
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelSmall
                              .fontWeight,
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
      ),
    );
  }
}
