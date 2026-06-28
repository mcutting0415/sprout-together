import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'relationship_card_model.dart';
export 'relationship_card_model.dart';

class RelationshipCardWidget extends StatefulWidget {
  const RelationshipCardWidget({
    super.key,
    Color? tone,
    this.icon,
    String? name,
    String? reason,
  })  : this.tone = tone ?? const Color(0x00000000),
        this.name = name ?? 'Basil',
        this.reason =
            reason ?? 'Improves flavor and repels hornworms and flies.';

  final Color tone;
  final Widget? icon;
  final String name;
  final String reason;

  @override
  State<RelationshipCardWidget> createState() => _RelationshipCardWidgetState();
}

class _RelationshipCardWidgetState extends State<RelationshipCardWidget> {
  late RelationshipCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RelationshipCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        width: 300.0,
        height: 115.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(24.0),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: valueOrDefault<Color>(
                          widget!.tone,
                          FlutterFlowTheme.of(context).success,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: widget!.icon!,
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget!.name,
                        'Basil',
                      ),
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
                Text(
                  valueOrDefault<String>(
                    widget!.reason,
                    'Improves flavor and repels hornworms and flies.',
                  ),
                  maxLines: 3,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.poppins(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        lineHeight: 1.4,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ].divide(SizedBox(height: 8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
