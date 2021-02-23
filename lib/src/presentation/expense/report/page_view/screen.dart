import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/api.dart';
import 'package:t_society/res/component/dropdown.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/response/expense_report.dart';
import 'package:t_society/src/presentation/expense/report/yearly/screen.dart';
import 'package:t_society/util/api_resource/api_result.dart';

import 'controller.dart';

class ExpenseMonthlyPageViewScreen
    extends GetView<ExpenseMonthlyPageViewController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ExpenseMonthlyPageViewController(context));
    return SafeArea(child: Scaffold(
      body: Obx(() {
        ApiResult result = controller.expenseReportListObs.value;
        return result.when(
          init: () => ApiProgress(),
          fetched: (data) {
            MonthlyViewExpenseReportResponse response = data;
            int length = response.reports.length;
            controller.currentPosition = length - 1;

            if (response.status == 1) {
              if (length > 0) {
                controller.expenseReportList = response.reports;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   // AppText.largeTitle("Expense Head"),
                    AppTitleText1(title:  "Expense Head",),
                    Expanded(child: _ExpensePageView()),
                    buildTotalAmount()
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

  Card buildTotalAmount() {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(8),
        width: Get.width,
        child: Row(
          children: <Widget>[
            Expanded(
                child: AppDropDown(
              onValueChanged: (value) {
                controller.selectedYear = value;
                controller.fetchByYear();
              },
              dropdownList: controller.yearList,
              selectedValue: controller.selectedYear,
              marginTop: 0,
            )),
            SizedBox(
              width: 16,
            ),
            buildPaymentHistoryCircularAvatar()
          ],
        ),
      ),
    );
  }

  Column buildPaymentHistoryCircularAvatar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Get.to(ExpenseYearlyUserInfoScreen(controller.selectedYear));
          },
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            radius: 25,
            child: Image.asset(
              AppImage.expense,
              width: 32,
              height: 32,
              color: Colors.blue[900],
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Yearly\nPayment",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

class _ExpensePageView extends GetView<ExpenseMonthlyPageViewController> {
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
                itemCount: controller.expenseReportList.length,
                controller: controller
                    .pageController(controller.expenseReportList.length - 1),
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
    MonthlyViewExpenseReport expenseReport = controller.expenseReportList[index];
    List<ExpenseUnderMonthlyView> expenses = expenseReport.expenses;
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
            child: _ExpenseListView(expenses),
          ),

          //BOTTOM
          _PageViewBottomSection(color, index)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _PageViewBottomSection extends GetView<ExpenseMonthlyPageViewController> {
  final color;
  final pageViewIndex;
  MonthlyViewExpenseReport expenseReport;

  _PageViewBottomSection(this.color, this.pageViewIndex);

  @override
  Widget build(BuildContext context) {
    expenseReport = controller.expenseReportList[pageViewIndex];
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

    var totalUser = expenseReport.totalUsersCount;
    var unpaidUsers = expenseReport.unpaidUserids.length;
    var paidUsers = expenseReport.paidUserIds.length;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buildUserCountWidget(Colors.green,"$totalUser / $paidUsers"),
                    buildUserCountWidget(Colors.red,unpaidUsers),
                  ],
                )
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
          child: Text("Rs. ${expenseReport.totalAmount}",
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
    expenseReport.totalAmount.toDouble();
    double perUserAmount = totalAmount / expenseReport.totalUsersCount;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "Per User",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: color),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text("Rs. $perUserAmount",
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
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.gotoMonthlyUserInfoScreen(color);

          },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            child: Image.asset(
              AppImage.expense,
              width: 32,
              height: 32,
              color: color[900],
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Monthly\nPayment",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

class _ExpenseListView extends GetView<ExpenseMonthlyPageViewController> {
  final List<ExpenseUnderMonthlyView> expenses;

  _ExpenseListView(this.expenses);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (BuildContext context, int index) {
          return buildCardItem(index);
        });
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
