import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/util/date.dart';

import 'controller.dart';

class BuildListViewModeScreen extends GetView<ExpenseReportPerUserController> {
  @override
  Widget build(BuildContext context) {
    var reports = controller.reports;

    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) => _buildListItem(reports[index]),
    );
  }

  _buildListItem(ExpenseReportPerUser report) {
    var cardTitle = Theme.of(controller.context)
        .textTheme
        .headline6
        .copyWith(fontSize: 22, letterSpacing: 1.1);

    return GestureDetector(
      onTap: (){
        report.isExpenseListVisible.value = !report.isExpenseListVisible.value;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  //month
                  //year
                  //paid at
                  _buildMonthYearPaymentDateWidgets(report, cardTitle),
                  Spacer(),
                  //amount
                  //payment status
                  _buildAmountStatusWidgets(report, cardTitle)
                ],
              ),
            ),
            BuildHorizontalLine(),
            Obx(() {
              return Visibility(
                visible: report.isExpenseListVisible.value,
                child: Container(
                  width: double.infinity,
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text("hello dev"),
                      Text("hello dev"),
                      Text("hello dev"),
                      Text("hello dev"),
                      Text("hello dev"),
                      Text("hello dev"),
                      Text("hello dev")
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Padding _buildMonthYearPaymentDateWidgets(
      ExpenseReportPerUser report, TextStyle cardTitle) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${DateUtil.monthFromNumber(report.month)}",
            style: cardTitle,
          ),
          AppWidget.height(value: 4),
          Text(
            "Year : ${report.year}",
          ),
          Text(
            "paid at : ${DateUtil.dayMonthYearFromDateString(report.paymentAt)}",
          ),
        ],
      ),
    );
  }

  Container _buildAmountStatusWidgets(
      ExpenseReportPerUser report, TextStyle cardTitle) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.totalAmount.toString(),
            style: cardTitle,
          ),
          Text(
            (report.paymentStatus == 1) ? "Paid" : "Due",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: (report.paymentStatus == 1) ? Colors.green : Colors.red),
          ),
        ],
      ),
    );
  }
}
