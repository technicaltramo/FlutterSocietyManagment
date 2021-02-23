import 'package:get/get.dart';
import 'package:t_society/src/data/repository/expense_report.dart';
import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/response/expense_report.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';
import 'package:t_society/util/utils.dart';

class ExpenseYearlyUserInfoController extends GetxController {
  ExpenseReportRepository repository = sl.get();
  String selectedYear;
  var yearlyViewResponse =
      ApiResult<YearlyViewExpenseReportResponse>.init().obs;
  List<YearlyViewExpenseReport> yearExpenseList;

  int mLenght = 0;

  ExpenseYearlyUserInfoController(this.selectedYear);

  @override
  void onInit() {

    super.onInit();
  }



  void fetchByYear() async {
    try {
      yearlyViewResponse.value = ApiResult.init();
      YearlyViewExpenseReportResponse response =
          await repository.yearlyExpenseView(selectedYear);
      yearlyViewResponse.value = ApiResult.fetched(data: response);
      Utils.printLog(response.toString());

    } catch (e) {
      Utils.printLog(e);
    }
  }
}
