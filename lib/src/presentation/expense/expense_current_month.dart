import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/widget.dart';
import 'package:t_society/res/string.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/src/model/expense.dart';
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/presentation/expense/manage/screen.dart';
import 'package:t_society/util/api_resource/api_result.dart';

import 'manage/controller.dart';
import 'package:t_society/src/presentation/expense/report/per_user/screen.dart';

class ExpenseCurrentMonthScreen extends GetView<ManageExpenseController> {


  @override
  Widget build(BuildContext context) {
    Get.put(ManageExpenseController(context: context));
    String role = controller.appPreference.user.role;


    controller.fetchAllExpense(currentMonthExpense: true);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTitleText1(title: "This month Expenses",),
              Align(
                alignment: Alignment.topRight,
                child: RaisedButton(
                  color: (role == AppString.ROLE_USER) ? Colors.red : Colors.blue,
                  onPressed: () {
                   if(role == AppString.ROLE_USER)
                     Get.to(ExpenseReportPerUserScreen());
                   else Get.to(ManageExpenseScreen()).then((value) {
                     controller.fetchAllExpense(currentMonthExpense: true);
                   });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        (role == AppString.ROLE_USER) ? Icons.history : Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        (role == AppString.ROLE_USER) ? "Expense History"  : "Manage",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  ApiResult result =
                      controller.currentMonthExpensesListObs.value;
                  return result.when(fetched: (data) {
                    ExpenseListResponse response = data;
                    if (response.status == 1) {
                      if (response.expenses.length > 0) {
                        return ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            itemCount: response.expenses.length,
                            itemBuilder: (context, index) {
                              return buildCardItem(index, response.expenses);
                            });
                      } else
                        return Center(
                          child: Text("No expense found"),
                        );
                    } else
                      return Center(
                        child: Text(response.message),
                      );
                  }, init: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  });
                }),
              ),
              buildTotalAmount()
            ],
          ),
        ),
      ),
    );
  }

  Card buildTotalAmount() {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(16),
        width: Get.width,
        child: Obx(() {
          String totalAmount = controller.amountsObs.value.toString();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Text(
                      "Total Expenses",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "₹ $totalAmount",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Text(
                      "Per Member",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "₹ ${double.parse(totalAmount) / 1}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  buildCardItem(int index, List<Expense> expenses) {
    Expense expense = expenses[index];

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
                      expense.name,
                      style: AppTextStyle.cardH2(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      expense.description,
                      style: AppTextStyle.text2(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "₹ ${expense.amount.toString()}",
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
