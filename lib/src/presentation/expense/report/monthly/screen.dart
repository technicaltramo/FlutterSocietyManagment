import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/user.dart';
import 'package:t_society/src/presentation/expense/report/monthly/controller.dart';
import 'package:t_society/util/date.dart';

// ignore: must_be_immutable
class ExpenseMonthlyUserInfoScreen extends StatelessWidget {
  final MonthlyViewExpenseReport expenseReport;
  final color;
  final String selectedYear;

  ExpenseMonthlyUserInfoScreen(
      this.expenseReport, this.color, this.selectedYear);

  ExpenseMonthlyUserInfoController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(ExpenseMonthlyUserInfoController(
        context, expenseReport, color, selectedYear));

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              AppTitleText1(title: "Payment History For Month",),
             // AppText.largeTitle("Payment History For Month"),
              HeaderSection(),
              Expanded(
                child: ListView.builder(
                    itemCount: expenseReport.paymentInfo.length,
                    itemBuilder: (context, index) {
                      PaymentInfoUnderMonthlyView userInfo = expenseReport.paymentInfo[index];
                      return _buildListCard(userInfo);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildListCard(PaymentInfoUnderMonthlyView paymentInfo) {

    User user = paymentInfo.userDetails;
    String strDate = DateUtil.dayMonthYearFromDateString(paymentInfo.paymentAt);

    Color color;
    IconData icon;
    String strStatus;

    if (paymentInfo.paymentStatus == 1) {
      color = Colors.green;
      icon = Icons.done_all;
      strStatus = "Paid";

    } else if (paymentInfo.paymentStatus == 0) {
      color = Colors.red;
      icon = Icons.cancel;
      strStatus = "Due";
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        if (user.isSelectedForNotification.value == true) {
          user.isSelectedForNotification.value = false;
          if (controller.selectionCount.value != 0) {
            controller.selectionCount.value -= 1;
            controller.selectedUsers.remove(user);
          }
        } else {
          user.isSelectedForNotification.value = true;
          controller.selectionCount.value += 1;
          controller.selectedUsers.add(user);
        }
      },
      onTap: () {
        if (user.isSelectedForNotification.value == true) {
          user.isSelectedForNotification.value = false;
          if (controller.selectionCount.value != 0) {
            controller.selectionCount.value -= 1;
            controller.selectedUsers.remove(user);
          }
        } else {
          if (controller.selectionCount.value > 0) {
            user.isSelectedForNotification.value = true;
            controller.selectionCount.value += 1;
            controller.selectedUsers.add(user);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.white,
                  child: Obx(() {
                    return (user.isSelectedForNotification.value)
                        ? Icon(Icons.done)
                        : Image.asset(
                            AppImage.userIcon,
                            width: 40,
                            height: 40,
                          );
                  }),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${user.name}",
                          style: AppTextStyle.cardH2(),
                        ),
                        AppWidget.height(value: 4),
                        Text(
                          "${user.mobile} - ${user.flatNo}",
                          style: AppTextStyle.text2(),
                        ),
                        (paymentInfo.paymentStatus == 1)
                            ? Text(
                                "payment at : $strDate",
                                style: AppTextStyle.text2(),
                              )
                            : Nothing(),

                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        icon,
                        color: color,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        strStatus,
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )
                    ],
                  ),
                )
              ],
            ),
            BuildHorizontalLine(),
          ],
        ),
      ),
    );
  }
}


class HeaderSection extends GetView<ExpenseMonthlyUserInfoController> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildTotalAmountWidget(controller.color),
                  SizedBox(
                    height: 4,
                  ),
                  buildPerUserAmountWidget(controller.color),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildUserCountWidget(Colors.green, controller.expenseReport.totalUsersCount.toString(), true),
                          buildUserCountWidget(Colors.red, controller.expenseReport.unpaidUserids.length.toString(), false)
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.onSendNotificationButtonClicked();
                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.red[500],
                              borderRadius: BorderRadius.circular(30),
                              border:
                              Border.all(color: Colors.red, width: 1.5)),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Obx(() {
                                return Text(
                                  (controller.selectionCount.value > 0)
                                      ? "Selected Users"
                                      : "All Due Users",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                );
                              })
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Row buildTotalAmountWidget(color) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
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
          flex: 2,
          child: Text("Rs. ${controller.expenseReport.totalAmount}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color[900])),
        ),
      ],
    );
  }

  Row buildPerUserAmountWidget(color) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
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
          flex: 2,
          child: Text(
              "Rs. ${controller.expenseReport.totalAmount / controller.expenseReport.totalUsersCount}",
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500, color: color)),
        ),
      ],
    );
  }

  Container buildUserCountWidget(color, String userCount, bool active) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
            width: 4,
          ),
          Text(((active) ? "Paid : " : "Due  : ") + userCount,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w400, color: color[900]))
        ],
      ),
    );
  }
}
