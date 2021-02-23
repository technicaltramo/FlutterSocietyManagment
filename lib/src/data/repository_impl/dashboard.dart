import 'package:t_society/src/model/response/common.dart';
import 'package:t_society/src/service/dio/dio_client.dart';
import 'package:t_society/src/data/repository/dashboard.dart';

class DashboardRepositoryImpl extends DashboardRepository{
  DioClient _dioClient;


  DashboardRepositoryImpl(this._dioClient);

  void dispose() {
    _dioClient.dio.clear();
  }

  @override
  Future<CommonResponse> saveFcmToken(String token) async {

   final result = await _dioClient.post("user/save-fcm-token",data: {
      "token" : token
    });
   CommonResponse response = CommonResponse.fromJson(result);
   return response;

  }


}
