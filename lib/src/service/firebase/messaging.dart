import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/presentation/login/screen.dart';
import 'package:t_society/src/service/firebase/visitor.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/utils.dart';
import 'visitor.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

initFirebaseMessaging() async {
  firebaseMessaging.configure(
      onMessage: _onMessage,
      onLaunch: _onLaunch,
      onResume: _onResume,
      onBackgroundMessage: Platform.isIOS ? null : _onBackgroundMessageHandler);
}

//ON MESSAGE
//when app is in foreground mode
Future _onMessage(Map<String, dynamic> message) async {
  Utils.printLog("OnMessage : " + message.toString());

  AppPreference appPreference = sl();
  var data = message["data"];
  var userId = data["userId"];
  if(appPreference.user.sId == userId){
    var type = data["type"];
    if(type == "visitor")
      VisitorMessagingService(data);
  }
}


Future _onResume(Map<String, dynamic> message) async {
  Utils.printLog("OnResume : " + message.toString());
}

Future _onLaunch(Map<String, dynamic> message) async {
  Utils.printLog("OnLaunch : " + message.toString());
}


Future<dynamic> _onBackgroundMessageHandler(Map<String, dynamic> message) async {
  Utils.printLog("OnBackgroundMessage : " + message.toString());

   Get.to(LoginScreen());

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
