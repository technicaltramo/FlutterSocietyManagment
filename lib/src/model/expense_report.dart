import 'package:t_society/src/model/user.dart';

import 'expense.dart';

/*monthly view*/

class MonthlyViewExpenseReport {
  String sId;
  int month;
  int year;
  int totalAmount;
  List<ExpenseUnderMonthlyView> expenses;
  List<PaymentInfoUnderMonthlyView> paymentInfo;
  List<String> paidUserIds;
  List<String> unpaidUserids;
  int totalUsersCount;

  MonthlyViewExpenseReport(
      {this.sId,
        this.month,
        this.year,
        this.totalAmount,
        this.expenses,
        this.paymentInfo,
        this.paidUserIds,
        this.unpaidUserids,
        this.totalUsersCount});

  MonthlyViewExpenseReport.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    month = json['month'];
    year = json['year'];
    totalAmount = json['totalAmount'];
    if (json['expenses'] != null) {
      expenses = new List<ExpenseUnderMonthlyView>();
      json['expenses'].forEach((v) {
        expenses.add(new ExpenseUnderMonthlyView.fromJson(v));
      });
    }
    if (json['paymentInfo'] != null) {
      paymentInfo = new List<PaymentInfoUnderMonthlyView>();
      json['paymentInfo'].forEach((v) {
        paymentInfo.add(new PaymentInfoUnderMonthlyView.fromJson(v));
      });
    }
    paidUserIds = json['paidUserIds'].cast<String>();
    unpaidUserids = json['unpaidUserids'].cast<String>();
    totalUsersCount = json['totalUsersCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['month'] = this.month;
    data['totalAmount'] = this.totalAmount;
    data['year'] = this.year;
    if (this.expenses != null) {
      data['expenses'] = this.expenses.map((v) => v.toJson()).toList();
    }
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo.map((v) => v.toJson()).toList();
    }
    data['paidUserIds'] = this.paidUserIds;
    data['unpaidUserids'] = this.unpaidUserids;
    data['totalUsersCount'] = this.totalUsersCount;
    return data;
  }
}

class ExpenseUnderMonthlyView {
  String name;
  int amount;
  String type;

  ExpenseUnderMonthlyView({this.name, this.amount, this.type});

  ExpenseUnderMonthlyView.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['type'] = this.type;
    return data;
  }
}

class PaymentInfoUnderMonthlyView {
  int paidAmount;
  String paymentAt;
  int paymentStatus;
  User userDetails;

  PaymentInfoUnderMonthlyView(
      {this.paidAmount, this.paymentAt, this.paymentStatus, this.userDetails});

  PaymentInfoUnderMonthlyView.fromJson(Map<String, dynamic> json) {
    paidAmount = json['paidAmount'];
    paymentAt = json['paymentAt'];
    paymentStatus = json['paymentStatus'];
    userDetails = json['userDetails'] != null
        ? new User.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paidAmount'] = this.paidAmount;
    data['paymentAt'] = this.paymentAt;
    data['paymentStatus'] = this.paymentStatus;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    return data;
  }
}



/*year view*/


class YearlyViewExpenseReport {
  String sId;
  String userId;
  int totalAmount;
  List<PaymentInfoUnderYearView> paymentInfo;
  User userDetails;

  YearlyViewExpenseReport({this.sId, this.userId, this.paymentInfo, this.userDetails});

  YearlyViewExpenseReport.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    totalAmount = json['totalAmount'];
    if (json['paymentInfo'] != null) {
      paymentInfo = new List<PaymentInfoUnderYearView>();
      json['paymentInfo'].forEach((v) {
        paymentInfo.add(new PaymentInfoUnderYearView.fromJson(v));
      });
    }
    userDetails = json['userDetails'] != null
        ? new User.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['totalAmount'] = this.totalAmount;
    if (this.paymentInfo != null) {
      data['paymentInfo'] = this.paymentInfo.map((v) => v.toJson()).toList();
    }
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails.toJson();
    }
    return data;
  }
}

class PaymentInfoUnderYearView {
  int month;
  int paidAmount;
  String paymentAt;
  int paymentStatus;

  PaymentInfoUnderYearView(
      {this.month, this.paidAmount, this.paymentAt, this.paymentStatus});

  PaymentInfoUnderYearView.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    paidAmount = json['paidAmount'];
    paymentAt = json['paymentAt'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['paidAmount'] = this.paidAmount;
    data['paymentAt'] = this.paymentAt;
    data['paymentStatus'] = this.paymentStatus;
    return data;
  }
}


//expense report per user


class ExpenseReportPerUser {
  String sId;
  int month;
  int year;
  List<Expense> expenses;
  String paymentAt;
  int paymentStatus;
  int totalAmount;

  ExpenseReportPerUser(
      {this.sId,
        this.month,
        this.year,
        this.expenses,
        this.paymentAt,
        this.paymentStatus,
        this.totalAmount});

  ExpenseReportPerUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    month = json['month'];
    year = json['year'];
    if (json['expenses'] != null) {
      expenses = new List<Expense>();
      json['expenses'].forEach((v) {
        expenses.add(new Expense.fromJson(v));
      });
    }
    paymentAt = json['paymentAt'];
    paymentStatus = json['paymentStatus'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['month'] = this.month;
    data['year'] = this.year;
    if (this.expenses != null) {
      data['expenses'] = this.expenses.map((v) => v.toJson()).toList();
    }
    data['paymentAt'] = this.paymentAt;
    data['paymentStatus'] = this.paymentStatus;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}