import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'section_card_child5_model.dart';
export 'section_card_child5_model.dart';

class SectionCardChild5Widget extends StatefulWidget {
  const SectionCardChild5Widget({super.key});

  @override
  State<SectionCardChild5Widget> createState() =>
      _SectionCardChild5WidgetState();
}

class _SectionCardChild5WidgetState extends State<SectionCardChild5Widget> {
  late SectionCardChild5Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild5Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _exportGardenData(BuildContext context) async {
    try {
      final gardens = await GardensTable().queryRows(
        queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
      );
      final lines = StringBuffer();
      lines.writeln('SproutTogether - Garden Data Export');
      lines.writeln('=====================================');
      for (final g in gardens) {
        lines.writeln('');
        lines.writeln('Garden: ${g.gardenName ?? 'Unnamed'}');
        lines.writeln('Type: ${g.gardenType ?? '—'}');
        lines.writeln('Size: ${((g.width ?? 0) * (g.length ?? 0)).toStringAsFixed(0)} sq ft');
      }
      if (gardens.isEmpty) lines.writeln('No gardens found.');
      final body = Uri.encodeComponent(lines.toString());
      final uri = Uri.parse(
          'mailto:?subject=My%20SproutTogether%20Garden%20Data&body=$body');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Could not open email app.'),
              backgroundColor: FlutterFlowTheme.of(context).error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not export data. Try again.'),
            backgroundColor: FlutterFlowTheme.of(context).error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
        );
      }
    }
  }

  void _showBackupInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Row(
          children: [
            Icon(Icons.cloud_done_rounded, color: FlutterFlowTheme.of(context).primary, size: 24.0),
            const SizedBox(width: 8.0),
            Text('Cloud Backup', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18.0)),
          ],
        ),
        content: Text(
          'Your garden data is automatically backed up to the cloud via Supabase every time you make a change.\n\nNo manual backup needed — your data is always safe and synced across devices.',
          style: GoogleFonts.poppins(fontSize: 14.0, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Got it', style: GoogleFonts.poppins(color: FlutterFlowTheme.of(context).primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showRestoreInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Row(
          children: [
            Icon(Icons.restore_rounded, color: FlutterFlowTheme.of(context).primary, size: 24.0),
            const SizedBox(width: 8.0),
            Text('Restore Data', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18.0)),
          ],
        ),
        content: Text(
          'Your data is continuously synced from the cloud. Simply log out and log back in to force a full data refresh.\n\nFor account or data issues, contact support@sprouttogether.app.',
          style: GoogleFonts.poppins(fontSize: 14.0, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close', style: GoogleFonts.poppins(color: FlutterFlowTheme.of(context).primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
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
              Icons.download_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Export Garden Data',
            subtitle: 'Email yourself a summary',
            isLast: false,
            onTap: () => _exportGardenData(context),
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel2,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.cloud_done_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Cloud Backup',
            subtitle: 'Auto-synced via Supabase',
            isLast: false,
            onTap: () => _showBackupInfo(context),
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel3,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.restore_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Restore Data',
            subtitle: 'Re-sync from the cloud',
            isLast: true,
            onTap: () => _showRestoreInfo(context),
          ),
        ),
      ],
    );
  }
}
