import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_society/src/data/repository/expense_report.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class ExpenseReportPerUserController extends GetxController {

  BuildContext context;

  ExpenseReportPerUserController(this.context);

  ExpenseReportRepository repository = sl.get();

  @override
  void onInit() {
    fetchReport();
    super.onInit();
  }

  List<ExpenseReportPerUser> reports;

  var reportResultObs = ApiResult<PerUserExpenseReportResponse>.init().obs;
  fetchReport() async{
   try{
     final result = await repository.perUserReport("2020");
     reportResultObs.value = ApiResult.fetched(data: result);
   }catch(e){
     Get.to(e);
   }

  }
}
