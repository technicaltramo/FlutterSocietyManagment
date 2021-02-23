import 'package:t_society/src/data/repository/expense_report.dart';
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/model/response/expense_report.dart';
import 'package:t_society/src/service/dio/dio_client.dart';

class ExpenseReportRepositoryImpl extends ExpenseReportRepository{

  DioClient _dioClient;
  ExpenseReportRepositoryImpl(this._dioClient);

  @override
  Future<MonthlyViewExpenseReportResponse> monthlyExpenseView(String year) async {

    final result = await _dioClient.get("expense-report/fetch-expenses-monthly-view",queryParameters: {"year" : year});
    MonthlyViewExpenseReportResponse response = MonthlyViewExpenseReportResponse.fromJson(result);

    return response;

  }
  @override
  Future<YearlyViewExpenseReportResponse> yearlyExpenseView(String year) async {
    final result = await _dioClient.get("expense-report/fetch-expenses-yearly-view",queryParameters: {"year" : year});
    YearlyViewExpenseReportResponse response = YearlyViewExpenseReportResponse.fromJson(result);
    return response;

  }

  @override
  Future<PerUserExpenseReportResponse> perUserReport(String year) async {
    final result = await _dioClient.get("expense-report/per-user-report",queryParameters: {
      "year" : year
    });

    PerUserExpenseReportResponse response = PerUserExpenseReportResponse.fromJson(result);
    return response;
  }

}
