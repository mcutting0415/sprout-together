import '/components/privacy_page_toggles_widget.dart';
import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_child7_copy_model.dart';
export 'section_card_child7_copy_model.dart';

class SectionCardChild7CopyWidget extends StatefulWidget {
  const SectionCardChild7CopyWidget({super.key});

  @override
  State<SectionCardChild7CopyWidget> createState() =>
      _SectionCardChild7CopyWidgetState();
}

class _SectionCardChild7CopyWidgetState
    extends State<SectionCardChild7CopyWidget> {
  late SectionCardChild7CopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild7CopyModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              wrapWithModel(
                model: _model.settingRowModel1,
                updateCallback: () => safeSetState(() {}),
                child: SettingRowWidget(
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 20.0,
                  ),
                  title: 'App Version',
                  subtitle: 'v2.4.0-sage',
                  isLast: false,
                ),
              ),
              wrapWithModel(
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
                ),
              ),
              wrapWithModel(
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
    );
  }
}
