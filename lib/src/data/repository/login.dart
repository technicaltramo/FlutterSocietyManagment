
import 'package:t_society/src/model/response/user.dart';

abstract class LoginRepository{
  Future<LoginResponse> login(String email, String password);
}