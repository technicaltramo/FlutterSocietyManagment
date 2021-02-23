import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/text_field.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

import 'controller.dart';

class VisitorEntryScreen extends GetView<VisitorEntryController> {
  final User user;

  VisitorEntryScreen(this.user);

  @override
  Widget build(BuildContext context) {
    Get.put(VisitorEntryController(user, context));
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  _UserInfo(),
                  _VisitorInfo(),
                ],
              ),
            ),
            AppButton(
              onPress: controller.newVisitorEntry,
              buttonText: "Submit",
            )
          ],
        ),
      ),
    ));
  }
}

class _UserInfo extends GetView<VisitorEntryController> {
  @override
  Widget build(BuildContext context) {
    User user = controller.user;

    return Card(
      margin: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _mWidget("Name", user.name, Icons.person),
            _mWidget("Mobile", user.mobile.toString(), Icons.phone),
            _mWidget("Flat No", user.flatNo, Icons.home),
          ],
        ),
      ),
    );
  }

  _mWidget(String title, String vale, IconData iconData) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Icon(
            iconData,
            size: 22,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              )),
          Text(
            "  :  ",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Expanded(
              flex: 2,
              child: Text(
                vale,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )),
        ],
      ),
    );
  }
}

class _VisitorInfo extends GetView<VisitorEntryController> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
           // AppText.mediumTitle("Visitor Info"),
            AppTitleText1(title: "Visitor Info",),
            AppTextFormField(
              controller: controller.nameEC,
              labelText: "Name",
              validator: (String value) {
                return (value.length < 4)
                    ? "can't be less than 4 character"
                    : null;
              },
            ),
            AppTextFormField(
              controller: controller.mobileEC,
              fieldType: TextFieldType.MOBILE,
              labelText: "Mobile",
              validator: (String value) {
                return (value.length < 10)
                    ? "can't be less than 10 character"
                    : null;
              },
            ),
            AppTextFormField(
              controller: controller.vehicleNumberEC,
              labelText: "Vehicle Number",
              validator: (String value) {
                return (value.length < 4)
                    ? "can't be less than 4 character"
                    : null;
              },
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: controller.onImageButtonPressed,
              child: Container(
                height: 180,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Obx(() {
                  ApiResult result = controller.visitorPhotoResultObs.value;
                  return result.when(fetched: (data) {
                    PickedFile visitorPhoto = data;
                    controller.visitorPhoto = visitorPhoto;
                    return Container(
                      margin: EdgeInsets.all(5),
                      child: Image.file(
                        File(visitorPhoto.path),
                      ),
                    );
                  }, init: () {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.camera,
                          size: 100,
                          color: Colors.white30,
                        ),
                        Text(
                          "Capture Photo",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    );
                  });
                }),
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
