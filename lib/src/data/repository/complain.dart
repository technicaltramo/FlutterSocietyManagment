
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/complain.dart';

abstract class ComplainRepository{
  Future<CommonResponse> raiseComplain(Map<String,String> data);
  Future<ComplainListResponse> complains(int pageKey,{query,status});
  Future<CommonResponse> updateComplain(String complainId ,int complainStatusId);
}