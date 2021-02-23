import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/dialog.dart';
import 'package:t_society/res/lottie.dart';
import 'package:t_society/src/data/repository/expense.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/utils.dart';

class ExpenseMonthlyUserInfoController extends GetxController {

  final BuildContext context;
  final color;
  final MonthlyViewExpenseReport expenseReport;
  final selectedYear;

  ExpenseMonthlyUserInfoController(
      this.context,
      this.expenseReport,
      this.color,
      this.selectedYear);

  var selectionCount = 0.obs;
  ExpenseRepository repository = sl.get();
  List<User> selectedUsers = List();

  @override
  void onInit() {
    super.onInit();
  }


  onSendNotificationButtonClicked() async {
    String title;
    if (selectionCount.value > 0) {
      title = "Send Payment Reminder To Selected Users";
    } else {
      title = "Send Payment Reminder To All Due Users";
    }

    AppDialog.sendNotificationDialog(context, title).then((value) {
      if (value != null) {
        if (value.isNotEmpty) {
          _sendNotification("Payment reminder for this month", value);
        }
      }
    });
  }

  _sendNotification(String title, String body) async {
    String mType = (selectionCount.value > 0) ? "selected" : "due";

    List<String> tokens = List();

    if (selectedUsers.length > 0) {
      selectedUsers.forEach((element) {
        if (element.fcmToken != null) {
          if (element.fcmToken.isNotEmpty) {
            tokens.add(element.fcmToken);
          }
        }
      });
    }

    try {
      AppDialog.squareTransparentProgress(context,
          title: "Sending Notification");
      CommonResponse response =
          await repository.sendNotification(mType, title, body, tokens: tokens);
      Get.back();
      if (response.status == 1) {
        LottieDialog.resStatus(context, response.message,
            lottieType: LottieType.SUCCESS);
      } else
        LottieDialog.resStatus(context, response.message,
            lottieType: LottieType.FAILED);
    } catch (e) {
      Utils.printLog(e);
    }
  }
}
