import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/dropdown.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/text_field.dart';
import 'package:t_society/src/presentation/complain/new_complain/controller.dart';

class NewComplainScreen extends GetView<NewComplainController> {
  @override
  Widget build(BuildContext context) {
    Get.put(NewComplainController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              key: controller.complainKey,
              child: Column(
                children: <Widget>[
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AppTitleText1(title: "Raise New Complain",),
                        //AppText.largeTitle("Raise New Complain"),
                        _buildComplainPriority(),
                        AppTextFormField(
                            controller: controller.complainNameController,
                            labelText: "Complain Name",
                            validator: (String value) {
                              return (value.length < 4)
                                  ? "can't be less than 4 character"
                                  : null;
                            }),
                        AppTextFormField(
                            controller:
                                controller.complainDescriptionController,
                            labelText: "Complain Description",
                            validator: (String value) {
                              return (value.length < 4)
                                  ? "can't be less than 4 character"
                                  : null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        AppButton(
                            buttonText: "Raise Complain",
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            onPress: () {
                              controller.onRaiseComplainButtonClicked(context);
                            }),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildComplainPriority() {
    List<String> ddList = ["Low", "Medium", "High"];
    ddList.insert(0, "Select Priority");
    return AppDropDown(
        selectedValue: controller.selectedPriority,
        dropdownList: ddList,
        validator: (String value) =>
            (value == "Select Priority") ? "Select Priority" : null,
        onValueChanged: (String value) {});
  }
}
