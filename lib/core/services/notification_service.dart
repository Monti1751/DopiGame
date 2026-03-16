import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('launcher_icon');

      const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
      );

      await _notificationsPlugin.initialize(initializationSettings);
      await _configureLocalTimeZone();
    } catch (e) {
      print("NotificationService Initialization Error: $e");
    }
  }

  Future<void> _configureLocalTimeZone() async {
    try {
      tz.initializeTimeZones();
      final String timeZoneName = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      print("Error configuring local timezone: $e. Falling back to UTC.");
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  Future<void> scheduleDeadlineNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dueDate,
  }) async {
    // Schedule for 9:00 AM on the due date
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var alertTime = tz.TZDateTime(tz.local, dueDate.year, dueDate.month, dueDate.day, 9);
    
    // If it's already past 9am on the due date, don't schedule (or maybe schedule for +1 min if it's the same day?)
    // But usually we want to remind them in the morning.
    if (alertTime.isBefore(now)) {
        if (dueDate.year == now.year && dueDate.month == now.month && dueDate.day == now.day) {
            // If it's today and past 9am, schedule for 1 minute from now as a "last minute" reminder
            alertTime = now.add(const Duration(minutes: 1));
        } else {
            return; // Already past the due date morning
        }
    }

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      alertTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'task_deadline_channel',
          'Task Deadlines',
          channelDescription: 'Notifications for task deadlines',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
