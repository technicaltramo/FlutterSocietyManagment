import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/res/image.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/src/presentation/expense/expense_current_month.dart';
import 'package:t_society/src/presentation/expense/report/page_view/screen.dart';

import 'manage/controller.dart';

class ExpenseStartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(ManageExpenseController(context: context));
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // AppText.largeTitle("Expenses"),
              AppTitleText1(
                title: "Expenses",
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildCardItem("Manage", "Monthly expense", () {
                        Get.to(ExpenseCurrentMonthScreen());
                      }),
                      _buildCardItem("Report", "Payment/History", () {
                        Get.to(ExpenseMonthlyPageViewScreen());
                      }),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _buildCardItem(String title, String subTitle, Function onClick) {
    Color iconColor;
    LinearGradient cardColor;

    if (title == "Manage") {
      iconColor = Colors.blue;
      cardColor = LinearGradient(colors: [
        Colors.blue[100],
        Colors.blue[100],
        Colors.blue[100],
      ]);
    } else {
      iconColor = Colors.purple;
      cardColor = LinearGradient(colors: [
        Colors.purple[100],
        Colors.purple[100],
        Colors.purple[100],
      ]);
    }

    return Expanded(
      flex: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onClick,
        child: Card(
          child: Container(
            decoration: BoxDecoration(gradient: cardColor),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        AppImage.expense,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Text(
                      title,
                      style: AppTextStyle.text1(
                          fontSize: 22, color: Colors.black87),
                    ),
                    AppWidget.height(value: 4),
                    Text(
                      subTitle,
                      style: AppTextStyle.text2(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
