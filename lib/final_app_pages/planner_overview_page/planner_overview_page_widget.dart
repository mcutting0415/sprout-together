import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'planner_overview_page_model.dart';
export 'planner_overview_page_model.dart';
import '/services/notification_service.dart';
import '/final_app_pages/paywall/paywall_widget.dart';
import '/services/subscription_service.dart';

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

  // Selected plants state
  List<Map<String, dynamic>> _selectedPlants = [];
  bool _plantsLoading = true;
  bool _scheduling = false;

  // All plants (for add-plants popup)
  List<PlantsRow> _allPlants = [];

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

  /// Returns weather-based planting suggestions for today.
  List<Map<String, String>> _getWeatherSuggestions(int temp, int weatherCode) {
    final suggestions = <Map<String, String>>[];
    final isRainy = weatherCode >= 51 && weatherCode <= 82;
    final isStormy = weatherCode >= 95;
    final isFreezing = temp < 32;
    final isCold = temp < 50;
    final isCool = temp >= 50 && temp < 65;
    final isWarm = temp >= 65 && temp < 85;
    final isHot = temp >= 85;

    if (isStormy) {
      suggestions.add({'icon': '⛈️', 'text': 'Storm incoming — skip outdoor work today.'});
    } else if (isRainy) {
      suggestions.add({'icon': '🌧️', 'text': 'Rain today — no need to water your garden.'});
      suggestions.add({'icon': '🌱', 'text': 'Good day to transplant seedlings — rain helps them settle.'});
    }

    if (isFreezing) {
      suggestions.add({'icon': '🥶', 'text': 'Freezing temps — cover frost-sensitive plants tonight.'});
    } else if (isCold) {
      suggestions.add({'icon': '❄️', 'text': 'Too cold for warm-season crops. Focus on kale, spinach, or peas.'});
    } else if (isCool) {
      suggestions.add({'icon': '🥗', 'text': 'Great conditions for cool-season crops: lettuce, broccoli, carrots.'});
    } else if (isWarm) {
      suggestions.add({'icon': '🍅', 'text': 'Perfect planting weather for tomatoes, peppers, and cucumbers.'});
      if (!isRainy) suggestions.add({'icon': '💧', 'text': 'Warm and dry — water deeply at the base of plants.'});
    } else if (isHot) {
      suggestions.add({'icon': '☀️', 'text': 'Heat wave — water in the morning and mulch to retain moisture.'});
      suggestions.add({'icon': '🌿', 'text': 'Avoid transplanting in peak heat. Wait for evening or a cooler day.'});
    }

    // Match against user's selected plants
    if (_wantToGrow.isNotEmpty && isWarm && !isRainy) {
      final warmPlants = _wantToGrow.where((p) {
        final name = (p['plant_name'] as String? ?? '').toLowerCase();
        const warmKeywords = ['tomato', 'pepper', 'cucumber', 'squash', 'basil', 'eggplant', 'bean', 'corn'];
        return warmKeywords.any((k) => name.contains(k));
      }).toList();
      if (warmPlants.isNotEmpty) {
        suggestions.add({'icon': '🌟', 'text': 'Good week to plant ${warmPlants.first['plant_name']}!'});
      }
    }

    if (suggestions.isEmpty) {
      suggestions.add({'icon': '🌱', 'text': 'Mild conditions — a good day to check on your garden.'});
    }
    return suggestions;
  }

  Future<void> _fetchWeather() async {
    try {
      double? lat;
      double? lon;
      String city = 'Your Location';

      // Try GPS first
      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }
        if (permission == LocationPermission.whileInUse ||
            permission == LocationPermission.always) {
          final pos = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.low,
              timeLimit: Duration(seconds: 8),
            ),
          );
          lat = pos.latitude;
          lon = pos.longitude;
          // Reverse-geocode city name via open-meteo geocoding isn't available;
          // use ip-api just for city name after we have coords
          try {
            final nameResp = await http
                .get(Uri.parse(
                    'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json'))
                .timeout(const Duration(seconds: 5));
            final nameData = json.decode(nameResp.body) as Map<String, dynamic>;
            final address = nameData['address'] as Map<String, dynamic>?;
            city = (address?['city'] ??
                    address?['town'] ??
                    address?['village'] ??
                    address?['county'] ??
                    'Your Location') as String;
          } catch (_) {}
        }
      } catch (_) {}

      // Fall back to user's zip code (from onboarding) if GPS not available
      if (lat == null || lon == null) {
        try {
          final profiles = await ProfilesTable().queryRows(
            queryFn: (q) => q.eqOrNull('id', currentUserUid),
          );
          final zipCode = profiles.firstOrNull?.zipCode;
          if (zipCode != null && zipCode.isNotEmpty) {
            final geoResp = await http
                .get(Uri.parse(
                    'https://nominatim.openstreetmap.org/search?postalcode=${Uri.encodeComponent(zipCode)}&country=us&format=json&limit=1'))
                .timeout(const Duration(seconds: 5));
            final geoData = json.decode(geoResp.body) as List<dynamic>;
            if (geoData.isNotEmpty) {
              final place = geoData.first as Map<String, dynamic>;
              lat = double.tryParse(place['lat'] as String? ?? '');
              lon = double.tryParse(place['lon'] as String? ?? '');
              city = (place['display_name'] as String? ?? 'Your Location')
                  .split(',')
                  .first
                  .trim();
            }
          }
        } catch (_) {}
      }

      // Last resort: IP geolocation
      if (lat == null || lon == null) {
        final locResp = await http
            .get(Uri.parse('http://ip-api.com/json'))
            .timeout(const Duration(seconds: 5));
        final loc = json.decode(locResp.body) as Map<String, dynamic>;
        lat = (loc['lat'] as num).toDouble();
        lon = (loc['lon'] as num).toDouble();
        city = (loc['city'] ?? 'Your Location') as String;
      }

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
    _loadSelectedPlants();
    _loadAllPlants();
  }

  Future<void> _loadAllPlants() async {
    try {
      final plants = await PlantsTable().queryRows(
        queryFn: (q) => q.order('plant_name'),
      );
      if (mounted) setState(() => _allPlants = plants);
    } catch (_) {}
  }

  Future<void> _showAddPlantsSheet(BuildContext context) async {
    final selectedIds = _selectedPlants.map((p) => p['plant_id'] as String? ?? '').toSet();
    String searchQuery = '';

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            final plants = _allPlants;
            final filtered = searchQuery.isEmpty
                ? plants
                : plants.where((p) => (p.plantName ?? '').toLowerCase().contains(searchQuery.toLowerCase())).toList();
            return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8.0),
                  Container(
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Icon(Icons.local_florist_rounded,
                            color: FlutterFlowTheme.of(context).primary, size: 20.0),
                        const SizedBox(width: 8.0),
                        Text(
                          'Add Plants to My List',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                    child: TextField(
                      onChanged: (v) => setSheetState(() => searchQuery = v),
                      decoration: InputDecoration(
                        hintText: 'Search plants...',
                        prefixIcon: const Icon(Icons.search, size: 18.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                      ),
                    ),
                  ),
                  Divider(height: 1.0, color: FlutterFlowTheme.of(context).alternate),
                  Expanded(
                    child: filtered.isEmpty
                        ? Center(
                            child: Text('No plants found',
                                style: GoogleFonts.poppins(color: FlutterFlowTheme.of(context).secondaryText)))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final plant = filtered[index];
                              final pid = plant.id ?? '';
                              final alreadyAdded = selectedIds.contains(pid);
                              return ListTile(
                                leading: Container(
                                  width: 36.0,
                                  height: 36.0,
                                  decoration: BoxDecoration(
                                    color: alreadyAdded
                                        ? FlutterFlowTheme.of(context).primary.withOpacity(0.15)
                                        : const Color(0x1A6F8F72),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Icon(
                                    alreadyAdded ? Icons.check_rounded : Icons.local_florist_rounded,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 18.0,
                                  ),
                                ),
                                title: Text(plant.plantName ?? 'Unknown',
                                    style: GoogleFonts.poppins(fontSize: 14.0)),
                                trailing: alreadyAdded
                                    ? Text('Added',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.0,
                                            color: FlutterFlowTheme.of(context).secondaryText))
                                    : null,
                                onTap: alreadyAdded
                                    ? null
                                    : () async {
                                        try {
                                          await UserSelectedPlantsTable().insert({
                                            'user_id': currentUserUid,
                                            'plant_id': pid,
                                          });
                                          setSheetState(() => selectedIds.add(pid));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('${plant.plantName} added to your list!'),
                                              backgroundColor: FlutterFlowTheme.of(context).primary,
                                              behavior: SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12.0)),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        } catch (_) {}
                                      },
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    // Reload the plant list after the sheet closes
    _loadSelectedPlants();
  }

  Future<void> _loadSelectedPlants() async {
    setState(() => _plantsLoading = true);
    try {
      final selected = await UserSelectedPlantsTable().queryRows(
        queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
      );
      if (selected.isEmpty) {
        if (mounted) setState(() { _selectedPlants = []; _plantsLoading = false; });
        return;
      }
      final plantIds = selected.map((r) => r.plantId).toList();
      final plants = await PlantsTable().queryRows(
        queryFn: (q) => q.inFilterOrNull('id', plantIds),
      );
      final plantsById = {for (final p in plants) p.id: p};
      final joined = selected.map((r) {
        final plant = plantsById[r.plantId];
        return {
          'id': r.id,
          'plant_id': r.plantId,
          'plant_name': plant?.plantName ?? 'Unknown Plant',
          'category': plant?.category ?? '',
          'days_to_harvest': plant?.daysToHarvest,
          'sun_requirement': plant?.sunRequirement,
          'water_requirement': plant?.waterRequirement,
          'season': r.season,
        };
      }).toList();
      if (mounted) setState(() { _selectedPlants = joined; _plantsLoading = false; });
    } catch (_) {
      if (mounted) setState(() => _plantsLoading = false);
    }
  }

  // Plants still on the "want to grow" list
  List<Map<String, dynamic>> get _wantToGrow =>
      _selectedPlants.where((p) => (p['season'] as String?) != 'planted').toList();

  // Plants marked as planted
  List<Map<String, dynamic>> get _plantedList =>
      _selectedPlants.where((p) => (p['season'] as String?) == 'planted').toList();

  Future<void> _removePlant(Map<String, dynamic> plant) async {
    final rowId = plant['id'] as String?;
    if (rowId == null) return;
    try {
      await UserSelectedPlantsTable().delete(
        matchingRows: (q) => q.eqOrNull('id', rowId),
      );
      if (mounted) {
        setState(() => _selectedPlants.removeWhere((p) => p['id'] == rowId));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${plant['plant_name']} removed'),
          backgroundColor: FlutterFlowTheme.of(context).secondaryText,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          duration: const Duration(seconds: 2),
        ));
      }
    } catch (_) {}
  }

  Future<void> _markAsPlanted(Map<String, dynamic> plant) async {
    final rowId = plant['id'] as String?;
    if (rowId == null) return;
    try {
      await UserSelectedPlantsTable().update(
        data: {'season': 'planted'},
        matchingRows: (q) => q.eqOrNull('id', rowId),
      );
      if (mounted) {
        setState(() {
          final idx = _selectedPlants.indexWhere((p) => p['id'] == rowId);
          if (idx != -1) _selectedPlants[idx] = {..._selectedPlants[idx], 'season': 'planted'};
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${plant['plant_name']} marked as planted! 🌱'),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          duration: const Duration(seconds: 2),
        ));
      }
    } catch (_) {}
  }

  Future<void> _unmarkAsPlanted(Map<String, dynamic> plant) async {
    final rowId = plant['id'] as String?;
    if (rowId == null) return;
    try {
      await UserSelectedPlantsTable().update(
        data: {'season': null},
        matchingRows: (q) => q.eqOrNull('id', rowId),
      );
      if (mounted) {
        setState(() {
          final idx = _selectedPlants.indexWhere((p) => p['id'] == rowId);
          if (idx != -1) _selectedPlants[idx] = {..._selectedPlants[idx], 'season': null};
        });
      }
    } catch (_) {}
  }

  /// Returns the optimal planting date for a plant based on its type and days_to_harvest.
  DateTime _getPlantingDate(String? category, String? plantName, int? daysToHarvest) {
    final now = DateTime.now();
    final name = (plantName ?? '').toLowerCase();

    // Cool season crops — can grow in cold weather
    const coolKeywords = [
      'lettuce', 'spinach', 'kale', 'broccoli', 'cauliflower', 'cabbage',
      'carrot', 'radish', 'pea', 'chard', 'arugula', 'bok choy', 'cilantro',
      'parsley', 'dill', 'beet', 'turnip', 'kohlrabi', 'mustard', 'collard',
    ];
    final isCool = coolKeywords.any((k) => name.contains(k));

    if (!isCool) {
      // Warm season — plant after last frost (May 1 target for US)
      final warmTarget = DateTime(now.year, 5, 1);
      if (now.isBefore(warmTarget)) return warmTarget;
      // Still plantable through June 30
      if (now.isBefore(DateTime(now.year, 6, 30))) {
        return DateTime(now.year, now.month, now.day).add(const Duration(days: 7));
      }
      // Too late this year, schedule next spring
      return DateTime(now.year + 1, 5, 1);
    } else {
      // Cool season: spring window = March 15, fall window = Aug 1
      final springTarget = DateTime(now.year, 3, 15);
      final fallTarget = DateTime(now.year, 8, 1);
      final fallEnd = DateTime(now.year, 9, 30);

      if (now.isBefore(springTarget)) return springTarget;
      if (now.isBefore(fallTarget)) return fallTarget;
      if (now.isBefore(fallEnd)) {
        return DateTime(now.year, now.month, now.day).add(const Duration(days: 7));
      }
      return DateTime(now.year + 1, 3, 15);
    }
  }

  Future<void> _autoSchedulePlantingTasks() async {
    if (_wantToGrow.isEmpty) return;
    setState(() => _scheduling = true);
    int created = 0;
    try {
      // Fetch the user's first garden — garden_id is required (NOT NULL)
      final gardens = await GardensTable().queryRows(
        queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
      );
      final gardenId = gardens.firstOrNull?.id;
      if (gardenId == null) {
        if (mounted) {
          setState(() => _scheduling = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Create a garden first before scheduling tasks.'),
              backgroundColor: FlutterFlowTheme.of(context).error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          );
        }
        return;
      }
      final gardenName = gardens.firstOrNull?.gardenName ?? 'your garden';
      final toSchedule = _wantToGrow;
      for (int i = 0; i < toSchedule.length; i++) {
        final plant = toSchedule[i];
        final plantDate = _getPlantingDate(
          plant['category'] as String?,
          plant['plant_name'] as String?,
          plant['days_to_harvest'] as int?,
        );
        await GardenTasksTable().insert({
          'user_id': currentUserUid,
          'garden_id': gardenId,
          'task_name': 'Plant ${plant['plant_name']}',
          'task_type': 'Plant',
          'due_date': plantDate.toIso8601String(),
          'completed': false,
          'notes': 'Auto-scheduled based on growing season.',
        });
        // Schedule push notification 1 day before
        await NotificationService.instance.scheduleTaskNotification(
          notificationId: DateTime.now().millisecondsSinceEpoch % 100000 + i,
          taskName: 'Plant ${plant['plant_name']}',
          dueDate: plantDate,
          gardenName: gardenName,
        );
        created++;
      }
    } catch (_) {}
    if (mounted) {
      setState(() => _scheduling = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            created > 0
                ? '✅ Created $created planting task${created == 1 ? '' : 's'} on your calendar!'
                : 'No tasks created.',
          ),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      );
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // ── DYNAMIC GARDEN SUMMARY HELPERS ─────────────────────────────────────────
  String get _summarySunReq {
    if (_wantToGrow.isEmpty) return '—';
    final suns = _wantToGrow
        .map((p) => (p['sun_requirement'] as String?) ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
    if (suns.isEmpty) return 'Varies';
    final counts = <String, int>{};
    for (final s in suns) counts[s] = (counts[s] ?? 0) + 1;
    if (counts.length == 1) return counts.keys.first;
    return 'Varies';
  }

  String get _summaryWaterReq {
    if (_wantToGrow.isEmpty) return '—';
    final waters = _wantToGrow
        .map((p) => (p['water_requirement'] as String?) ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
    if (waters.isEmpty) return 'Varies';
    final counts = <String, int>{};
    for (final w in waters) counts[w] = (counts[w] ?? 0) + 1;
    if (counts.length == 1) return counts.keys.first;
    return 'Varies';
  }

  String get _summaryHarvestRange {
    if (_wantToGrow.isEmpty) return '—';
    final days = _wantToGrow
        .map((p) => p['days_to_harvest'] as int?)
        .whereType<int>()
        .toList();
    if (days.isEmpty) return 'Varies';
    days.sort();
    if (days.length == 1) return '${days.first} days';
    return '${days.first}–${days.last} days';
  }

  List<Map<String, dynamic>> get _dynamicInsights {
    if (_wantToGrow.isEmpty) return [];
    final insights = <Map<String, dynamic>>[];
    final count = _wantToGrow.length;
    insights.add({
      'color': const Color(0xFF7BA05B),
      'icon': Icons.check_circle_outline_rounded,
      'text': '$count plant${count == 1 ? '' : 's'} in your planner. Tap "Auto-schedule" to create planting tasks.',
    });
    final suns = _wantToGrow
        .map((p) => (p['sun_requirement'] as String?) ?? '')
        .where((s) => s.isNotEmpty)
        .toSet();
    if (suns.length > 1) {
      insights.add({
        'color': const Color(0xFFE0A43A),
        'icon': Icons.wb_sunny_rounded,
        'text': 'Your plants have mixed sun needs (${suns.join(', ')}). Group by sun exposure for best results.',
      });
    }
    final days = _wantToGrow
        .map((p) => p['days_to_harvest'] as int?)
        .whereType<int>()
        .toList();
    if (days.isNotEmpty) {
      days.sort();
      final earliest = DateTime.now().add(Duration(days: days.first));
      final fmt = '${_monthName(earliest.month)} ${earliest.day}';
      insights.add({
        'color': const Color(0xFF9C6EA3),
        'icon': Icons.grass_rounded,
        'text': 'Earliest possible harvest around $fmt (${days.first} days). Plan ahead!',
      });
    }
    final categories = _wantToGrow
        .map((p) => (p['category'] as String?) ?? '')
        .where((c) => c.isNotEmpty)
        .toSet();
    if (categories.contains('Herb') || categories.contains('herb')) {
      insights.add({
        'color': const Color(0xFF4A90A4),
        'icon': Icons.eco_rounded,
        'text': 'Herbs in your garden attract beneficial insects and can deter pests naturally.',
      });
    }
    return insights;
  }

  String _monthName(int month) => const [
    '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ][month];

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
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 40.0,
                        fillColor: FlutterFlowTheme.of(context).primaryText,
                        icon: Icon(
                          Icons.add,
                          color: FlutterFlowTheme.of(context).info,
                          size: 15.0,
                        ),
                        onPressed: () async {
                          final isPremium = await SubscriptionService.instance.isPremium();
                          if (!isPremium) {
                            final gardens = await GardensTable().queryRows(
                              queryFn: (q) => q.eqOrNull('user_id', currentUserUid),
                            );
                            if (gardens.length >= 1) {
                              if (context.mounted) {
                                context.pushNamed(PaywallWidget.routeName);
                              }
                              return;
                            }
                          }
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
                          context.pushNamed(
                            CurrentGardens3Widget.routeName,
                            queryParameters: {
                              'fromPlanner': serializeParam(true, ParamType.bool),
                            },
                          );
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '🌱 Plants I Want To Grow',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.none,
                                  ),
                            ),
                            GestureDetector(
                              onTap: _loadSelectedPlants,
                              child: Icon(Icons.refresh_rounded,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  size: 18.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.0),
                        // Plant list — want to grow
                        if (_plantsLoading)
                          Center(child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(strokeWidth: 2.0),
                          ))
                        else if (_wantToGrow.isEmpty && _plantedList.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'No plants added yet. Tap "Add Plants" to get started.',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.poppins(),
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          )
                        else
                          ...(_wantToGrow.map((plant) {
                            final name = plant['plant_name'] as String? ?? 'Plant';
                            final category = (plant['category'] as String? ?? '').toLowerCase();
                            final days = plant['days_to_harvest'] as int?;
                            final plantDate = _getPlantingDate(plant['category'] as String?, name, days);
                            final emoji = category == 'herb' ? '🌿'
                                : category == 'fruit' ? '🍓'
                                : category == 'flower' ? '🌸'
                                : '🌱';
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36.0,
                                    height: 36.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(child: Text(emoji, style: TextStyle(fontSize: 18.0))),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Text(
                                          'Plant by ${DateFormat('MMM d').format(plantDate)}${days != null ? ' · $days days to harvest' : ''}',
                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                font: GoogleFonts.poppins(),
                                                color: FlutterFlowTheme.of(context).primary,
                                                fontSize: 11.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Mark as planted
                                  GestureDetector(
                                    onTap: () => _markAsPlanted(plant),
                                    child: Tooltip(
                                      message: 'Mark as planted',
                                      child: Container(
                                        width: 32.0,
                                        height: 32.0,
                                        margin: EdgeInsets.only(left: 6.0),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.check_rounded,
                                            color: FlutterFlowTheme.of(context).primary, size: 16.0),
                                      ),
                                    ),
                                  ),
                                  // Delete
                                  GestureDetector(
                                    onTap: () => _removePlant(plant),
                                    child: Container(
                                      width: 32.0,
                                      height: 32.0,
                                      margin: EdgeInsets.only(left: 6.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD4685F).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.delete_outline_rounded,
                                          color: const Color(0xFFD4685F), size: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()),
                        // Planted section
                        if (!_plantsLoading && _plantedList.isNotEmpty) ...[
                          SizedBox(height: 8.0),
                          Divider(color: FlutterFlowTheme.of(context).alternate, thickness: 1.0),
                          SizedBox(height: 8.0),
                          Text(
                            '🌿 Plants I\'ve Planted',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 8.0),
                          ...(_plantedList.map((plant) {
                            final name = plant['plant_name'] as String? ?? 'Plant';
                            final category = (plant['category'] as String? ?? '').toLowerCase();
                            final emoji = category == 'herb' ? '🌿'
                                : category == 'fruit' ? '🍓'
                                : category == 'flower' ? '🌸'
                                : '🌱';
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36.0,
                                    height: 36.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4E7A2E).withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(child: Text(emoji, style: TextStyle(fontSize: 18.0))),
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        Text(
                                          'Planted ✓',
                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                font: GoogleFonts.poppins(),
                                                color: const Color(0xFF4E7A2E),
                                                fontSize: 11.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Undo planted
                                  GestureDetector(
                                    onTap: () => _unmarkAsPlanted(plant),
                                    child: Tooltip(
                                      message: 'Move back to want-to-grow',
                                      child: Container(
                                        width: 32.0,
                                        height: 32.0,
                                        margin: EdgeInsets.only(left: 6.0),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.undo_rounded,
                                            color: FlutterFlowTheme.of(context).secondaryText, size: 16.0),
                                      ),
                                    ),
                                  ),
                                  // Delete permanently
                                  GestureDetector(
                                    onTap: () => _removePlant(plant),
                                    child: Container(
                                      width: 32.0,
                                      height: 32.0,
                                      margin: EdgeInsets.only(left: 6.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD4685F).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.delete_outline_rounded,
                                          color: const Color(0xFFD4685F), size: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()),
                        ],
                        SizedBox(height: 8.0),
                        // Buttons row
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _showAddPlantsSheet(context),
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.add, size: 15.0, color: Colors.white),
                                      SizedBox(width: 4.0),
                                      Text('Add Plants',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (_wantToGrow.isNotEmpty) ...[
                              SizedBox(width: 8.0),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _scheduling ? null : _autoSchedulePlantingTasks,
                                  child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: _scheduling
                                          ? const Color(0xFFD4685F).withOpacity(0.6)
                                          : const Color(0xFFD4685F),
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.calendar_month_rounded, size: 15.0, color: Colors.white),
                                        SizedBox(width: 4.0),
                                        Text(_scheduling ? 'Scheduling…' : 'Auto-schedule',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
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
                        _buildSummaryRow(context, '🌱', 'Plants Selected', _wantToGrow.isEmpty ? '0' : '${_wantToGrow.length}'),
                        SizedBox(height: 8.0),
                        _buildSummaryRow(context, '☀️', 'Sun Requirements', _summarySunReq),
                        SizedBox(height: 8.0),
                        _buildSummaryRow(context, '💧', 'Watering Needs', _summaryWaterReq),
                        SizedBox(height: 8.0),
                        _buildSummaryRow(context, '🧺', 'Days to Harvest', _summaryHarvestRange),
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
                                    // Weather-based planting suggestions
                                    Builder(builder: (context) {
                                      final suggestions = _getWeatherSuggestions(temp, code);
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 14.0),
                                          Divider(color: FlutterFlowTheme.of(context).alternate, thickness: 1.0),
                                          SizedBox(height: 10.0),
                                          Row(
                                            children: [
                                              Icon(Icons.eco_rounded, color: FlutterFlowTheme.of(context).primary, size: 16.0),
                                              SizedBox(width: 6.0),
                                              Text(
                                                'Planting Conditions',
                                                style: FlutterFlowTheme.of(context).labelMedium.override(
                                                      font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                                      color: FlutterFlowTheme.of(context).primary,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          ...suggestions.map((s) => Padding(
                                            padding: const EdgeInsets.only(bottom: 6.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(s['icon']!, style: TextStyle(fontSize: 14.0)),
                                                SizedBox(width: 8.0),
                                                Expanded(
                                                  child: Text(
                                                    s['text']!,
                                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                                          font: GoogleFonts.poppins(
                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight),
                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ],
                                      );
                                    }),
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
                      if (_wantToGrow.isEmpty)
                        _insightBox(
                          context,
                          color: Color(0xFF4A90A4),
                          icon: Icons.info_rounded,
                          text: 'Add plants to see personalized insights about your garden.',
                        )
                      else
                        ..._dynamicInsights.map((insight) => _insightBox(
                          context,
                          color: insight['color'] as Color,
                          icon: insight['icon'] as IconData,
                          text: insight['text'] as String,
                        )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FFButtonWidget(
                          onPressed: () {
                            context.pushNamed(
                              CurrentGardens3Widget.routeName,
                              queryParameters: {
                                'fromPlanner': serializeParam(true, ParamType.bool),
                              },
                            );
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
                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: FlutterFlowTheme.of(context).primary.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.storefront_outlined, color: FlutterFlowTheme.of(context).primary, size: 22.0),
                        SizedBox(width: 10.0),
                        Text(
                          'Shop Seeds, Tools & More',
                          style: FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded, color: FlutterFlowTheme.of(context).primary, size: 14.0),
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
                        color: const Color(0xFFD4685F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFD4685F).withOpacity(0.4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month_rounded, color: const Color(0xFFD4685F), size: 22.0),
                          SizedBox(width: 10.0),
                          Flexible(
                            child: Text(
                              'See Upcoming Harvests in Calendar',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                    color: const Color(0xFFD4685F),
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
