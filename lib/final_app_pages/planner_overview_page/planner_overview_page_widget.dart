import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:convert';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'planner_overview_page_model.dart';
export 'planner_overview_page_model.dart';

class PlannerOverviewPageWidget extends StatefulWidget {
  const PlannerOverviewPageWidget({super.key});

  static String routeName = 'PlannerOverviewPage';
  static String routePath = '/plannerOverviewPage';

  @override
  State<PlannerOverviewPageWidget> createState() =>
      _PlannerOverviewPageWidgetState();
}

class _PlannerOverviewPageWidgetState extends State<PlannerOverviewPageWidget> {
  late PlannerOverviewPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Weather state
  Map<String, dynamic>? _weatherData;
  bool _weatherLoading = true;

  static String _weatherEmoji(int code) {
    if (code == 0) return '☀️';
    if (code <= 3) return '⛅';
    if (code <= 48) return '🌫️';
    if (code <= 67) return '🌧️';
    if (code <= 77) return '❄️';
    if (code <= 82) return '🌦️';
    return '⛈️';
  }

  static String _weatherDesc(int code) {
    if (code == 0) return 'Sunny';
    if (code <= 3) return 'Partly Cloudy';
    if (code <= 48) return 'Foggy';
    if (code <= 67) return 'Rainy';
    if (code <= 77) return 'Snowy';
    if (code <= 82) return 'Showers';
    return 'Thunderstorm';
  }

  static String _dayLabel(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return '';
    final now = DateTime.now();
    final diff = date.difference(DateTime(now.year, now.month, now.day)).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    return const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
  }

  Future<void> _fetchWeather() async {
    try {
      final locResp = await http.get(Uri.parse('http://ip-api.com/json')).timeout(const Duration(seconds: 5));
      final loc = json.decode(locResp.body) as Map<String, dynamic>;
      final lat = loc['lat'];
      final lon = loc['lon'];
      final city = (loc['city'] ?? 'Your Location') as String;

      final wxResp = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
        '?latitude=$lat&longitude=$lon'
        '&current=temperature_2m,weathercode'
        '&daily=temperature_2m_max,temperature_2m_min,weathercode'
        '&temperature_unit=fahrenheit&timezone=auto&forecast_days=3',
      )).timeout(const Duration(seconds: 5));
      final wx = json.decode(wxResp.body) as Map<String, dynamic>;

