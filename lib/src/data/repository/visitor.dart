import 'dart:io';
import 'package:t_society/src/model/response/common.dart';

abstract class VisitorRepository {
  Future<CommonResponse> newVisitorEntry(
      File visitorPhoto,String userId, String name, String mobile, String vehicleNumber);
}
