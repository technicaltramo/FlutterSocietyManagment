import 'package:get/get.dart';
import 'package:t_society/src/data/local/app_preference.dart';
import 'package:t_society/src/model/visitor.dart';
import 'package:t_society/src/presentation/visitor/upcoming/screen.dart';
import 'package:t_society/src/service/locator/locator.dart';

class VisitorMessagingService {
  var appPreference = sl.get<AppPreference>();

  VisitorMessagingService(data) {
    onInit(data);
  }

  void onInit(data) {
    var visitor = Visitor(
      visitorId: data["visitorId"],
      subtype: data["subtype"],
      userId: data["userId"],
      guardId: data["guardId"],
      visitorName: data["visitorName"],
      visitorMobile: data["visitorMobile"],
      vehicleNumber: data["vehicleNumber"],
      picUrl: data["picUrl"],
      timeInMilliSecond: data["timeInMilliSecond"],
      status: data["status"],
    );
    appPreference.visitor = visitor;
    Get.to(UpcomingVisitorScreen(visitor));
  }
}
