import 'dart:io';

import 'package:dio/dio.dart';
import 'package:t_society/src/data/repository/visitor.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/service/dio/dio_client.dart';

class VisitorRepositoryImpl extends VisitorRepository {
  DioClient _dioClient;

  VisitorRepositoryImpl(this._dioClient);

  @override
  Future<CommonResponse> newVisitorEntry(File visitorPhoto, String userId,
      String name, String mobile, String vehicleNumber) async {
    FormData data = FormData.fromMap({
      "visitorPic": await MultipartFile.fromFile(visitorPhoto.path,
          filename: "visitorPic"),
      "name": name,
      "toUser": userId,
      "mobile": mobile,
      "vehicleNumber": vehicleNumber ?? "na",
    });
    final result =
        await _dioClient.post("visitor/new-visitor-entry", data: data);
    return CommonResponse.fromJson(result);
  }

  @override
  Future<CommonResponse> onVisitorAcceptReject(
      bool isAccept, String fromUser, String toGuard,String visitorId) async {
    var response = await _dioClient.post("visitor/on-accept-reject", data: {
      "isAccept": isAccept.toString(),
      "visitorId": visitorId,
      "fromUser": fromUser,
      "toGuard": toGuard
    });

    return CommonResponse.fromJson(response);
  }
}
