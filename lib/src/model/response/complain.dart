import 'package:t_society/src/model/response/pagination.dart';
import '../complain.dart';

class ComplainListResponse {
  Pagination pagination;
  List<Complain> complains;
  int count;
  int status;
  String message;

  ComplainListResponse(
      {this.pagination, this.complains, this.count, this.status, this.message});

  ComplainListResponse.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['complains'] != null) {
      complains = new List<Complain>();
      json['complains'].forEach((v) {
        complains.add(new Complain.fromJson(v));
      });
    }
    count = json['count'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination.toJson();
    }
    if (this.complains != null) {
      data['complains'] = this.complains.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}





