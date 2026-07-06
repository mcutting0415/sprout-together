import '/components/privacy_page_toggles_widget.dart';
import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'section_card_child7_model.dart';
export 'section_card_child7_model.dart';

class SectionCardChild7Widget extends StatefulWidget {
  const SectionCardChild7Widget({super.key});

  @override
  State<SectionCardChild7Widget> createState() =>
      _SectionCardChild7WidgetState();
}

class _SectionCardChild7WidgetState extends State<SectionCardChild7Widget> {
  late SectionCardChild7Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild7Model());
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
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: FlutterFlowTheme.of(context).secondaryText,
              offset: Offset(
                1.0,
                1.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).primaryText,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 0.0),
                  child: wrapWithModel(
                    model: _model.settingRowModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: SettingRowWidget(
                      icon: Icon(
                        Icons.info_outline_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                      title: 'App Version',
                      subtitle: 'v1.0.0 (42)',
                      isLast: false,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: wrapWithModel(
                    model: _model.settingRowModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: SettingRowWidget(
                      icon: Icon(
                        Icons.verified_user_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                      title: 'Privacy Policy',
                      subtitle: '',
                      isLast: false,
                      onTap: () async {
                        final uri = Uri.parse('https://sprouttogether.app/privacy-policy');
                        if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: wrapWithModel(
                    model: _model.settingRowModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: SettingRowWidget(
                      icon: Icon(
                        Icons.description_rounded,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                      title: 'Terms of Service',
                      subtitle: '',
                      isLast: true,
                      onTap: () async {
                        final uri = Uri.parse('https://sprouttogether.app/terms-of-service');
                        if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: wrapWithModel(
                    model: _model.privacyPageTogglesModel,
                    updateCallback: () => safeSetState(() {}),
                    child: PrivacyPageTogglesWidget(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
