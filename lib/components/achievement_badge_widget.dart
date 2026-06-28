import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'achievement_badge_model.dart';
export 'achievement_badge_model.dart';

class AchievementBadgeWidget extends StatefulWidget {
  const AchievementBadgeWidget({
    super.key,
    bool? unlocked,
    this.icon,
    String? label,
  })  : this.unlocked = unlocked ?? false,
        this.label = label ?? 'First Garden';

  final bool unlocked;
  final Widget? icon;
  final String label;

  @override
  State<AchievementBadgeWidget> createState() => _AchievementBadgeWidgetState();
}

class _AchievementBadgeWidgetState extends State<AchievementBadgeWidget> {
  late AchievementBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AchievementBadgeModel());
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              valueOrDefault<bool>(
                widget!.unlocked,
                false,
              )
                  ? Color(0x336F8F72)
                  : FlutterFlowTheme.of(context).secondaryBackground,
              Color(0x00000000),
            ),
            borderRadius: BorderRadius.circular(9999.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: valueOrDefault<Color>(
                valueOrDefault<bool>(
                  widget!.unlocked,
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
          child: widget!.icon!,
        ),
        Text(
          valueOrDefault<String>(
            widget!.label,
            'First Garden',
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.poppins(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: valueOrDefault<Color>(
                  valueOrDefault<bool>(
                    widget!.unlocked,
                    false,
                  )
                      ? FlutterFlowTheme.of(context).primaryText
                      : FlutterFlowTheme.of(context).accent3,
                  Color(0x00000000),
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
