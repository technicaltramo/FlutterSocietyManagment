

import 'package:t_society/src/model/expense.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/expense.dart';

abstract class ExpenseRepository{
  Future<CommonResponse> addExpense(String name, String des,String type,String amount);
  Future<ExpenseListResponse> fetchAllExpense({bool currentMonthExpense = false});
  Future<CommonResponse> updateExpense(Expense expense);
  Future<CommonResponse> sendNotification(String type,String title, String body,{List<String> tokens});
}