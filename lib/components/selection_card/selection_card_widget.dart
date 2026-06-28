import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'selection_card_model.dart';
export 'selection_card_model.dart';

class SelectionCardWidget extends StatefulWidget {
  const SelectionCardWidget({
    super.key,
    this.icon,
    bool? selected,
    String? title,
    String? subtitle,
  })  : this.selected = selected ?? true,
        this.title = title ?? 'Indoor',
        this.subtitle = subtitle ?? 'Pots & Windowsills';

  final Widget? icon;
  final bool selected;
  final String title;
  final String subtitle;

  @override
  State<SelectionCardWidget> createState() => _SelectionCardWidgetState();
}

class _SelectionCardWidgetState extends State<SelectionCardWidget> {
  late SelectionCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectionCardModel());
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: valueOrDefault<Color>(
            valueOrDefault<bool>(
              widget!.selected,
              true,
            )
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
            FlutterFlowTheme.of(context).primary,
          ),
          width: 2.0,
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
              widget!.icon!,
              Text(
                valueOrDefault<String>(
                  widget!.title,
                  'Indoor',
                ),
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      font: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
              Text(
                valueOrDefault<String>(
                  widget!.subtitle,
                  'Pots & Windowsills',
                ),
                maxLines: 2,
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
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
