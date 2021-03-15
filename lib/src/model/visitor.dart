class Visitor {
  String visitorId;
  String subtype;
  String userId;
  String guardId;
  String visitorName;
  String visitorMobile;
  String vehicleNumber;
  String picUrl;
  String timeInMilliSecond;
  int status;

  Visitor(
      {this.visitorId,
      this.subtype,
      this.userId,
      this.guardId,
      this.visitorName,
      this.visitorMobile,
      this.vehicleNumber,
      this.picUrl,
      this.timeInMilliSecond,
      this.status});

  Visitor.fromJson(Map<String, dynamic> json) {
    visitorId = json['visitorId'];
    subtype = json['subtype'];
    userId = json['userId'];
    guardId = json['guardId'];
    visitorName = json['visitorName'];
    visitorMobile = json['visitorMobile'];
    vehicleNumber = json['vehicleNumber'];
    picUrl = json['picUrl'];
    timeInMilliSecond = json['timeInMilliSecond'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visitorId'] = this.visitorId;
    data['subtype'] = this.subtype;
    data['userId'] = this.userId;
    data['guardId'] = this.guardId;
    data['visitorName'] = this.visitorName;
    data['visitorMobile'] = this.visitorMobile;
    data['vehicleNumber'] = this.vehicleNumber;
    data['picUrl'] = this.picUrl;
    data['timeInMilliSecond'] = this.timeInMilliSecond;
    data['status'] = this.status;
    return data;
  }
}
