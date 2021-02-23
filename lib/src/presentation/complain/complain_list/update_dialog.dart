import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/dropdown.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/src/model/complain.dart';

import 'controller.dart';

// ignore: must_be_immutable
class ComplainConfirmDialog extends GetView<ComplainListController> {
  final Complain complain;
  ComplainConfirmDialog(this.complain);

  String tempStatus;
  String selectedStatusSrt = "-Status-";

  @override
  Widget build(BuildContext context) {
    tempStatus = controller.getStatusStrFromId(complain.status);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              AppTitleText2(title: "Update Complain",),

          //    AppText.mediumTitle("Update Complain"),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      _mWidget("Name", complain.name),
                      _mWidget("Desc", complain.description),
                      _mWidget("Priority", complain.priority),
                      _mWidget("Username", complain.fromUser.name),
                      _mWidget("Flat No", complain.fromUser.flatNo),
                      _mWidget("Contact.", complain.fromUser.mobile.toString()),
                      _mWidget("Email.", complain.fromUser.email),
                      _mWidget("From", complain.fromUser.name),
                      _mWidget("Raised On", complain.createdAt),

                      _mWidget(
                          "Status",
                          (complain.status == 1)
                              ? "Resolved"
                              : (complain.status == 2) ? "Failed" : "Pending"),
                    ],
                  ),
                ),),

              SizedBox(
                height: 16,
              ),
              Form(
                key:  controller.formKey,
                child:  Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: AppDropDown(
                        marginTop: 0,
                        dropdownList: controller.strStatusList,
                        selectedValue: selectedStatusSrt,
                        onValueChanged: (value){
                          selectedStatusSrt = value;
                        },
                        validator: (value)=>(value == "-Status-") ? "Select status" : (value == tempStatus) ? "Already "+value : null ,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppButton(
                        buttonText: "Update",
                        onPress: () {
                          if(!controller.formKey.currentState.validate()) return;
                          Navigator.pop(context,controller.getStatusIdFromStr(selectedStatusSrt));
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _mWidget(String title, String vale) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              )),
          Text(
            "  :  ",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Expanded(
              flex: 3,
              child: Text(
                vale,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ],
      ),
    );
  }
}

