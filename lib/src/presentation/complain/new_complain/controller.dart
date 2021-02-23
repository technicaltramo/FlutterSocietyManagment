import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/src/data/repository/complain.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/service/locator/locator.dart';

class NewComplainController extends GetxController {

  var complainKey = GlobalKey<FormState>();
  var complainNameController = TextEditingController();
  var complainDescriptionController = TextEditingController();
  var selectedPriority = "Select Priority";

  ComplainRepository complainRepository = sl.get();


  onRaiseComplainButtonClicked(BuildContext context) async {
    bool isValid = complainKey.currentState.validate();
    if (!isValid) return;
    Map<String, String> data = {
      "name": complainNameController.text,
      "description": complainDescriptionController.text,
      "priority": complainDescriptionController.text,
    };

    AppDialog.squareTransparentProgress(context, title: "Raising complain...");
    try {
          CommonResponse response = await complainRepository.raiseComplain(data);
      Get.back();

      if (response.status == 1)
        LottieDialog.resStatus(context, response.message,
            lottieType: LottieType.SUCCESS);
      else
        LottieDialog.resStatus(context, response.message,
            lottieType: LottieType.FAILED);
    } catch (e) {
      Get.back();
      LottieDialog.resStatus(context, e.toString(),
          lottieType: LottieType.ALERT);
    }
  }


}
