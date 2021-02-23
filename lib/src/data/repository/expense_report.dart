
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/model/response/expense_report.dart';

abstract class ExpenseReportRepository{
  Future<MonthlyViewExpenseReportResponse> monthlyExpenseView(String year);
  Future<YearlyViewExpenseReportResponse> yearlyExpenseView(String year);
  Future<PerUserExpenseReportResponse> perUserReport(String year);
}