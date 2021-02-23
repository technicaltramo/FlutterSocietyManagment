import 'package:t_society/src/model/response/user.dart';
import 'package:t_society/src/service/dio/dio_client.dart';
import 'package:t_society/src/data/repository/login.dart';

class LoginRepositoryImpl extends LoginRepository{
  DioClient _dioClient;

  LoginRepositoryImpl(this._dioClient);


  @override
  Future<LoginResponse> login(String email, String password) async {
    final response = await _dioClient.post("user/login",data: {
      "email" : email,
      "password" : password
    });
    var loginResponse = LoginResponse.fromJson(response);
    return loginResponse;
  }


}
