//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/dashboard.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/service/firebase/messaging.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/src/service/socket_io/callback.dart';
import 'package:t_society/src/service/socket_io/service.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class DashboardController extends GetxController implements SocketCallback {

  var connectionStateObs = ApiResult.init().obs;
  AppPreference appPreference = sl.get();
  User loggedInUser;

  DashboardRepository repository = sl.get();

  final BuildContext context;
  DashboardController(this.context);

  @override
  void onInit() {
    loggedInUser = appPreference.user;
    saveFcmTokenToDatabase();
    initSocket();
   FirebaseMessaging().getToken().then((value){
      Utils.printLog("onToken :" +value);

    });
    FirebaseMessaging().getToken().asStream().listen((event) {
      Utils.printLog("onRefreshToken :" +event);
    });
    super.onInit();
  }

  void initSocket() async {
    SocketService.setUpSocketServiceCallback(this);
    if (SocketService.socketIO == null)
      await SocketService.connectSocket();
    else {
      connectionStateObs.value = ApiResult.fetched(
          data: {"type": "connected", "message": "already initialized"});
    }
  }

  @override
  onMessageReceive(data) {}

  @override
  onUserOnline(bool isOnline, dynamic data) {}

  @override
  onSocketConnect(data) {
    connectionStateObs.value = ApiResult.fetched(
        data: {"type": "connected", "message": data.toString()});
  }

  @override
  onTyping(data) {}

  saveFcmTokenToDatabase() async {
    String token = await FCMService.getToken();
    CommonResponse response = await repository.saveFcmToken(token);
    Utils.printLog(response.message, tag: "saveFcmTokenToDatabase");
  }


}
