import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plant_chip_model.dart';
export 'plant_chip_model.dart';

class PlantChipWidget extends StatefulWidget {
  const PlantChipWidget({
    super.key,
    Color? tone,
    String? imgDesc,
    String? name,
  })  : this.tone = tone ?? const Color(0x00000000),
        this.imgDesc =
            imgDesc ?? 'https://dimg.dreamflow.cloud/v1/image/red%20tomato',
        this.name = name ?? 'Tomato';

  final Color tone;
  final String imgDesc;
  final String name;

  @override
  State<PlantChipWidget> createState() => _PlantChipWidgetState();
}

class _PlantChipWidgetState extends State<PlantChipWidget> {
  late PlantChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantChipModel());
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
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 0),
                  fadeOutDuration: Duration(milliseconds: 0),
                  imageUrl: valueOrDefault<String>(
                    widget!.imgDesc,
                    'https://dimg.dreamflow.cloud/v1/image/red%20tomato',
                  ),
                  width: 20.0,
                  height: 20.0,
                  fit: BoxFit.cover,
                  alignment: Alignment(0.0, 0.0),
                ),
              ),
              Text(
                valueOrDefault<String>(
                  widget!.name,
                  'Tomato',
                ),
                style: FlutterFlowTheme.of(context).labelLarge.override(
                      font: GoogleFonts.poppins(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelLarge.fontStyle,
                      lineHeight: 1.4,
                    ),
              ),
            ].divide(SizedBox(width: 4.0)),
          ),
        ),
      ),
    );
  }
}
