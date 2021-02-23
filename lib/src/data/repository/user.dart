import 'dart:io';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/state_district.dart';
import 'package:t_society/src/model/response/user.dart';

abstract class UserRepository{
  Future<StateResponse> fetchStates();
  Future<DistrictResponse> fetDistrictFromStateId(int statusId);
  Future<CommonResponse> userRegister(Map<String,dynamic> data);
  Future<CommonResponse> userUpdate(Map<String,dynamic> data);
  Future<UserListResponse> userList(int paginationPageKey,{query,String adminId});
  Future<CommonResponse> uploadUserExcelData(String adminMobile,File file);
}