import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/repository/expense_report.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/response/expense_report.dart';
import 'package:t_society/src/presentation/expense/report/monthly/screen.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class ExpenseMonthlyPageViewController extends GetxController {

  final BuildContext context;
  ExpenseMonthlyPageViewController(this.context);
  ExpenseReportRepository repository = sl.get();
  int currentPosition = 0;
  List<String> yearList = ["2020", "2021", "2022"];
  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String selectedYear;
  var expenseReportListObs = ApiResult<MonthlyViewExpenseReportResponse>.init().obs;
  List<MonthlyViewExpenseReport> expenseReportList;

  @override
  void onInit() {
    selectedYear = yearList[0];
    fetchByYear();
    super.onInit();
  }

  colorFromIndex(int index) {
    Color color;
    switch (index) {
      case 0:
        color = Colors.blue;
        break;
      case 1:
        color = Colors.blueGrey;
        break;
      case 2:
        color = Colors.pink;
        break;
      case 3:
        color = Colors.green;
        break;
      case 4:
        color = Colors.blue;
        break;
      case 5:
        color = Colors.blueGrey;
        break;
      case 6:
        color = Colors.pink;
        break;
      case 7:
        color = Colors.green;
        break;
      case 8:
        color = Colors.blue;
        break;
      case 9:
        color = Colors.blueGrey;
        break;
      case 10:
        color = Colors.pink;
        break;
      case 11:
        color = Colors.green;
        break;
      default:
        color = Colors.green;
    }
    return color;
  }

  monthFromIndex(int index) => monthList[index];

  pageController(int initialPage) {
    return PageController(
        initialPage: initialPage, viewportFraction: 1, keepPage: true);
  }

  void fetchByYear() async {
    try {
      expenseReportListObs.value = ApiResult.init();
      MonthlyViewExpenseReportResponse response =
      await repository.monthlyExpenseView(selectedYear);
      expenseReportListObs.value = ApiResult.fetched(data: response);
      Utils.printLog(response.toString());
    } catch (e) {
      Utils.printLog(e);
    }
  }

  void gotoMonthlyUserInfoScreen(color) {
    Get.to(ExpenseMonthlyUserInfoScreen(
      expenseReportList[currentPosition],
      color,
      selectedYear
    ));
  }
}
