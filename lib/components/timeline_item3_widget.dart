import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'timeline_item3_model.dart';
export 'timeline_item3_model.dart';

class TimelineItem3Widget extends StatefulWidget {
  const TimelineItem3Widget({
    super.key,
    bool? active,
    String? season,
    String? year,
  })  : this.active = active ?? true,
        this.season = season ?? 'WINTER',
        this.year = year ?? '2026';

  final bool active;
  final String season;
  final String year;

  @override
  State<TimelineItem3Widget> createState() => _TimelineItem3WidgetState();
}

class _TimelineItem3WidgetState extends State<TimelineItem3Widget> {
  late TimelineItem3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimelineItem3Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: valueOrDefault<Color>(
          valueOrDefault<bool>(
            widget!.active,
            true,
          )
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).secondary,
          FlutterFlowTheme.of(context).primary,
        ),
        borderRadius: BorderRadius.circular(20.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: valueOrDefault<Color>(
            valueOrDefault<bool>(
              widget!.active,
              true,
            )
                ? FlutterFlowTheme.of(context).primary
                : Colors.transparent,
            FlutterFlowTheme.of(context).primary,
          ),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                valueOrDefault<String>(
                  widget!.season,
                  'WINTER',
                ),
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      ),
                      color: valueOrDefault<Color>(
                        valueOrDefault<bool>(
                          widget!.active,
                          true,
                        )
                            ? Colors.white
                            : FlutterFlowTheme.of(context).primary,
                        Colors.white,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
              Text(
                valueOrDefault<String>(
                  widget!.year,
                  '2026',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: valueOrDefault<Color>(
                        valueOrDefault<bool>(
                          widget!.active,
                          true,
                        )
                            ? Colors.white
                            : FlutterFlowTheme.of(context).primaryText,
                        Colors.white,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ].divide(SizedBox(height: 4.0)),
          ),
        ),
      ),
    );
  }
}
