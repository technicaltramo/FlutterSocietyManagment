import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/src/data/repository/expense.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/service/locator/locator.dart';

class AddExpenseController extends GetxController {
  final bool isEdit;
  ExpenseRepository expenseRepository = sl.get();
  BuildContext context;

  AddExpenseController({this.context,this.isEdit = false});

  String selectExpenseType = "Select Type";
  var addExpenseFormKey = GlobalKey<FormState>();
  var expenseNameEC = TextEditingController();
  var expenseDesEC = TextEditingController();
  var expenseAmountEC = TextEditingController();



  onButtonSubmitClick() async {
    if (!addExpenseFormKey.currentState.validate()) return;
    String expenseName = expenseNameEC.text;
    String expenseDes = expenseDesEC.text;
    String expenseAmount = expenseAmountEC.text;

    AppDialog.squareTransparentProgress(context);

    CommonResponse response = await expenseRepository
        .addExpense(expenseName,expenseDes,selectExpenseType,expenseAmount);
    Get.back();

    if (response.status == 1)
      LottieDialog.resStatus(context, response.message,
          lottieType: LottieType.SUCCESS).then((value){
            Get.back();
      });
    else
      LottieDialog.resStatus(context, response.message,
          lottieType: LottieType.FAILED).then((value) {

      });
  }
}
