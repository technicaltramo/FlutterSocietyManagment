import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/src/data/repository/visitor.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/presentation/error_screen.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class VisitorEntryController extends GetxController {
  final User user;
  final BuildContext context;
  final ImagePicker _picker = ImagePicker();
  var visitorPhotoResultObs = ApiResult<PickedFile>.init().obs;
  PickedFile visitorPhoto;
  var repository = sl.get<VisitorRepository>();

  //textField controllers
  final nameEC = TextEditingController();
  final mobileEC = TextEditingController();
  final vehicleNumberEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  VisitorEntryController(this.user, this.context);

  void onImageButtonPressed() async {
    try {
      var result = await _picker.getImage(
        source: ImageSource.camera,
        imageQuality: 20
      );
      visitorPhotoResultObs.value = ApiResult.fetched(data: result);
    } catch (e) {
      Utils.printLog(e);
    }
  }

  newVisitorEntry() async {
    try {
      bool isValid = formKey.currentState.validate();
      if (!isValid) return;
      if (visitorPhoto == null) return;

      File file = File(visitorPhoto.path);
      AppDialog.squareTransparentProgress(context);
      CommonResponse response = await repository.newVisitorEntry(
          file,user.sId, nameEC.text, mobileEC.text, vehicleNumberEC.text);
      Get.back();

     // AppDialog.squareTransparentProgress(context,title: response.message);

    } catch (e) {
      Get.back();
      Get.to(ErrorScreen(e));
    }
  }
}
