import 'package:t_society/src/model/expense_report.dart';
import 'package:t_society/src/model/user.dart';


/*monthly view*/

class MonthlyViewExpenseReportResponse {
  List<MonthlyViewExpenseReport> reports;
  int status;
  String message;

  MonthlyViewExpenseReportResponse({this.reports, this.status, this.message});

  MonthlyViewExpenseReportResponse.fromJson(Map<String, dynamic> json) {
    if (json['reports'] != null) {
      reports = new List<MonthlyViewExpenseReport>();
      json['reports'].forEach((v) {
        reports.add(new MonthlyViewExpenseReport.fromJson(v));
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




/*yearly view*/

class YearlyViewExpenseReportResponse {
  List<YearlyViewExpenseReport> reports;
  int status;
  String message;

  YearlyViewExpenseReportResponse({this.reports, this.status, this.message});

  YearlyViewExpenseReportResponse.fromJson(Map<String, dynamic> json) {
    if (json['reports'] != null) {
      reports = new List<YearlyViewExpenseReport>();
      json['reports'].forEach((v) {
        reports.add(new YearlyViewExpenseReport.fromJson(v));
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



