import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/src/service/dio/exception.dart';

// ignore: must_be_immutable
class ErrorScreen extends StatelessWidget {
  ErrorScreen(DioError error) {
    this.exception = getDioException(error);
  }
  Exception exception;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: _buildExceptionWidget()),
    );
  }

  _buildExceptionWidget() {
    if (exception is NoInternetException)
      return _buildNoInternetWidget(LottieType.NO_INTERNET);
    else if (exception is ResponseException)
      return _buildNoInternetWidget(LottieType.SERVER);
    else if (exception is SocketException)
      return _buildNoInternetWidget(LottieType.SERVER);
    else if (exception is TimeoutException)
      return _buildNoInternetWidget(LottieType.TIME_OUT);
    else  _buildNoInternetWidget(LottieType.ALERT);
  }

  _buildNoInternetWidget(String type) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              size: 80,
              color: Colors.red,
            ),
            Text(exception.toString())
          ],
        ),
      ),
    );
  }
}
