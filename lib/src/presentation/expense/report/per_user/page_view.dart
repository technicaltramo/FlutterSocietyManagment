import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/src/model/expense.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/util/extension/number_extn.dart';
import 'controller.dart';


class BuildPageViewModeScreen extends GetView<ExpenseReportPerUserController> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: <Widget>[
          buildTopWidget(),
          Expanded(
            child: PageView.builder(
                onPageChanged: (data) {
                  controller.currentPosition = data;
                },
                itemCount: controller.reports.length,
                controller: controller
                    .pageController(controller.reports.length - 1),
                itemBuilder: (BuildContext context, int position) {
                  return buildPageViewBuilder(position);
                }),
          )
        ],
      ),
    );
  }

  buildTopWidget() {

    int selectedPosition = controller.currentPosition;
    Color textColor = controller.colorFromIndex(selectedPosition);
    String month = controller.monthFromIndex(selectedPosition);
    String year = controller.selectedYear;
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          year + " - " + month,
          style: TextStyle(
              color: textColor, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );

  }

  Container buildPageViewBuilder(int index) {
    ExpenseReportPerUser report = controller.reports[index];
    List<Expense> expenses = report.expenses;
    var color = controller.colorFromIndex(index);

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: color[100]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //TOP
          Text(
            "Expenses",
            style: Theme.of(controller.context).textTheme.headline6,
          ),
          SizedBox(
            height: 8,
          ),
          //CONTENT
          Expanded(
            child: _ExpenseListView(expenses,index),
          ),
        ],
      ),
    );
  }
}


class _ExpenseListView extends GetView<ExpenseReportPerUserController> {
  final List<Expense> expenses;
  final int index;

  _ExpenseListView(this.expenses,this.index);

  @override
  Widget build(BuildContext context) {
    var color = controller.colorFromIndex(index);
    return Column(
      children: [
        Expanded(child: ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (BuildContext context, int index) {
              return buildCardItem(index);
            })),
        _PageViewBottomSection(color, index)
      ],
    );
  }

  buildCardItem(int index) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.red[100],
                child: Text((index + 1).toString()),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      expenses[index].name,
                      style: AppTextStyle.cardH2(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "\$ ${expenses[index].amount.toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.red),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey[400],
          height: 1,
          width: Get.width,
        )
      ],
    );
  }
}


// ignore: must_be_immutable
class _PageViewBottomSection extends GetView<ExpenseReportPerUserController> {
  final color;
  final pageViewIndex;
  ExpenseReportPerUser report;

  _PageViewBottomSection(this.color, this.pageViewIndex);

  @override
  Widget build(BuildContext context) {
    report = controller.reports[pageViewIndex];
    return Container(
      padding: EdgeInsets.all(4),
      width: Get.width,
      decoration: BoxDecoration(
          color: color[400], borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          buildAmountSection(color),
          SizedBox(
            width: 16,
          ),
          buildPaymentHistoryCircularAvatar(color)
        ],
      ),
    );
  }

  Expanded buildAmountSection(color) {


    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Column(
              children: <Widget>[
                buildTotalAmountWidget(color),
                SizedBox(
                  height: 4,
                ),
                buildPerUserAmountWidget(color),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildTotalAmountWidget(color) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "Total Amount",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: color[900]),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text("Rs. ${report.totalAmount}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color[900])),
        ),
      ],
    );
  }

  Row buildPerUserAmountWidget(color) {
    double totalAmount =
    report.totalAmount.toDouble();
    double perUserAmount = totalAmount/90;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "Per User",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: color),
          ),
        ),
        SizedBox(width: 12,),
        Expanded(
          child: Text("Rs. ${perUserAmount.toStringAsFixed(2)}",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: color)),
        ),
      ],
    );
  }

  Container buildUserCountWidget(color,count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
          color: color[100], borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.group,
            color: color[700],
          ),
          SizedBox(
            width: 8,
          ),
          Text(count.toString(),
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: color[900]))
        ],
      ),
    );
  }

  Column buildPaymentHistoryCircularAvatar(color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 25,
          child: Icon(Icons.group,size: 40,),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "90",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
