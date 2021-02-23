
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:t_society/src/presentation/visitor/upcoming/screen.dart';
import 'package:t_society/src/service/local_notificiation/notification.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/utils.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

initFirebaseMessaging() async {
  firebaseMessaging.configure(
      onMessage: _onMessage,
      onLaunch: _onLaunch,
      onResume: _onResume,
      onBackgroundMessage: Platform.isIOS ? null : _onBackgroundMessageHandler);
}

Future _onLaunch(Map<String, dynamic> message) async {
  Utils.printLog("OnLaunch : " + message.toString());
  // Get.to(DashboardScreen());
  //TEstNotification.showFullScreenIntentNotification();
  //LocalNotification.showNotification(message, test: "Hello test data");
}

Future _onMessage(Map<String, dynamic> message) async {
  AppPreference appPreference = sl();
  Utils.printLog("OnMessage : " + message.toString());
  var data = message["data"];
  if (data["type"] == "visitor") {
    if (data["userId"] == appPreference.user.sId) {
      var visitor = VisitorInfo.fromJson({
        "name": data["name"],
        "mobile": data["mobile"],
        "vehicleNumber": data["vehicleNumber"],
        "status": 0,
        "picUrl": data["picUrl"],
        "timeInMilliSecond" : data['timeInMilliSecond']
      });
      appPreference.visitorInfo = visitor;
      Get.to(UpcomingVisitorScreen(visitor));
    }
  }
}

Future _onResume(Map<String, dynamic> message) async {
  Utils.printLog("OnResume : " + message.toString());
}

Future<dynamic> _onBackgroundMessageHandler(
    Map<String, dynamic> message) async {
  Utils.printLog("OnBackgroundMessageHandler : " + message.toString());
  AppPreference appPreference = await AppPreference.init();

  var data = message["data"];
  if (data["type"] == "visitor") {
    if (data["userId"] == appPreference.user.sId) {
      var visitor = VisitorInfo.fromJson({
        "name": data["name"],
        "mobile": data["mobile"],
        "vehicleNumber": data["vehicleNumber"],
        "status": 1,
        "picUrl": data["picUrl"],
        "timeInMilliSecond": data["timeInMilliSecond"],
      });
      appPreference.visitorInfo = visitor;
      TEstNotification.showFullScreenIntentNotification();
    }
  }

  // TEstNotification.showFullScreenIntentNotification();
  FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var androidInitialize =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitialize = new IOSInitializationSettings();
  var initializeSetting = new InitializationSettings(
      android: androidInitialize, iOS: iosInitialize);

  _localNotificationsPlugin.initialize(initializeSetting);

  var androidDetails = new AndroidNotificationDetails(
      "channelId", "Local Notification", "this is description of notification");
  var iosDetails = new IOSNotificationDetails();
  var generalNotificationDetails =
      new NotificationDetails(android: androidDetails, iOS: iosDetails);

  await _localNotificationsPlugin.show(
      0, "hello dev", "hello body", generalNotificationDetails);

}

Future _showNotification(Map<String, dynamic> message) async {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var pushTitle;
  var pushText;
  var action;

  if (Platform.isAndroid) {
    var nodeData = message['data'];
    pushTitle = nodeData['title'];
    pushText = nodeData['body'];
    action = nodeData['action'];
  } else {
    pushTitle = message['title'];
    pushText = message['body'];
    action = message['action'];
  }
  print("AppPushs params pushTitle : $pushTitle");
  print("AppPushs params pushText : $pushText");
  print("AppPushs params pushAction : $action");

  var platformChannelSpecificsAndroid = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      playSound: false,
      enableVibration: false,
      importance: Importance.max,
      priority: Priority.high);
  // @formatter:on
  var platformChannelSpecificsIos =
      new IOSNotificationDetails(presentSound: false);
  var platformChannelSpecifics = new NotificationDetails();

  new Future.delayed(Duration.zero, () {
    _flutterLocalNotificationsPlugin.show(
      0,
      pushTitle,
      pushText,
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  });
}

class FCMService {
  static Future<String> getToken() async {
    return firebaseMessaging.getToken().then((value) {
      return value;
    }).catchError((error) {
      throw error;
    });
  }
}

