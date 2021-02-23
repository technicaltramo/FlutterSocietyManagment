import 'package:t_society/src/model/user.dart';

class Complain {
  String priority;
  int status;
  String sId;
  String name;
  String description;
  User toUser;
  User fromUser;
  int iV;
  String createdAt;
  String updatedAt;

  Complain(
      {this.priority,
        this.status,
        this.sId,
        this.name,
        this.description,
        this.toUser,
        this.fromUser,
        this.iV,
        this.createdAt,
        this.updatedAt});

  Complain.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    status = json['status'];
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    toUser =
    json['toUser'] != null ? new User.fromJson(json['toUser']) : null;
    fromUser = json['fromUser'] != null
        ? new User.fromJson(json['fromUser'])
        : null;
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.toUser != null) {
      data['toUser'] = this.toUser.toJson();
    }
    if (this.fromUser != null) {
      data['fromUser'] = this.fromUser.toJson();
    }
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}