import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setting_row_model.dart';
export 'setting_row_model.dart';

class SettingRowWidget extends StatefulWidget {
  const SettingRowWidget({
    super.key,
    this.icon,
    String? title,
    String? subtitle,
    bool? isLast,
  })  : this.title = title ?? 'Saved Gardens',
        this.subtitle = subtitle ?? '4 Active layouts',
        this.isLast = isLast ?? false;

  final Widget? icon;
  final String title;
  final String subtitle;
  final bool isLast;

  @override
  State<SettingRowWidget> createState() => _SettingRowWidgetState();
}

class _SettingRowWidgetState extends State<SettingRowWidget> {
  late SettingRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingRowModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Color(0x1A6F8F72),
                        borderRadius: BorderRadius.circular(12.0),
                        shape: BoxShape.rectangle,
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: widget!.icon!,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget!.title,
                              'Saved Gardens',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          if (valueOrDefault<bool>(
                            valueOrDefault<String>(
                                      widget!.subtitle,
                                      '4 Active layouts',
                                    ) !=
                                    ''
                                ? true
                                : false,
                            true,
                          ))
                            Text(
                              valueOrDefault<String>(
                                widget!.subtitle,
                                '4 Active layouts',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 20.0,
                    ),
                  ].divide(SizedBox(width: 16.0)),
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
                Divider(
                  height: 16.0,
                  thickness: 1.0,
                  indent: 0.0,
                  endIndent: 0.0,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