      if (mounted) {
        setState(() {
          _weatherData = {
            'city': city,
            'temp': (wx['current']['temperature_2m'] as num).round(),
            'code': wx['current']['weathercode'] as int,
            'daily': wx['daily'] as Map<String, dynamic>,
          };
          _weatherLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _weatherLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlannerOverviewPageModel());
    _fetchWeather();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildSummaryRow(BuildContext context, String emoji, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(emoji, style: TextStyle(fontSize: 14.0)),
            SizedBox(width: 8.0),
            Text(
              label,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.poppins(fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ],
        ),
        Text(
          value,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                color: FlutterFlowTheme.of(context).primaryText,
                fontSize: 13.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _insightBox(BuildContext context, {required Color color, required IconData icon, required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.0),
                child: Icon(icon, color: color, size: 20.0),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  text,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 13.0,
                        letterSpacing: 0.0,
                        lineHeight: 1.4,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.finalHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: FinalHeaderWidget(
                  pageTitle: 'Planner Homepage',
                ),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, -1.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Create a new garden',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primary,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        fillColor: FlutterFlowTheme.of(context).primary,
                        icon: Icon(
                          Icons.add,
                          color: FlutterFlowTheme.of(context).info,
                          size: 15.0,
                        ),
                        onPressed: () async {
                          context.pushNamed(CreateGardenPageWidget.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(CurrentGardens3Widget.routeName);
                        },
                        text: 'View Current Garden',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: 13.0,
                                letterSpacing: 0.0,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed(PreviousGardensPage2Widget.routeName);
                        },
                        text: 'View Past Gardens',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.poppins(
                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                ),
                                color: Colors.white,
                                fontSize: 13.0,
                                letterSpacing: 0.0,
                              ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '🌱 Plants I Want To Grow',
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            '🍅 Tomatoes',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
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
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            '🌿 Basil',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
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
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            '🥕 Carrots',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
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
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Text(
                            '🫑 Peppers',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
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
                        FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              PlantLibraryPageWidget.routeName,
                              queryParameters: {
                                'plotNumber': serializeParam(
                                  0,
                                  ParamType.int,
                                ),
                                'gardenID': serializeParam(
                                  '',
                                  ParamType.String,
                                ),
                                'plantID': serializeParam(
                                  '',
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: 'Add Plants',
                          icon: Icon(
                            Icons.add,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconAlignment: IconAlignment.start,
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.poppins(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Color(0x0D000000),
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.eco_rounded, color: FlutterFlowTheme.of(context).primary, size: 20.0),
                            SizedBox(width: 8.0),
                            Text(
                              'Garden Summary',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        _buildSummaryRow(context, '🌱', 'Plants Selected', '3'),
                        SizedBox(height: 8.0),
                        _buildSummaryRow(context, '☀️', 'Sun Requirements', 'Full Sun'),
                        SizedBox(height: 8.0),
                        _buildSummaryRow(context, '💧', 'Watering Schedule', 'Every 2–3 Days'),
                        SizedBox(height: 8.0),
                        _buildSummaryRow(context, '🧺', 'First Harvest', '60–80 Days'),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: _weatherLoading
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary),
                                strokeWidth: 2.0,
                              ),
                            ),
                          )
                        : _weatherData == null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Today in Your Garden...',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Weather unavailable — check your connection.',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                          font: GoogleFonts.poppins(
                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight),
                                          color: FlutterFlowTheme.of(context).secondaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              )
                            : Builder(builder: (context) {
                                final city = _weatherData!['city'] as String;
                                final temp = _weatherData!['temp'] as int;
                                final code = _weatherData!['code'] as int;
                                final daily = _weatherData!['daily'] as Map<String, dynamic>;
                                final dates = (daily['time'] as List).cast<String>();
                                final maxTemps = (daily['temperature_2m_max'] as List).cast<num>();
                                final minTemps = (daily['temperature_2m_min'] as List).cast<num>();
                                final codes = (daily['weathercode'] as List).cast<int>();
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_rounded,
                                            color: FlutterFlowTheme.of(context).primary, size: 16.0),
                                        SizedBox(width: 4.0),
                                        Text(
                                          city,
                                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                                font: GoogleFonts.poppins(
                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight),
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          _weatherEmoji(code),
                                          style: TextStyle(fontSize: 36.0),
                                        ),
                                        SizedBox(width: 12.0),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '$temp°F',
                                              style: FlutterFlowTheme.of(context).displaySmall.override(
                                                    font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              _weatherDesc(code),
                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                    font: GoogleFonts.poppins(
                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight),
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.0),
                                    Divider(color: FlutterFlowTheme.of(context).alternate, thickness: 1.0),
                                    SizedBox(height: 12.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: List.generate(dates.length.clamp(0, 3), (i) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              _dayLabel(dates[i]),
                                              style: FlutterFlowTheme.of(context).labelSmall.override(
                                                    font: GoogleFonts.poppins(
                                                        fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight),
                                                    letterSpacing: 0.0,
                                                  ),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(_weatherEmoji(codes[i]),
                                                style: TextStyle(fontSize: 22.0)),
                                            SizedBox(height: 4.0),
                                            Text(
                                              '${maxTemps[i].round()}° / ${minTemps[i].round()}°',
                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ],
                                );
                              }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                        color: Color(0x1A000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline_rounded, color: FlutterFlowTheme.of(context).primary, size: 20.0),
                          SizedBox(width: 8.0),
                          Text(
                          'Garden Insights',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Smart tips based on your plant selection — companion benefits, warnings, and care reminders.',
                        style: FlutterFlowTheme.of(context).labelMedium.override(
                              font: GoogleFonts.poppins(fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight),
                              letterSpacing: 0.0,
                            ),
                      ),
                      SizedBox(height: 16.0),
                      _insightBox(
                        context,
                        color: Color(0xFF7BA05B),
                        icon: Icons.check_circle_outline_outlined,
                        text: 'Basil improves tomato growth nearby.',
                      ),
                      _insightBox(
                        context,
                        color: Color(0xFFD9534F),
                        icon: Icons.warning_amber_rounded,
                        text: 'Potatoes may spread disease to tomatoes.',
                      ),
                      _insightBox(
                        context,
                        color: Color(0xFF4A90A4),
                        icon: Icons.water_drop,
                        text: 'Water peppers deeply tomorrow morning.',
                      ),
                      _insightBox(
                        context,
                        color: Color(0xFFE0A43A),
                        icon: Icons.wb_sunny,
                        text: 'Your garden receives ideal afternoon sunlight.',
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FFButtonWidget(
                          onPressed: () {
                            context.pushNamed(CurrentGardens3Widget.routeName);
                          },
                          text: 'View Full Garden Analysis',
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.poppins(fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ),
                ),
              ),
              // Shop CTA
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                child: InkWell(
                  onTap: () => context.pushNamed(ShopPageWidget.routeName),
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF4A90A4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Color(0xFF4A90A4).withOpacity(0.35)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.storefront_outlined, color: Color(0xFF4A90A4), size: 22.0),
                        SizedBox(width: 10.0),
                        Text(
                          'Shop Seeds, Tools & More',
                          style: FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                color: Color(0xFF4A90A4),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF4A90A4), size: 14.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Calendar CTA — full width button to avoid cutoff
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
                  child: InkWell(
                    onTap: () => context.pushNamed(GrowingCalendarWidget.routeName),
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month_rounded, color: Colors.white, size: 22.0),
                          SizedBox(width: 10.0),
                          Flexible(
                            child: Text(
                              'See Upcoming Harvests in Calendar',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
