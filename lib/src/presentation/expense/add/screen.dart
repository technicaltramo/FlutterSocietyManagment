import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/button.dart';
import 'package:t_society/res/component/dropdown.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/text_field.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/presentation/expense/add/controller.dart';

class AddExpenseScreen extends GetView<AddExpenseController> {
  final bool isEdit;
  AddExpenseScreen({this.isEdit = false});


  @override
  Widget build(BuildContext context) {
    Get.put(AddExpenseController(context : context,isEdit: isEdit));
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppTitleText1(title: isEdit ? "Edit Expenses" : "Add New Expenses",),
               // AppText.largeTitle(),
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildForm() {
    var inputNode = FocusScope.of(controller.context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: controller.addExpenseFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  _buildExpenseTypeDropDown(),
                  AppTextFormField(
                      onEditingComplete: () => inputNode.nextFocus(),
                      controller: controller.expenseNameEC,
                      labelText: "Name",
                      validator: (String value) {
                        return (value.length < 3)
                            ? "can't be less than 3 character"
                            : null;
                      }),
                  AppTextFormField(
                      onEditingComplete: () => inputNode.nextFocus(),
                      controller: controller.expenseDesEC,
                      labelText: "Description",
                      validator: (String value) {
                        return (value.length < 4)
                            ? "can't be less than 4 character"
                            : null;
                      }),
                  AppTextFormField(
                      onEditingComplete: () => inputNode.nextFocus(),
                      controller: controller.expenseAmountEC,
                      labelText: "Amount",
                      fieldType: TextFieldType.NUMBER,
                      validator: (String value) {
                        if(value.isEmpty)
                          return "Enter valid amount";
                        else{
                          double amount = double.parse(value);
                          if(amount>0){
                            return null;
                          } else return "Zero is not valid amount";
                        }
                      }),

                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            AppWidget.height(value: 20),
            AppButton(
                buttonText: "Submit",
                padding: EdgeInsets.symmetric(horizontal: 12),
                onPress: () {
                  controller.onButtonSubmitClick();
                }),
          ],
        ),
      ),
    );
  }

  _buildExpenseTypeDropDown() {
    var ddList = List<String>();
    ddList.add("Monthly");
    ddList.add("Yearly");
    ddList.insert(0, "Select Type");
    return AppDropDown(
        dropdownList: ddList,
        selectedValue: controller.selectExpenseType,
        validator: (String value) =>
            (value == "Select Type") ? "Select Expense Type" : null,
        onValueChanged: (String value) {
          controller.selectExpenseType = value;
        });
  }
}
