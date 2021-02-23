import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:t_society/src/presentation/visitor/upcoming/screen.dart';
import 'package:t_society/src/service/locator/locator.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;

  BaseScreen({@required this.child});

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {

  AppPreference _appPreference = sl();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      var time = DateTime.now();
      var currentTimeInMilliSecond =time.millisecond;

      VisitorInfo info = _appPreference.visitorInfo;
      if(info !=null){
          if (int.parse(info.timeInMilliSecond) > currentTimeInMilliSecond){
            if(info.status == 1){
              Get.to(UpcomingVisitorScreen(info));
            } else _appPreference.visitorInfo = null;
          }
          else{
            _appPreference.visitorInfo = null;
          }
      }
      // came back to Foreground
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

}
