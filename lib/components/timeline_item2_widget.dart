import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'timeline_item2_model.dart';
export 'timeline_item2_model.dart';

class TimelineItem2Widget extends StatefulWidget {
  const TimelineItem2Widget({
    super.key,
    String? label,
    String? value,
    bool? isLast,
  })  : this.label = label ?? 'Germination',
        this.value = value ?? '7-14 Days',
        this.isLast = isLast ?? false;

  final String label;
  final String value;
  final bool isLast;

  @override
  State<TimelineItem2Widget> createState() => _TimelineItem2WidgetState();
}

class _TimelineItem2WidgetState extends State<TimelineItem2Widget> {
  late TimelineItem2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimelineItem2Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget!.label,
            'Germination',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.poppins(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        Text(
          valueOrDefault<String>(
            widget!.value,
            '7-14 Days',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        if (valueOrDefault<bool>(
          valueOrDefault<bool>(
            widget!.isLast,
            false,
          )
              ? false
              : true,
          false,
        ))
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Color(0x336F8F72),
                      borderRadius: BorderRadius.circular(9999.0),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
