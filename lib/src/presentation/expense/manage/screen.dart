import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/style/text_style.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/src/model/expense.dart';
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/presentation/expense/add/screen.dart';
import 'package:t_society/src/presentation/expense/manage/controller.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class ManageExpenseScreen extends StatefulWidget {
  @override
  _ManageExpenseScreenState createState() => _ManageExpenseScreenState();
}

class _ManageExpenseScreenState extends State<ManageExpenseScreen> {
  ManageExpenseController controller;

  @override
  void initState() {
    controller = Get.put(ManageExpenseController(context : context));
    controller.fetchAllExpense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _buildFloatingActionButton(),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppTitleText1(title: "Manage Expenses",),
            //  AppText.largeTitle("Manage Expenses"),
              Expanded(
                child: Obx(() {
                  ApiResult result = controller.allExpensesListObs.value;

                  return result.when(fetched: (data) {
                    ExpenseListResponse response = data;
                    if (response.status == 1) {

                      return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          itemCount: response.expenses.length,
                          itemBuilder: (context, index) {
                            return buildCardItem(index, response.expenses);
                          });
                    } else
                      return Container(
                        child: Center(
                          child: Text(response.message),
                        ),
                      );
                  }, init: () {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Get.to(AddExpenseScreen()).then((value){

        });
      },
      backgroundColor: Colors.green,
      icon: Icon(Icons.add),
      label: Text("Add new expense"),
    );
  }

  Padding buildCardItem(int index, List<Expense> expenses) {
    Expense expense = expenses[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        elevation: 1,
        shape: Border(),
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
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
                    SizedBox(height: 4,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Need for the month",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: (expense.isSelectedForCurrentMonth)
                                  ? Colors.green
                                  : Colors.red
                          ),
                        ),
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: Checkbox(
                            value: expense.isSelectedForCurrentMonth,
                            onChanged: (value) {
                              setState(() {
                                expense.isSelectedForCurrentMonth = value;
                                controller.updateExpense(expense);
                              });
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                "\$ ${expense.amount.toString()}",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              SizedBox(width: 8,),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){
                  Get.to(AddExpenseScreen(isEdit: true,));
                },
                child: CircleAvatar(
                  child: Icon(Icons.edit),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
