import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/final_app_pages/plant_library_page/plant_images.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'plant_library_card_model.dart';
export 'plant_library_card_model.dart';

class PlantLibraryCardWidget extends StatefulWidget {
  const PlantLibraryCardWidget({
    super.key,
    String? plantImage,
    String? plantName,
    String? sunRequirement,
    String? waterRequirement,
    required this.plantID,
  })  : this.plantImage = plantImage ?? 'Use any sample plant image',
        this.plantName = plantName ?? 'Plant Name',
        this.sunRequirement = sunRequirement ?? 'Full sun',
        this.waterRequirement = waterRequirement ?? 'Moderate water';

  final String plantImage;
  final String plantName;
  final String sunRequirement;
  final String waterRequirement;
  final String? plantID;

  @override
  State<PlantLibraryCardWidget> createState() => _PlantLibraryCardWidgetState();
}

class _PlantLibraryCardWidgetState extends State<PlantLibraryCardWidget> {
  late PlantLibraryCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantLibraryCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  Widget _plantPlaceholder(BuildContext context) {
    // Pick an emoji based on the first letter so different plants get variety
    const emojis = ['🌿', '🌱', '🍃', '🌾', '🪴', '🌻', '🍅', '🥦'];
    final emojiIdx = widget.plantName.isNotEmpty
        ? widget.plantName.codeUnitAt(0) % emojis.length
        : 0;
    return Container(
      width: double.infinity,
      height: 135.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            FlutterFlowTheme.of(context).primary.withOpacity(0.12),
            FlutterFlowTheme.of(context).primary.withOpacity(0.04),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emojis[emojiIdx], style: const TextStyle(fontSize: 44.0)),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.plantName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 11.0,
                fontWeight: FontWeight.w500,
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x1A7BA05B),
        borderRadius: BorderRadius.circular(25.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0x1A7BA05B),
                borderRadius: BorderRadius.circular(30.0),
                shape: BoxShape.rectangle,
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.77),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Builder(builder: (context) {
                    // Two-stage loading:
                    // 1. Try Supabase URL (if it starts with http)
                    // 2. On error, try Unsplash fallback from the map
                    // 3. On second error (or no URL), show emoji placeholder
                    final supabaseUrl = widget.plantImage.startsWith('http')
                        ? widget.plantImage
                        : null;
                    final fallbackUrl =
                        bestPlantImageUrl(null, widget.plantName);

                    if (supabaseUrl != null) {
                      return Image.network(
                        supabaseUrl,
                        width: double.infinity,
                        height: 135.0,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => fallbackUrl != null
                            ? Image.network(
                                fallbackUrl,
                                width: double.infinity,
                                height: 135.0,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx2, err2, stack2) =>
                                    _plantPlaceholder(context),
                              )
                            : _plantPlaceholder(context),
                      );
                    } else if (fallbackUrl != null) {
                      return Image.network(
                        fallbackUrl,
                        width: double.infinity,
                        height: 135.0,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) =>
                            _plantPlaceholder(context),
                      );
                    } else {
                      return _plantPlaceholder(context);
                    }
                  }),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.plantName,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 4.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wb_sunny,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 18.0,
                    ),
                    Flexible(
                      child: Text(
                        widget.sunRequirement,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ].divide(SizedBox(width: 3.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.water_drop,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 18.0,
                    ),
                    Flexible(
                      child: Text(
                        widget.waterRequirement,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.poppins(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          PlantDetailsPageWidget.routeName,
                          queryParameters: {
                            'plantID': serializeParam(
                              widget!.plantID,
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      },
                      text: 'View Details',
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.poppins(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                          shadows: [
                            Shadow(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ].divide(SizedBox(width: 8.0)),
                ),
              ].divide(SizedBox(height: 16.0)),
            ),
          ),
        ),
        ],
      ),
    );
  }
}
