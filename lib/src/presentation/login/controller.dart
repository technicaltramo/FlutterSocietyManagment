import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/login.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/presentation/dashboard/main_screen.dart';
import 'package:t_society/src/service/dio/exception.dart';
import 'package:t_society/src/service/locator/locator.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String strEmail;
  String strPassword;
  var loginFormKey = GlobalKey<FormState>();

  LoginRepository loginRepository = sl.get();
  AppPreference appPreference = sl.get();

  @override
  void onInit() {
    emailController.text = "test1user@gmail.com";
    passwordController.text = "123456";
    super.onInit();
  }

  void onLoginClick(BuildContext context) async {
    bool isValidate = loginFormKey.currentState.validate();
    if (!isValidate) return;

    strEmail = emailController.text;
    strPassword = passwordController.text;

    AppDialog.squareTransparentProgress(context, title: "Login...");
    try {
      LoginResponse response =
          await loginRepository.login(strEmail, strPassword);
      Get.back();
      if (response.status == 1) {
        appPreference.user = response.user;
        appPreference.email = emailController.text;
        appPreference.password = passwordController.text;
        appPreference.token = response.token;

        Get.off(DashboardScreen());
      } else
        LottieDialog.resStatus(context, response.message,
            lottieType: LottieType.ALERT);
    } catch (e) {
      Get.back();
      LottieDialog.resStatus(context, getDioException(e).toString(),
          lottieType: LottieType.NO_INTERNET);
    }
  }
}
