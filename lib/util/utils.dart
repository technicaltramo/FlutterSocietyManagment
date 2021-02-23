import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils{

  static void printLog(dynamic data,{String tag = "Society Management Appp"} ){

    print("***TAG ==>"+tag+"  "+ "info  ==> "+data.toString()+" ***");

  }

 static bool keyboardIsVisible(BuildContext context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  static Future<void> setOrientationLandscape(){
    return SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }
  static Future<void> setOrientationPortrait(){
    return SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }


}


class DynamicObs{
  //nothing here
}
