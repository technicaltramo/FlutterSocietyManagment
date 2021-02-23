import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/src/presentation/splash/controller.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(AppImage.logoCoverPic),
              ),
              SizedBox(
                height: 16,
              ),
           //   AppText.largeTitle("My Society")
              AppTitleText1(title: "My Society",)
                          ],
          ),
        ),
      ),
    );
  }
}
