import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_society/res/component/api.dart';
import 'package:t_society/res/component/text.dart';
import 'package:t_society/src/presentation/expense/report/per_user/list_view.dart';
import 'package:t_society/src/presentation/expense/report/per_user/page_view.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'controller.dart';

class ExpenseReportPerUserScreen
    extends GetView<ExpenseReportPerUserController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ExpenseReportPerUserController(context));
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(
        () {
          ApiResult result = controller.reportResultObs.value;
          return result.when(fetched: (data) {
            controller.reports = data.reports;
            return Column(
              children: [Expanded(child: Obx((){
                return (controller.viewMode.value ==1)
                    ? BuildPageViewModeScreen()
                    : BuildListViewModeScreen();
              }))],
            );
          }, init: () {
            return ApiProgress();
          });
        },
      ),
    );
  }

  _buildAppBar() => AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value){
              if(value == "List View")
                controller.viewMode.value = 2;
              else controller.viewMode.value = 1;
            },
            itemBuilder: (BuildContext context) {
              return {'List View', 'Page View'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: Text(
          "Expense History",
          style: TextStyle(fontSize: 22),
        ),
      );
}
