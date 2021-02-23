import 'package:get/get.dart';

class User {
  String sId;
  String role;
  bool active;
  String name;
  int mobile;
  String password;
  String email;
  int aadhaarNumber;
  String flatNo;
  String createdBy;
  String fcmToken;
  SocietyInfo societyInfo;
  int iV;
  //extra
  var isSelectedForNotification = false.obs;


  User(
      {this.sId,
        this.role,
        this.active,
        this.name,
        this.mobile,
        this.password,
        this.email,
        this.aadhaarNumber,
        this.flatNo,
        this.createdBy,
        this.iV,
        this.fcmToken,
        this.societyInfo});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    active = json['active'];
    name = json['name'];
    mobile = json['mobile'];
    password = json['password'];
    email = json['email'];
    aadhaarNumber = json['aadhaarNumber'];
    flatNo = json['flatNo'];
    createdBy = json['createdBy'];
    iV = json['__v'];
    fcmToken = json['fcmToken'];
    societyInfo = json['societyInfo'] != null
        ? new SocietyInfo.fromJson(json['societyInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['active'] = this.active;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['email'] = this.email;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['flatNo'] = this.flatNo;
    data['createdBy'] = this.createdBy;
    data['__v'] = this.iV;
    data['fcmToken'] = this.fcmToken;
    if (this.societyInfo != null) {
      data['societyInfo'] = this.societyInfo.toJson();
    }
    return data;
  }
}


class SocietyInfo {
  String societyName;
  String district;
  String state;
  String addressLine1;
  String addressLine2;
  String pinCode;
  String picUrl;

  SocietyInfo(
      {this.societyName,
        this.district,
        this.state,
        this.addressLine1,
        this.addressLine2,
        this.pinCode,
        this.picUrl,
      });

  SocietyInfo.fromJson(Map<String, dynamic> json) {
    societyName = json['name'];
    district = json['district'];
    state = json['state'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    pinCode = json['pinCode'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['societyName'] = this.societyName;
    data['district'] = this.district;
    data['state'] = this.state;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['pinCode'] = this.pinCode;
    data['picUrl'] = this.picUrl;
    return data;
  }
}

