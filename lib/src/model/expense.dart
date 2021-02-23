class Expense {
  String type;
  bool isSelectedForCurrentMonth;
  String sId;
  String name;
  String description;
  int amount;
  String createdAt;
  String updatedAt;
  int iV;

  Expense(
      {this.type,
        this.isSelectedForCurrentMonth,
        this.sId,
        this.name,
        this.description,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Expense.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    isSelectedForCurrentMonth = json['isSelectedForCurrentMonth'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['isSelectedForCurrentMonth'] = this.isSelectedForCurrentMonth;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}