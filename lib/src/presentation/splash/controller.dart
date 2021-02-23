import 'package:get/get.dart';
import 'package:t_society/src/presentation/login/screen.dart';

class SplashController extends GetxController{

  @override
  void onInit() {
    navigateToLoginScreen();
    super.onInit();
  }

  navigateToLoginScreen () async{
    Future.delayed(Duration(seconds: 2)).then((value) => {
      Get.off(LoginScreen())
    });
  }

}