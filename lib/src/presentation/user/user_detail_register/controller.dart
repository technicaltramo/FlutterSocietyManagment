import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/user.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/state_district.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/model/state_district.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/presentation/error_screen.dart';
import 'package:t_society/src/service/dio/exception.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class UserRegisterController extends GetxController {

  AppPreference appPreference = sl.get();
  RxBool isTower = false.obs;

  var societyAdminUserListObs = ApiResult<UserListResponse>.init().obs;


  UserRegisterController(this.user, this.context){
    appPreference = sl.get();
  }



  //OBSERVABLE VARIABLE
  var isEditMode = false.obs;
  var isSocietyUserListMode = false.obs;
  var isLoadingObs = true.obs;
  var stateListObs = List<CountryState>().obs;
  var districtListObs = List<District>().obs;

  BuildContext context;
  CountryState selectedState;
  District selectedDistrict;

  var registerKey = GlobalKey<FormState>();

  //editing controller
  var societyNameController = TextEditingController();
  var addressLine1Controller = TextEditingController();
  var addressLine2Controller = TextEditingController();
  var pinCodeController = TextEditingController();
  var adminNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var aadharNumberController = TextEditingController();
  var flatNoController = TextEditingController();

  UserRepository userRepository = sl.get();
  User user;

  @override
  void onInit() {
    fetchStates();
    if (user != null) {
      adminNameController.text = user.name;
      mobileController.text = user.mobile.toString();
      emailController.text = user.email;
      aadharNumberController.text = user.aadhaarNumber.toString();
      flatNoController.text = user.flatNo;

      if (user.role == "society_admin") {
        societyNameController.text = user.societyInfo.societyName;
        addressLine1Controller.text = user.societyInfo.addressLine1;
        addressLine2Controller.text = user.societyInfo.addressLine2;
        pinCodeController.text = user.societyInfo.pinCode;
      }
    }

    super.onInit();
  }

  void onRegisterButtonClicked() async {
    bool isValidate = registerKey.currentState.validate();
    if (!isValidate) return;

    String role = appPreference.user.role;
    Map<String, dynamic> userRegistrationData = (role == "app_admin")
        ? {
            "name": adminNameController.text,
            "mobile": mobileController.text,
            "email": emailController.text,
            "aadhaarNumber": aadharNumberController.text,
            "flatNo": flatNoController.text,
            "role": "society_admin",
            "societyInfo": {
              "societyName": societyNameController.text,
              "district": selectedDistrict.name,
              "state": selectedState.name,
              "addressLine1": addressLine1Controller.text,
              "addressLine2": addressLine2Controller.text,
              "pinCode": pinCodeController.text,
            }
          }
        : {
            "name": adminNameController.text,
            "mobile": mobileController.text,
            "email": emailController.text,
            "aadhaarNumber": aadharNumberController.text,
            "flatNo": flatNoController.text,
            "role": "user",
          };

    try {
      AppDialog.squareTransparentProgress(context, title: "Registering...");
      CommonResponse res =
          await userRepository.userRegister(userRegistrationData);
      Get.back();
      if (res.status == 1)
        LottieDialog.resStatus(context, res.message,
            lottieType: LottieType.SUCCESS);
      else
        LottieDialog.resStatus(context, res.message,
            lottieType: LottieType.FAILED);
    } catch (e) {
      Get.back();
      Get.to(ErrorScreen(e));
    }
  }

  void onUpdateButtonClicked() async {
    bool isValidate = registerKey.currentState.validate();
    if (!isValidate) return;
    String role = appPreference.user.role;
    Map<String, dynamic> userRegistrationData = (role == "app_admin")
        ? {
            "id": user.sId,
            "name": adminNameController.text,
            "mobile": mobileController.text,
            "email": emailController.text,
            "aadhaarNumber": aadharNumberController.text,
            "flatNo": flatNoController.text,
            "role": "society_admin",
            "societyInfo": {
              "societyName": societyNameController.text,
              "district": selectedDistrict.name,
              "state": selectedState.name,
              "addressLine1": addressLine1Controller.text,
              "addressLine2": addressLine2Controller.text,
              "pinCode": pinCodeController.text,
            }
          }
        : {
            "id": user.sId,
            "name": adminNameController.text,
            "mobile": mobileController.text,
            "email": emailController.text,
            "aadhaarNumber": aadharNumberController.text,
            "flatNo": flatNoController.text,
            "role": "user",
          };

    try {
      AppDialog.squareTransparentProgress(context, title: "Updating...");
      CommonResponse res =
          await userRepository.userUpdate(userRegistrationData);
      Get.back();
      if (res.status == 1)
        LottieDialog.resStatus(context, res.message,
            lottieType: LottieType.SUCCESS);
      else
        LottieDialog.resStatus(context, res.message,
            lottieType: LottieType.FAILED);
    } catch (e) {
      Get.back();
      Get.to(ErrorScreen(e));
    }
  }

  fetchStates() async {
    try {
      StateResponse response = await userRepository.fetchStates();
      if (response.status == 1) {
        stateListObs.value = response.states;
        if (user != null) {
          if(user.societyInfo != null){
            selectedState =
                CountryState.getStateByName(stateListObs.value, user.societyInfo.state);
            fetDistrictFromStateId(selectedState.id);
          }
        }
      }
      return response;
    } catch (e) {
      Get.to(ErrorScreen(e));
    } finally {
      isLoadingObs.value = false;
    }
  }

  fetDistrictFromStateId(int stateId) async {
    try {
      isLoadingObs.value = true;
      DistrictResponse response =
          await userRepository.fetDistrictFromStateId(stateId);
      if (response.status == 1) {
        districtListObs.value = response.districts;
        if (user != null) {
          selectedDistrict = District.getDistrictByName(
              districtListObs.value, user.societyInfo.district);
        }
      }
      return response;
    } catch (e) {
      throw getDioException(e);
    } finally {
      isLoadingObs.value = false;
    }
  }

  void uploadUserExcelData(String adminMobile) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["xlsx"]
    );
    if(result != null) {
      try{
        File file = File(result.files.single.path);

        Utils.printLog(file.path);

        AppDialog.squareTransparentProgress(context, title: "Uploading...");
        CommonResponse res = await userRepository.uploadUserExcelData(adminMobile, file);
        Get.back();
        if (res.status == 1)
          LottieDialog.resStatus(context, res.message,
              lottieType: LottieType.SUCCESS);
        else
          LottieDialog.resStatus(context, res.message,
              lottieType: LottieType.FAILED);
      }catch(e){
        Get.back();
        Get.to(ErrorScreen(e));
      }
    } else {
      // User canceled the picker
    }
  }

  //todo (user pagination)
  onViewUserListButtonClicked() async{
    try{
      this.isEditMode.value = false;
      isSocietyUserListMode.value = !isSocietyUserListMode.value;
      UserListResponse response =await userRepository.userList(1,adminId : user.sId);
      societyAdminUserListObs.value = ApiResult.fetched(data: response);
    }catch(e){
      Get.to(ErrorScreen(e));
    }
  }
}
