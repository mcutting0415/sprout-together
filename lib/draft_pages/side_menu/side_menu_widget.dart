import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'side_menu_model.dart';
export 'side_menu_model.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  late SideMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SideMenuModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Widget _buildNavRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(icon,
                      color: FlutterFlowTheme.of(context).primary, size: 18.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 18.0),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 1.0,
            color: FlutterFlowTheme.of(context).alternate,
            indent: 16.0,
            endIndent: 16.0,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Visibility(
      visible: FFAppState().isGardenDetailOpen,
      child: Align(
        alignment: AlignmentDirectional(1.0, -1.0),
        child: Material(
          color: Colors.transparent,
          elevation: 16.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0.0),
              bottomRight: Radius.circular(0.0),
              topLeft: Radius.circular(24.0),
              bottomLeft: Radius.circular(24.0),
            ),
          ),
          child: Container(
            width: 280.0,
            constraints: const BoxConstraints(minHeight: double.infinity),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                bottomLeft: Radius.circular(24.0),
              ),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 12.0, 16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: const Icon(Icons.yard_rounded,
                              color: Colors.white, size: 20.0),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            'Garden Menu',
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 20.0),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                      height: 1.0,
                      color: FlutterFlowTheme.of(context).alternate),

                  // Navigation items
                  Container(
                    margin: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 0.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate),
                    ),
                    child: Column(
                      children: [
                        _buildNavRow(
                          icon: Icons.calendar_month_rounded,
                          label: 'Growing Calendar',
                          onTap: () {
                            Navigator.pop(context);
                            context.pushNamed('GrowingCalendar');
                          },
                        ),
                        _buildNavRow(
                          icon: Icons.grid_view_rounded,
                          label: 'Current Gardens',
                          onTap: () {
                            Navigator.pop(context);
                            context.pushNamed('CurrentGardens3');
                          },
                        ),
                        _buildNavRow(
                          icon: Icons.archive_rounded,
                          label: 'Archive',
                          onTap: () {
                            Navigator.pop(context);
                            context.pushNamed('PreviousGardensPage2');
                          },
                          isLast: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  // Plants in garden card
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                16.0, 14.0, 16.0, 8.0),
                            child: Text(
                              'Plants In Garden',
                              style: GoogleFonts.poppins(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ),
                          Divider(
                              height: 1.0,
                              color: FlutterFlowTheme.of(context).alternate,
                              indent: 16.0,
                              endIndent: 16.0),
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              shrinkWrap: true,
                              children: const [],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
