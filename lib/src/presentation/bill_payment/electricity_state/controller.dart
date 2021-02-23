import 'package:get/get.dart';
import 'package:t_society/src/data/repository/bill.dart';
import 'package:t_society/src/model/bill.dart';
import 'package:t_society/src/model/response/bill.dart';
import 'package:t_society/src/presentation/bill_payment/bill_type/controller.dart';
import 'package:t_society/src/presentation/bill_payment/provider/screen.dart';
import 'package:t_society/src/presentation/error_screen.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class BillElectricityStateController extends GetxController {
  var listElectricityStateObs =
      ApiResult<ElectricityStateListResponse>.init().obs;
  final BillRepository repository = sl.get();

  List<StateName> listState ;

  @override
  void onInit() {
    fetchElectricityState();
    super.onInit();
  }

  void fetchElectricityState() async {
    try {
      ElectricityStateListResponse data =
          await repository.fetchElectricityState();
      listElectricityStateObs.value = ApiResult.fetched(data: data);
    } catch (e) {
      Get.to(ErrorScreen(e));
    }
  }

  void onListItemClick(String stateName){
    Get.to(BillProviderScreen(BillType.ELECTRICITY,stateName: stateName,));
  }
}
