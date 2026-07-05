import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  Future<void> requestPermission() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Schedule a notification for a garden task
  // notificationId should be unique per task (use task DB id hash or index)
  Future<void> scheduleTaskNotification({
    required int notificationId,
    required String taskName,
    required DateTime dueDate,
    String gardenName = 'your garden',
  }) async {
    if (!_initialized) await initialize();

    // Notify 1 day before at 8:00 AM
    final notifyTime = DateTime(dueDate.year, dueDate.month, dueDate.day - 1, 8, 0);
    if (notifyTime.isBefore(DateTime.now())) return; // already past

    final tzNotifyTime = tz.TZDateTime.from(notifyTime, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'garden_tasks',
      'Garden Tasks',
      channelDescription: 'Reminders for upcoming garden tasks',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _plugin.zonedSchedule(
      notificationId,
      '🌱 Task due tomorrow',
      '$taskName — $gardenName',
      tzNotifyTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Cancel a specific notification
  Future<void> cancelNotification(int notificationId) async {
    await _plugin.cancel(notificationId);
  }

  // Cancel all scheduled notifications
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  // Reschedule all tasks for a user (call after login or task changes)
  // Pass in list of (id, taskName, dueDate, gardenName)
  Future<void> rescheduleAll(
      List<Map<String, dynamic>> tasks) async {
    if (!_initialized) await initialize();
    await cancelAll();
    for (int i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      final dueDate = task['due_date'];
      if (dueDate == null) continue;
      await scheduleTaskNotification(
        notificationId: i,
        taskName: task['task_name'] ?? 'Garden task',
        dueDate: dueDate is DateTime ? dueDate : DateTime.tryParse(dueDate.toString()) ?? DateTime.now(),
        gardenName: task['garden_name'] ?? 'your garden',
      );
    }
  }
}
