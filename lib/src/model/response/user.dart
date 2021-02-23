import 'package:t_society/src/model/response/pagination.dart';

import '../user.dart';

//Login Response
class LoginResponse {
  String token = "";
  User user = User();
  int status;
  String message;

  LoginResponse({this.token, this.user, this.status, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

//User List Response
class UserListResponse {
  int status;
  String message;
  List<User> users;
  Pagination pagination;

  UserListResponse({this.pagination,this.status, this.message, this.users});

  UserListResponse.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    status = json['status'];
    message = json['message'];
    if (json['users'] != null) {
      users = new List<User>();
      json['users'].forEach((v) {
        users.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}