import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/style/box_decoration.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/src/presentation/login/controller.dart';
import 'form.dart';

class LoginScreen extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                _backgroundWidget(),
                Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Container(
                      height: (Get.height / 3) - 35,
                      width: Get.width,
                      color: Colors.transparent,
                    ),
                    _buildLoginFormPart()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildLoginFormPart() {
    return Expanded(
      child: Container(
        width: Get.width,
        decoration: AppBoxStyle.loginFormBackgroundStyle(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[_buildLoginTitle(), LoginForm() ],
          ),
        ),
      ),
    );
  }

  _backgroundWidget() {
    return Container(
      height: Get.height / 3,
      width: Get.width,
      child: Image.asset(AppImage.logoCoverPic, fit: BoxFit.cover),
    );
  }

  Padding _buildLoginTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppTitleText1(title: "Login",),
    );
  }
}


