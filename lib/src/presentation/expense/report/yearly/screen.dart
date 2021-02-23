import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_society/res/component/api.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/response/expense_report.dart';
import 'package:t_society/src/presentation/expense/report/yearly/controller.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

// ignore: must_be_immutable
class ExpenseYearlyUserInfoScreen extends GetView<ExpenseYearlyUserInfoController> {
  final String selectedYear;
  ExpenseYearlyUserInfoScreen(this.selectedYear);

  @override
  Widget build(BuildContext context) {
    Get.put(ExpenseYearlyUserInfoController(selectedYear));
    controller.fetchByYear();

    return SafeArea(child: Scaffold(
      body: Obx(() {
        ApiResult result = controller.yearlyViewResponse.value;
        return result.when(
          init: () => ApiProgress(),
          fetched: (data) {
            YearlyViewExpenseReportResponse response = data;
            controller.yearExpenseList = response.reports;
            int length = response.reports.length;
            controller.mLenght = length;
            Utils.printLog(length);
            if (response.status == 1) {
              if (length > 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   // AppText.largeTitle("Yearly Payment"),
                    AppTitleText1(title:  "Yearly Payment",),
                    Expanded(child: _UserList(length)),
                  ],
                );
              } else
                return ApiNoDataFound();
            } else
              return ApiSomethingWentWrong();
          },
        );
      }),
    ));
  }
}

class _UserList extends GetView<ExpenseYearlyUserInfoController> {

  final int length;
  _UserList(this.length);

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 1353,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildMonths(0),
                  _buildMonths(1),
                  _buildMonths(2),
                  _buildMonths(3),
                  _buildMonths(4),
                  _buildMonths(5),
                  _buildMonths(6),
                  _buildMonths(7),
                  _buildMonths(8),
                  _buildMonths(9),
                  _buildMonths(10),
                  _buildMonths(11),
                  _buildMonths(12)
                ],
              ),
              BuildHorizontalLine(),
              Expanded(
                child: ListView.builder(
                    itemCount: controller.yearExpenseList.length,
                    itemBuilder: (context, index) {
                      return _BuildListItem(controller.yearExpenseList[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildMonths(int index) {
    String text;
    var color;
    if (index == 1) {
      text = "Jan";
      color = Colors.red;
    } else if (index == 2) {
      text = "Feb";
      color = Colors.blue;
    } else if (index == 3) {
      text = "March";
      color = Colors.green;
    } else if (index == 4) {
      text = "April";
      color = Colors.grey;
    } else if (index == 5) {
      text = "May";
      color = Colors.pink;
    } else if (index == 6) {
      text = "June";
      color = Colors.purple;
    } else if (index == 7) {
      text = "July";
      color = Colors.red;
    } else if (index == 8) {
      text = "Aug";
      color = Colors.blue;
    } else if (index == 9) {
      text = "Sep";
      color = Colors.green;
    } else if (index == 10) {
      text = "Oct";
      color = Colors.grey;
    } else if (index == 11) {
      text = "Nov";
      color = Colors.pink;
    } else if (index == 12) {
      text = "Dec";
      color = Colors.purple;
    } else {
      text = "Users - 20";
      color = Colors.white;
    }

    return Container(
      height: 50,
      width: (index == 0) ? 140 : 101,
      padding: EdgeInsets.all(8),
      color: (index == 0) ? Colors.black54 : Colors.black12,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: color),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _BuildListItem extends GetView<ExpenseYearlyUserInfoController> {
  YearlyViewExpenseReport yearlyExpenseReport;
  List<PaymentInfoUnderYearView> paymenInfos;
  _BuildListItem(this.yearlyExpenseReport){
    this.paymenInfos = yearlyExpenseReport.paymentInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            buildUserNameSection(),
            BuildVerticalLine(50),
            buildPaymentInfoSection()
          ],
        ),
        BuildHorizontalLine()
      ],
    );
  }

  Row buildPaymentInfoSection() {
    return Row(
        children: List.generate(yearlyExpenseReport.paymentInfo.length, (index) {
      Color color;
      IconData icon;
      String text;
      PaymentInfoUnderYearView info =paymenInfos[index];
      if (info.paymentStatus == 1) {
        color = Colors.green;
        icon = Icons.done_all;
        text = "Paid";
      } else if (info.paymentStatus == 0) {
        color = Colors.red;
        icon = Icons.cancel;
        text = "Due";
      }

      return Row(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: showInfoDialog,
            child: Container(
              height: 50,
              width: 100,
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(icon,color: color,size: 20,)
                    ],
                  ),
                  Text(
                    (yearlyExpenseReport.totalAmount/controller.mLenght).toString(),
                    style: TextStyle(color: color, fontWeight: FontWeight.w400),
                  )
                ],
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
          BuildVerticalLine(50)
        ],
      );
    }));
  }

  showInfoDialog() {
    return Get.defaultDialog(
        title: "User Payment Info", content: Text("Work in progress"));
  }

  Container buildUserNameSection() {
    return Container(
        width: 140,
        height: 50,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  yearlyExpenseReport.userDetails.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  yearlyExpenseReport.userDetails.flatNo,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                )
              ],
            )));
  }
}
