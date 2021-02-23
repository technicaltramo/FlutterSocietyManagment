import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/expense.dart';
import 'package:t_society/src/service/dio/dio_client.dart';
import 'package:t_society/src/data/repository/expense.dart';
import 'package:t_society/src/model/expense.dart';
import 'package:t_society/util/utils.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  DioClient _dioClient;

  ExpenseRepositoryImpl(this._dioClient);


  @override
  Future<CommonResponse> addExpense(
      String name, String des, String type, String amount) async {
    var data = {"name": name, "des": des, "type": type, "amount": amount};

    final result = await _dioClient.post("expense/add", data: data);
    var response = CommonResponse.fromJson(result);
    return response;
  }

  @override
  Future<ExpenseListResponse> fetchAllExpense(
      {bool currentMonthExpense = false}) async {
    final result = await _dioClient.get("expense/fetch-all",
        queryParameters: {"currentMonthExpense": currentMonthExpense});
    ExpenseListResponse response = ExpenseListResponse.fromJson(result);
    return response;
  }

  @override
  Future<CommonResponse> updateExpense(Expense expense) async {
    final result = await _dioClient.post("expense/update", data: expense.toJson());
    CommonResponse response = CommonResponse.fromJson(result);
    return response;
  }

  @override
  Future<CommonResponse> sendNotification(String type,String title,String body,{List<String> tokens}) async {

    var mData = {
      "type" : type,
      "tokens" : tokens,
      "title" : title,
      "body" : body
    };

   final result = await _dioClient.post("expense/send-notification",data:mData);
   Utils.printLog(result.toString());
   return CommonResponse.fromJson(result);
  }

}
