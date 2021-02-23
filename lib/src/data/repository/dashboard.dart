import 'package:t_society/src/model/response/common.dart';

abstract class DashboardRepository{
  Future<CommonResponse> saveFcmToken(String token);
}