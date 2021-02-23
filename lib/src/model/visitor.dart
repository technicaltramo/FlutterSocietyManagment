class VisitorInfo {
  String name;
  String mobile;
  String vehicleNumber;
  int status;
  String picUrl;
  String  timeInMilliSecond;

  VisitorInfo(
      {this.name, this.mobile, this.vehicleNumber, this.status, this.picUrl,this.timeInMilliSecond});

  VisitorInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    vehicleNumber = json['vehicleNumber'];
    status = json['status'];
    picUrl = json['picUrl'];
    timeInMilliSecond = json['timeInMilliSecond'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['vehicleNumber'] = this.vehicleNumber;
    data['status'] = this.status;
    data['picUrl'] = this.picUrl;
    data['timeInMilliSecond'] = this.timeInMilliSecond;
    return data;
  }
}
