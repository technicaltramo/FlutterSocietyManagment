import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/presentation/splash/screen.dart';
import 'package:t_society/src/presentation/visitor/upcoming/screen.dart';
import 'package:t_society/src/service/firebase/messaging.dart';
import 'package:t_society/src/service/local_notificiation/notification.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/utils.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  await Utils.setOrientationPortrait();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
     LocalNotification.configure();
     initFirebaseMessaging();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppPreference appPreference = sl();

    var toScreen;
    var time = DateTime.now();
    var currentTimeInMilliSecond = time.millisecond;
    var visitor = appPreference.visitorInfo;
    if (visitor != null) {
      if (int.parse(appPreference.visitorInfo.timeInMilliSecond) >
          currentTimeInMilliSecond) {
        toScreen = UpcomingVisitorScreen(appPreference.visitorInfo);
      } else {
        appPreference.visitorInfo = null;
        toScreen = SplashScreen();
      }
      ;
    } else
      toScreen = SplashScreen();

    return GetMaterialApp(
        theme: ThemeData(
            textTheme: TextTheme(headline1: TextStyle()),
          primaryColor: Colors.purple
        ),
        debugShowCheckedModeBanner: true,
        home: toScreen);
  }
}
