import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/data/repository/expense.dart';
import 'package:t_society/src/model/expense.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/presentation/error_screen.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class ManageExpenseController extends GetxController {
  BuildContext context;
  ExpenseRepository expenseRepository = sl.get();
  AppPreference appPreference = sl.get();

  ManageExpenseController({this.context});
  var allExpensesListObs = ApiResult<ExpenseListResponse>.init().obs;
  var currentMonthExpensesListObs = ApiResult<ExpenseListResponse>.init().obs;

  var amountsObs = 0.0.obs;




  @override
  void onInit() {
    observeAmountChanges();
    super.onInit();
  }

  fetchAllExpense({bool currentMonthExpense = false}) async {
    ExpenseListResponse response = await expenseRepository.fetchAllExpense(
        currentMonthExpense: currentMonthExpense);
    if (currentMonthExpense)
      currentMonthExpensesListObs.value = ApiResult.fetched(data: response);
    else
      allExpensesListObs.value = ApiResult.fetched(data: response);
  }

  updateExpense(Expense expense) async {
    try {
      AppDialog.squareTransparentProgress(context, title: "Updating...");
      CommonResponse response = await expenseRepository.updateExpense(expense);
      Get.back();

      if (response.status == 1)
        LottieDialog.resStatus(context, response.message,
            lottieType: LottieType.SUCCESS);
      else
        LottieDialog.resStatus(context, response.message,
            lottieType: LottieType.FAILED);
    } catch (e) {
      Get.back();
      Get.to(ErrorScreen(e));
    }
  }

  observeAmountChanges(){



    currentMonthExpensesListObs.listen((value) {
      value.when(fetched: (data){
        ExpenseListResponse response = data;
        if(response.expenses.length > 0 ){
          double amount = 0.0;
          response.expenses.forEach((element) {
            double mAmount = element.amount.toDouble();
            amount += mAmount;
          });
          amountsObs.value = amount;
        }
      }, init: (){});
    });
  }

}
