import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/repository/expense_report.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class ExpenseReportPerUserController extends GetxController {

  BuildContext context;
  ExpenseReportPerUserController(this.context);

  var viewMode = 1.obs;


  ExpenseReportRepository repository = sl.get();
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

  @override
  void onInit() {
    selectedYear = yearList[0];
    fetchReport();
    super.onInit();
  }

  int currentPosition = 0;

  pageController(int initialPage) {
    return PageController(
        initialPage: initialPage, viewportFraction: 1, keepPage: true);
  }

  List<ExpenseReportPerUser> reports;

  var reportResultObs = ApiResult<PerUserExpenseReportResponse>.init().obs;
  fetchReport() async {
    try {
      final result = await repository.perUserReport("2020");
      reportResultObs.value = ApiResult.fetched(data: result);
    } catch (e) {
      Get.to(e);
    }
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
}
