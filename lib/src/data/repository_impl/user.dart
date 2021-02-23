import 'dart:io';

import 'package:dio/dio.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/state_district.dart';
import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/service/dio/dio_client.dart';
import 'package:t_society/src/data/repository/user.dart';
import 'package:t_society/util/utils.dart';


class UserRepositoryImpl extends UserRepository {
  DioClient _dioClient;

  UserRepositoryImpl(this._dioClient);

  @override
  Future<StateResponse> fetchStates() async {
    final response = await _dioClient.get("user/fetch-all-state");
    var stateResponse = StateResponse.fromJson(response);
    return stateResponse;
  }

  Future<DistrictResponse> fetDistrictFromStateId(int statusId) async {
    final response = await _dioClient.get(
        "user/fetch-all-districts-with-state-id",
        queryParameters: {"stateId": statusId});
    var districtResponse = DistrictResponse.fromJson(response);
    return districtResponse;
  }


  void dispose() {
    _dioClient.dio.clear();
  }

  @override
  Future<CommonResponse> userRegister(Map<String, dynamic> data) async{
    final result = await _dioClient.post("user/create",data:  data);
    CommonResponse commonResponse = CommonResponse.fromJson(result);
    return commonResponse;
  }

  @override
  Future<CommonResponse> userUpdate(Map<String, dynamic> data) async{
    final result = await _dioClient.post("user/update",data:  data);
    CommonResponse commonResponse = CommonResponse.fromJson(result);
    return commonResponse;
  }

  @override
  Future<UserListResponse> userList(int paginationPageKey,{query,String adminId}) async {

    var mQuery = {
      "adminId" : adminId ?? "",
      "page" : paginationPageKey,
      "limit" : "20",
    };

    if(query != null)
      mQuery.addAll(query);


    final result = await _dioClient.get("user/all",queryParameters: mQuery);
    UserListResponse userResponse = UserListResponse.fromJson(result);
    return userResponse;
  }



  @override
  Future<CommonResponse> uploadUserExcelData(String adminMobile,File file) async {
    FormData data = FormData.fromMap({
      "userExcel" : await MultipartFile.fromFile(file.path,filename: "userExcel"),
      "adminMobile" : adminMobile
    });
    final result = await _dioClient.post("user/import-user-data",data: data);
    return CommonResponse.fromJson(result);

  }
}
