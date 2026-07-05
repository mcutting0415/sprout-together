import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'section_card_child6_model.dart';
export 'section_card_child6_model.dart';

class SectionCardChild6Widget extends StatefulWidget {
  const SectionCardChild6Widget({super.key});

  @override
  State<SectionCardChild6Widget> createState() =>
      _SectionCardChild6WidgetState();
}

class _SectionCardChild6WidgetState extends State<SectionCardChild6Widget> {
  late SectionCardChild6Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild6Model());
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        wrapWithModel(
          model: _model.settingRowModel1,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.help_outline_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Help Center',
            subtitle: 'Chat or email our team',
            isLast: false,
            onTap: () async {
              final uri = Uri.parse('mailto:support@sprouttogether.app?subject=Help%20Request');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel2,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.forum_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Frequently Asked Questions',
            subtitle: 'Common questions answered',
            isLast: false,
            onTap: () => context.pushNamed(CommonQuestionsPageWidget.routeName),
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel3,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.mail_outline_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Contact Support',
            subtitle: 'Email us anytime',
            isLast: false,
            onTap: () async {
              final uri = Uri.parse('mailto:support@sprouttogether.app?subject=Support%20Request');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel4,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.rate_review_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Submit Feedback',
            subtitle: 'Help us improve',
            isLast: true,
            onTap: () async {
              final uri = Uri.parse('mailto:feedback@sprouttogether.app?subject=App%20Feedback');
              if (await canLaunchUrl(uri)) await launchUrl(uri);
            },
          ),
        ),
      ],
    );
  }
}
