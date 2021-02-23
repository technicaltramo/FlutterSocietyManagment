
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  static Future configure() async {
    var androidInitialize =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialize = new IOSInitializationSettings();
    var initializeSetting = new InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);

    _localNotificationsPlugin.initialize(initializeSetting);
  }

  static Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "Local Notification",
      "this is description of notification",
      autoCancel: true,
      priority: Priority.max,
      ongoing: true,
      timeoutAfter: 3000,
      color: Colors.red,);
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);



    await _localNotificationsPlugin.show(
        0, "hello dev", "hello body", generalNotificationDetails);
  }
}

class TEstNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static showFullScreenIntentNotification() async {
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
        const NotificationDetails(
          android: AndroidNotificationDetails('full screen channel id',
              'full screen channel name', 'full screen channel description',
              priority: Priority.high,
              importance: Importance.high,
              fullScreenIntent: true,
              ongoing: true,
              autoCancel: true,
              color: Colors.green,
          timeoutAfter: 90000),

        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

