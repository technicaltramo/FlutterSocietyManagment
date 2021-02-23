
import 'package:t_society/src/data/repository/complain.dart';
import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/model/response/complain.dart';
import 'package:t_society/src/service/dio/dio_client.dart';

class ComplainRepositoryImpl extends ComplainRepository{

  DioClient _dioClient;
  ComplainRepositoryImpl(this._dioClient);


  @override
  Future<CommonResponse> raiseComplain(Map<String,String> data) async {

    final result = await _dioClient.post("complain/raise-complain",data:data);
    var response = CommonResponse.fromJson(result);
    return response;
  }

  @override
  Future<ComplainListResponse> complains(int pageKey,{query,status}) async{

    var mQuery = {
      "page" : pageKey,"limit" : 20, "complainStatus" : status
    };
    if(query != null)
      mQuery.addAll(query);

    final result = await _dioClient.get("complain/all",queryParameters: mQuery);
    final response = ComplainListResponse.fromJson(result);
    return response;

  }

  @override
  Future<CommonResponse> updateComplain(String complainId, int complainStatusId) async {
    final result = await _dioClient.post("complain/update-status",data: {
      "status" : complainStatusId.toString(),
      "complainId" : complainId
    });
    final response = CommonResponse.fromJson(result);
    return response;
  }


}
