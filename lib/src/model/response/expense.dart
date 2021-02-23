import '../expense.dart';
import '../expense_report.dart';

class ExpenseListResponse {
  List<Expense> expenses;
  int status;
  String message;

  ExpenseListResponse({this.expenses, this.status, this.message});

  ExpenseListResponse.fromJson(Map<String, dynamic> json) {
    if (json['expenses'] != null) {
      expenses = new List<Expense>();
      json['expenses'].forEach((v) {
        expenses.add(new Expense.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.expenses != null) {
      data['expenses'] = this.expenses.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

//Per User Expense Report Reponse

class PerUserExpenseReportResponse {
  List<ExpenseReportPerUser> reports;
  int status;
  String message;

  PerUserExpenseReportResponse({this.reports, this.status, this.message});

  PerUserExpenseReportResponse.fromJson(Map<String, dynamic> json) {
    if (json['reports'] != null) {
      reports = new List<ExpenseReportPerUser>();
      json['reports'].forEach((v) {
        reports.add(new ExpenseReportPerUser.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reports != null) {
      data['reports'] = this.reports.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

