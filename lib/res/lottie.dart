import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieDialog {
  static Future<void> resStatus(BuildContext context, String message,
      {String lottieType = LottieType.ALERT}) {
    return showDialog(
        builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(70),
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      message,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                    top: -40,
                    child: Container(
                      color: Colors.transparent,
                      child: Lottie.asset(lottieType, width: 80, height: 80),
                    ))
              ],
            )),
        context: context);
  }
}

class LottieType {
  static const SUCCESS = "assets/lottie/success.json";
  static const FAILED = "assets/lottie/failed.json";
  static const PENDING = "assets/lottie/pending.json";
  static const ALERT = "assets/lottie/alert.json";
  static const NO_INTERNET = "assets/lottie/no_internet.json";
  static const SERVER = "assets/lottie/server_error.json";
  static const TIME_OUT = "assets/lottie/time_out.json";
  static const WARNING = "assets/lottie/warning.json";
}
