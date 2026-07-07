import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/setting_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'section_card_child4_model.dart';
export 'section_card_child4_model.dart';

// Preset garden templates
const _kTemplates = [
  {
    'name': 'Herb Garden',
    'desc': '3×3 ft • Perfect for basil, parsley, cilantro',
    'width': 3,
    'length': 3,
    'type': 'In-ground',
    'icon': Icons.spa_rounded,
  },
  {
    'name': 'Raised Bed',
    'desc': '4×8 ft • Classic veggie raised bed',
    'width': 4,
    'length': 8,
    'type': 'Raised Bed',
    'icon': Icons.grid_on_rounded,
  },
  {
    'name': 'Veggie Patch',
    'desc': '6×6 ft • Room for tomatoes, peppers, squash',
    'width': 6,
    'length': 6,
    'type': 'In-ground',
    'icon': Icons.yard_rounded,
  },
  {
    'name': 'Salad Garden',
    'desc': '3×6 ft • Lettuce, spinach, radishes',
    'width': 3,
    'length': 6,
    'type': 'Raised Bed',
    'icon': Icons.eco_rounded,
  },
  {
    'name': 'Large Garden',
    'desc': '10×10 ft • Full season growing space',
    'width': 10,
    'length': 10,
    'type': 'In-ground',
    'icon': Icons.agriculture_rounded,
  },
];

class SectionCardChild4Widget extends StatefulWidget {
  const SectionCardChild4Widget({super.key});

  @override
  State<SectionCardChild4Widget> createState() =>
      _SectionCardChild4WidgetState();
}

class _SectionCardChild4WidgetState extends State<SectionCardChild4Widget> {
  late SectionCardChild4Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SectionCardChild4Model());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _showTemplates(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8.0),
              Container(
                width: 40.0, height: 4.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).alternate,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome_mosaic_rounded,
                        color: FlutterFlowTheme.of(context).primary, size: 22.0),
                    const SizedBox(width: 10.0),
                    Text('Garden Templates',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 17.0)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 12.0),
                child: Text(
                  'Start with a preset layout. A new garden will be created in your account.',
                  style: GoogleFonts.poppins(
                    fontSize: 13.0,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    height: 1.4,
                  ),
                ),
              ),
              Divider(height: 1.0, color: FlutterFlowTheme.of(context).alternate),
              Flexible(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: _kTemplates.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  itemBuilder: (context, i) {
                    final tmpl = _kTemplates[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        width: 44.0, height: 44.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Icon(tmpl['icon'] as IconData,
                            color: FlutterFlowTheme.of(context).primary, size: 22.0),
                      ),
                      title: Text(tmpl['name'] as String,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14.0)),
                      subtitle: Text(tmpl['desc'] as String,
                          style: GoogleFonts.poppins(
                              fontSize: 12.0,
                              color: FlutterFlowTheme.of(context).secondaryText)),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text('Use',
                            style: GoogleFonts.poppins(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: FlutterFlowTheme.of(context).primary)),
                      ),
                      onTap: () async {
                        Navigator.pop(ctx);
                        // Create a new garden from this template
                        try {
                          final newGarden = await GardensTable().insert({
                            'user_id': currentUserUid,
                            'garden_name': '${tmpl['name']} Garden',
                            'garden_type': tmpl['type'],
                            'width': tmpl['width'],
                            'length': tmpl['length'],
                            'is_archived': false,
                          });
                          // Create plots for the garden
                          final gardenId = newGarden.id;
                          if (gardenId != null) {
                            final w = tmpl['width'] as int;
                            final l = tmpl['length'] as int;
                            for (int r = 0; r < l; r++) {
                              for (int c = 0; c < w; c++) {
                                await GardenPlotsTable().insert({
                                  'garden_id': gardenId,
                                  'row_index': r,
                                  'col_index': c,
                                  'plant_id': null,
                                });
                              }
                            }
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('✅ ${tmpl['name']} Garden created!'),
                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                                ),
                              );
                              context.pushNamed(
                                GardenBuilderPageWidget.routeName,
                                queryParameters: {
                                  'gardenID': serializeParam(gardenId, ParamType.String),
                                }.withoutNulls,
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Could not create garden from template.'),
                                backgroundColor: FlutterFlowTheme.of(context).error,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                              ),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
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
              Icons.grid_view_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Current Gardens',
            subtitle: 'View and manage active gardens',
            isLast: false,
            onTap: () => context.pushNamed(CurrentGardens3Widget.routeName),
          ),
        ),
        wrapWithModel(
          model: _model.settingRowModel3,
          updateCallback: () => safeSetState(() {}),
          child: SettingRowWidget(
            icon: Icon(
              Icons.archive_rounded,
              color: FlutterFlowTheme.of(context).primary,
              size: 20.0,
            ),
            title: 'Past Gardens',
            subtitle: 'Browse previous seasons',
            isLast: true,
            onTap: () => context.pushNamed(PreviousGardensPage2Widget.routeName),
          ),
        ),
      ],
    );
  }
}
