import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/add_task_sheet_widget.dart';
import '/final_app_pages/final_header/final_header_widget.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'growing_calendar_model.dart';
export 'growing_calendar_model.dart';

class GrowingCalendarWidget extends StatefulWidget {
  const GrowingCalendarWidget({super.key});

  static String routeName = 'GrowingCalendar';
  static String routePath = '/growingCalendar';

  @override
  State<GrowingCalendarWidget> createState() => _GrowingCalendarWidgetState();
}

class _GrowingCalendarWidgetState extends State<GrowingCalendarWidget> {
  late GrowingCalendarModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<GardenTasksRow> _allTasks = [];
  bool _tasksLoading = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GrowingCalendarModel());
    // Pre-select the current month chip
    const _months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    _model.choiceChipsValue = _months[DateTime.now().month - 1];
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => _tasksLoading = true);
    try {
      final rows = await GardenTasksTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('user_id', currentUserUid)
            .order('due_date', ascending: true),
      );
      if (mounted) {
        setState(() {
          _allTasks = rows;
          _tasksLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _tasksLoading = false);
    }
  }

  List<GardenTasksRow> get _tasksForSelectedDay {
    return _allTasks.where((t) {
      if (t.dueDate == null) return false;
      final d = t.dueDate!.toLocal();
      return d.year == _selectedDate.year &&
          d.month == _selectedDate.month &&
          d.day == _selectedDate.day;
    }).toList();
  }

  // Returns true if any tasks exist on a given day (for dot indicators)
  bool _hasTasksOnDay(DateTime day) {
    return _allTasks.any((t) {
      if (t.dueDate == null) return false;
      final d = t.dueDate!.toLocal();
      return d.year == day.year && d.month == day.month && d.day == day.day;
    });
  }

  // Returns incomplete tasks due in the next 7 days (excluding today)
  List<GardenTasksRow> get _upcomingTasks {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final cutoff = today.add(const Duration(days: 8));
    return _allTasks.where((t) {
      if (t.dueDate == null || (t.completed ?? false)) return false;
      final d = t.dueDate!.toLocal();
      final taskDay = DateTime(d.year, d.month, d.day);
      return taskDay.isAfter(today) && taskDay.isBefore(cutoff);
    }).toList();
  }

  String get _headerLabel {
    final now = DateTime.now();
    final d = _selectedDate;
    if (d.year == now.year && d.month == now.month && d.day == now.day) {
      return "Today's Tasks";
    }
    return 'Tasks for ${DateFormat('MMM d').format(d)}';
  }

  IconData _iconForTaskType(String? type) {
    switch (type) {
      case 'Water':
        return Icons.water_drop_rounded;
      case 'Fertilize':
        return Icons.eco_rounded;
      case 'Harvest':
        return Icons.content_cut_rounded;
      case 'Plant':
        return Icons.grass_rounded;
      case 'Prune':
        return Icons.cut_rounded;
      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color _colorForTaskType(String? type) {
    switch (type) {
      case 'Water':
        return const Color(0xFF4A90A4);
      case 'Fertilize':
        return const Color(0xFF7BA05B);
      case 'Harvest':
        return const Color(0xFFE0A43A);
      case 'Plant':
        return const Color(0xFF4E7A2E);
      case 'Prune':
        return const Color(0xFF9B59B6);
      default:
        return const Color(0xFF95A5A6);
    }
  }

  Future<void> _toggleComplete(GardenTasksRow task) async {
    final newVal = !(task.completed ?? false);
    await GardenTasksTable().update(
      data: {'completed': newVal},
      matchingRows: (q) => q.eqOrNull('id', task.id),
    );
    await _loadTasks();
  }

  Future<void> _deleteTask(GardenTasksRow task) async {
    await GardenTasksTable().delete(
      matchingRows: (q) => q.eqOrNull('id', task.id),
    );
    await _loadTasks();
  }

  // ── Directions card ──────────────────────────────────────────────────────
  Widget _buildDirectionsCard() {
    final tips = [
      _DirectionTip(Icons.add_circle_outline_rounded, const Color(0xFF4E7A2E),
          'Add a task', 'Tap the green + button to schedule watering, planting, fertilizing, pruning, or harvesting.'),
      _DirectionTip(Icons.touch_app_rounded, const Color(0xFFD4685F),
          'Select a date', 'Tap any day on the calendar to see or add tasks for that date.'),
      _DirectionTip(Icons.check_circle_outline_rounded, const Color(0xFF4A90A4),
          'Mark complete', 'Tap a task card to check it off. The count above updates automatically.'),
      _DirectionTip(Icons.swipe_left_rounded, const Color(0xFF9B59B6),
          'Delete a task', 'Swipe a task card left to delete it.'),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansibleTips(tips: tips, context: context),
        ),
      ),
    );
  }

  // ── Weather card ─────────────────────────────────────────────────────────
  // TODO: Wire up to a real weather API (e.g. OpenWeatherMap or WeatherAPI)
  // Replace _weatherData below with live data from your chosen provider.
  Widget _buildWeatherCard() {
    final now = DateTime.now();
    final month = now.month;
    // Simulated seasonal data — replace with real API response
    final String condition;
    final String tempHigh;
    final String tempLow;
    final IconData weatherIcon;
    final Color weatherColor;
    if (month >= 6 && month <= 8) {
      condition = 'Sunny'; tempHigh = '87°F'; tempLow = '68°F';
      weatherIcon = Icons.wb_sunny_rounded; weatherColor = const Color(0xFFE0A43A);
    } else if (month >= 3 && month <= 5) {
      condition = 'Partly Cloudy'; tempHigh = '68°F'; tempLow = '52°F';
      weatherIcon = Icons.cloud_queue_rounded; weatherColor = const Color(0xFF4A90A4);
    } else if (month >= 9 && month <= 11) {
      condition = 'Breezy'; tempHigh = '62°F'; tempLow = '44°F';
      weatherIcon = Icons.air_rounded; weatherColor = const Color(0xFF7BA05B);
    } else {
      condition = 'Cold'; tempHigh = '38°F'; tempLow = '24°F';
      weatherIcon = Icons.ac_unit_rounded; weatherColor = const Color(0xFF4A90A4);
    }

    final forecast = [
      _ForecastDay('Mon', Icons.wb_sunny_rounded, '85°', const Color(0xFFE0A43A)),
      _ForecastDay('Tue', Icons.cloud_queue_rounded, '79°', const Color(0xFF4A90A4)),
      _ForecastDay('Wed', Icons.grain_rounded, '72°', const Color(0xFF4A90A4)),
      _ForecastDay('Thu', Icons.wb_sunny_rounded, '83°', const Color(0xFFE0A43A)),
      _ForecastDay('Fri', Icons.wb_cloudy_rounded, '77°', const Color(0xFF95A5A6)),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              weatherColor.withOpacity(0.12),
              FlutterFlowTheme.of(context).secondaryBackground,
            ],
          ),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: weatherColor.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText, size: 14.0),
                const SizedBox(width: 4.0),
                Text(
                  'Your Garden',
                  style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: FlutterFlowTheme.of(context).secondaryText),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: weatherColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '5-Day Forecast',
                    style: GoogleFonts.poppins(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: weatherColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(weatherIcon, color: weatherColor, size: 48.0),
                const SizedBox(width: 14.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tempHigh,
                      style: GoogleFonts.poppins(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primaryText),
                    ),
                    Text(
                      '$condition · Low $tempLow',
                      style: GoogleFonts.poppins(
                          fontSize: 13.0,
                          color: FlutterFlowTheme.of(context).secondaryText),
                    ),
                  ],
                ),
                const Spacer(),
                // Garden tip based on weather
                Container(
                  width: 100.0,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E7A2E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: const Color(0xFF4E7A2E).withOpacity(0.25)),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.tips_and_updates_rounded,
                          color: Color(0xFF4E7A2E), size: 16.0),
                      const SizedBox(height: 4.0),
                      Text(
                        month >= 6 && month <= 8
                            ? 'Water morning or evening to reduce evaporation'
                            : month >= 3 && month <= 5
                                ? 'Great planting weather — soil is warming up'
                                : month >= 9 && month <= 11
                                    ? 'Time to harvest before first frost'
                                    : 'Protect plants from hard freezes',
                        style: GoogleFonts.poppins(
                            fontSize: 9.5,
                            color: const Color(0xFF4E7A2E),
                            height: 1.3),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Divider(height: 1.0, color: weatherColor.withOpacity(0.2)),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: forecast.map((f) => Column(
                children: [
                  Text(f.day,
                      style: GoogleFonts.poppins(
                          fontSize: 11.0,
                          color: FlutterFlowTheme.of(context).secondaryText)),
                  const SizedBox(height: 4.0),
                  Icon(f.icon, color: f.color, size: 20.0),
                  const SizedBox(height: 4.0),
                  Text(f.temp,
                      style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: FlutterFlowTheme.of(context).primaryText)),
                ],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: true,
              isDismissible: true,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: AddTaskSheetWidget(),
                  ),
                );
              },
            ).then((_) => _loadTasks());
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 4.0,
          child: Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 26.0,
          ),
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 1.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              wrapWithModel(
                model: _model.finalHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: const FinalHeaderWidget(pageTitle: 'Growing Calendar'),
              ),
              // Month jump chips
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: FlutterFlowChoiceChips(
                  options: [
                    ChipData('Jan'), ChipData('Feb'), ChipData('Mar'),
                    ChipData('Apr'), ChipData('May'), ChipData('Jun'),
                    ChipData('Jul'), ChipData('Aug'), ChipData('Sep'),
                    ChipData('Oct'), ChipData('Nov'), ChipData('Dec'),
                  ],
                  onChanged: (val) => safeSetState(
                      () => _model.choiceChipsValue = val?.firstOrNull),
                  selectedChipStyle: ChipStyle(
                    backgroundColor: const Color(0xFFD4685F),
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    iconColor: Colors.white,
                    iconSize: 16.0,
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  unselectedChipStyle: ChipStyle(
                    backgroundColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.poppins(),
                          color: FlutterFlowTheme.of(context).secondaryText,
                          letterSpacing: 0.0,
                        ),
                    iconColor: FlutterFlowTheme.of(context).secondaryText,
                    iconSize: 16.0,
                    elevation: 0.0,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  chipSpacing: 8.0,
                  rowSpacing: 8.0,
                  multiselect: false,
                  alignment: WrapAlignment.center,
                  controller: _model.choiceChipsValueController ??=
                      FormFieldController<List<String>>(
                        _model.choiceChipsValue != null
                            ? [_model.choiceChipsValue!]
                            : [],
                      ),
                  wrapped: true,
                ),
              ),
              // Calendar
              FlutterFlowCalendar(
                key: ValueKey(_model.choiceChipsValue ?? 'default'),
                color: const Color(0xFFD4685F),
                eventLoader: (day) => _hasTasksOnDay(day) ? [1] : [],
                iconColor: FlutterFlowTheme.of(context).primaryText,
                weekFormat: false,
                weekStartsMonday: false,
                rowHeight: 48.0,
                initialDate: _model.choiceChipsValue != null
                    ? () {
                        const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
                        final idx = months.indexOf(_model.choiceChipsValue!);
                        if (idx == -1) return null;
                        return DateTime(DateTime.now().year, idx + 1, 1);
                      }()
                    : null,
                onChange: (DateTimeRange? range) {
                  safeSetState(() {
                    _model.calendarSelectedDay = range;
                    if (range != null) {
                      _selectedDate = range.start;
                    }
                  });
                },
                titleStyle: FlutterFlowTheme.of(context).titleLarge.override(
                      font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight),
                      letterSpacing: 0.0,
                    ),
                dayOfWeekStyle:
                    FlutterFlowTheme.of(context).bodyLarge.override(
                          font: GoogleFonts.poppins(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .fontWeight),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                        ),
                dateStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.poppins(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight),
                      letterSpacing: 0.0,
                    ),
                selectedDateStyle:
                    FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.poppins(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight),
                          letterSpacing: 0.0,
                        ),
                inactiveDateStyle:
                    FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.poppins(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontWeight),
                          letterSpacing: 0.0,
                        ),
              ),
              // ── How to use this calendar ──────────────────────────
              _buildDirectionsCard(),
              // ── Weather forecast ──────────────────────────────────
              _buildWeatherCard(),
              // Tasks section
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _headerLabel,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    if (_tasksForSelectedDay.isNotEmpty)
                      Builder(builder: (ctx) {
                        final total = _tasksForSelectedDay.length;
                        final done = _tasksForSelectedDay.where((t) => t.completed ?? false).length;
                        final remaining = total - done;
                        return Text(
                          remaining == 0
                              ? '✅ All done!'
                              : '$remaining remaining',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                font: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                                color: remaining == 0
                                    ? const Color(0xFF4E7A2E)
                                    : FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                              ),
                        );
                      }),
                  ],
                ),
              ),
              if (_tasksLoading)
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_tasksForSelectedDay.isEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 48.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.event_available_rounded,
                          size: 40.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'No tasks for this day',
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600),
                                color: FlutterFlowTheme.of(context)
                                    .primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          'Tap the + button to add a task.',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                font: GoogleFonts.poppins(),
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                  child: Column(
                    children: _tasksForSelectedDay.map((task) {
                      final isComplete = task.completed ?? false;
                      final taskColor = _colorForTaskType(task.taskType);
                      return Dismissible(
                        key: Key(task.id ?? UniqueKey().toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          margin: const EdgeInsets.only(bottom: 12.0),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).error,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: const Icon(Icons.delete_outline_rounded,
                              color: Colors.white, size: 24.0),
                        ),
                        onDismissed: (_) => _deleteTask(task),
                        child: GestureDetector(
                          onTap: () => _toggleComplete(task),
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12.0),
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: isComplete
                                  ? FlutterFlowTheme.of(context)
                                      .secondaryBackground
                                      .withOpacity(0.6)
                                  : FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: isComplete
                                    ? FlutterFlowTheme.of(context).alternate
                                    : taskColor.withOpacity(0.35),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Type icon
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    color: isComplete
                                        ? FlutterFlowTheme.of(context)
                                            .alternate
                                        : taskColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Icon(
                                    _iconForTaskType(task.taskType),
                                    color: isComplete
                                        ? FlutterFlowTheme.of(context)
                                            .secondaryText
                                        : taskColor,
                                    size: 20.0,
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                // Task details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.taskName ?? 'Task',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                              color: isComplete
                                                  ? FlutterFlowTheme.of(context)
                                                      .secondaryText
                                                  : FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              decoration: isComplete
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                            ),
                                      ),
                                      if ((task.notes ?? '').isNotEmpty) ...[
                                        const SizedBox(height: 3.0),
                                        Text(
                                          task.notes!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                font: GoogleFonts.poppins(),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ],
                                      const SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          if (task.taskType != null)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2.0),
                                              decoration: BoxDecoration(
                                                color: taskColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                              child: Text(
                                                task.taskType!,
                                                style: TextStyle(
                                                  color: taskColor,
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Complete checkbox
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: isComplete
                                          ? FlutterFlowTheme.of(context)
                                              .primary
                                          : Colors.transparent,
                                      borderRadius:
                                          BorderRadius.circular(6.0),
                                      border: Border.all(
                                        color: isComplete
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: isComplete
                                        ? const Icon(Icons.check_rounded,
                                            color: Colors.white, size: 14.0)
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              // Upcoming Tasks section (next 7 days)
              Builder(
                builder: (ctx) {
                  final upcoming = _upcomingTasks;
                  if (upcoming.isEmpty) return const SizedBox.shrink();
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final tomorrow = today.add(const Duration(days: 1));
                  final Map<DateTime, List<GardenTasksRow>> grouped = {};
                  for (final t in upcoming) {
                    final d = t.dueDate!.toLocal();
                    final key = DateTime(d.year, d.month, d.day);
                    grouped.putIfAbsent(key, () => []).add(t);
                  }
                  final sortedDates = grouped.keys.toList()..sort();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming Tasks',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Next 7 days',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                    font: GoogleFonts.poppins(),
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 80.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: sortedDates.map((date) {
                            final dayTasks = grouped[date]!;
                            final isToday = date == today;
                            final isTomorrow = date == tomorrow;
                            final label = isToday
                                ? 'Today'
                                : isTomorrow
                                    ? 'Tomorrow'
                                    : DateFormat('EEE, MMM d').format(date);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0, top: 8.0),
                                  child: Text(
                                    label,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                    ),
                                  ),
                                ),
                                ...dayTasks.map((task) {
                                  final taskColor = _colorForTaskType(task.taskType);
                                  return GestureDetector(
                                    onTap: () => _toggleComplete(task),
                                    child: Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(bottom: 8.0),
                                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: taskColor.withOpacity(0.25),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: BoxDecoration(
                                              color: taskColor.withOpacity(0.12),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Icon(
                                              _iconForTaskType(task.taskType),
                                              color: taskColor,
                                              size: 16.0,
                                            ),
                                          ),
                                          const SizedBox(width: 10.0),
                                          Expanded(
                                            child: Text(
                                              task.taskName ?? 'Task',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w500,
                                                color: FlutterFlowTheme.of(context).primaryText,
                                              ),
                                            ),
                                          ),
                                          if (task.taskType != null)
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                              decoration: BoxDecoration(
                                                color: taskColor.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(4.0),
                                              ),
                                              child: Text(
                                                task.taskType!,
                                                style: TextStyle(
                                                  color: taskColor,
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Data helpers ────────────────────────────────────────────────────────────

class _DirectionTip {
  final IconData icon;
  final Color color;
  final String title;
  final String body;
  const _DirectionTip(this.icon, this.color, this.title, this.body);
}

class _ForecastDay {
  final String day;
  final IconData icon;
  final String temp;
  final Color color;
  const _ForecastDay(this.day, this.icon, this.temp, this.color);
}

// ── Expansible tips card ────────────────────────────────────────────────────

class ExpansibleTips extends StatefulWidget {
  const ExpansibleTips({super.key, required this.tips, required this.context});
  final List<_DirectionTip> tips;
  final BuildContext context;

  @override
  State<ExpansibleTips> createState() => _ExpansibleTipsState();
}

class _ExpansibleTipsState extends State<ExpansibleTips> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
            child: Row(
              children: [
                Container(
                  width: 36.0, height: 36.0,
                  decoration: BoxDecoration(
                    color: const Color(0x1A4E7A2E),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(Icons.help_outline_rounded,
                      color: Color(0xFF4E7A2E), size: 18.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('How to use the Growing Calendar',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 14.0)),
                      Text('Tap to ${_expanded ? 'hide' : 'show'} tips',
                          style: GoogleFonts.poppins(
                              fontSize: 11.0,
                              color: FlutterFlowTheme.of(context).secondaryText)),
                    ],
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ],
            ),
          ),
        ),
        if (_expanded) ...[
          Divider(
              height: 1.0,
              color: FlutterFlowTheme.of(context).alternate,
              indent: 16.0,
              endIndent: 16.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 14.0),
            child: Column(
              children: widget.tips.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 32.0, height: 32.0,
                      decoration: BoxDecoration(
                        color: tip.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Icon(tip.icon, color: tip.color, size: 16.0),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tip.title,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 13.0)),
                          Text(tip.body,
                              style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                  height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
