import 'package:get/get.dart';
import 'package:t_society/src/data/repository/bill.dart';
import 'package:t_society/src/model/bill.dart';
import 'package:t_society/src/model/response/bill.dart';
import 'package:t_society/src/presentation/bill_payment/bill_type/controller.dart';
import 'package:t_society/src/presentation/bill_payment/pay/page.dart';
import 'package:t_society/src/presentation/error_screen.dart';
import 'package:t_society/src/service/locator/locator.dart';
import 'package:t_society/util/api_resource/api_result.dart';

class BillProviderController extends GetxController {
  final BillType billType;
  final BillRepository repository = sl.get();
  final String stateName;

  BillProviderController(this.billType, {this.stateName});

  var listElectricityStateObs =
      ApiResult<ElectricityStateListResponse>.init().obs;
  var listProviderObs = ApiResult<BillProviderResponse>.init().obs;
  List<BillProvider> providerList;

  @override
  void onInit() {
    fetchProvider();

    super.onInit();
  }

  void fetchProvider() async {
    try {
      String mStateName = "";
      if (stateName != null) mStateName = stateName;
      BillProviderResponse data = await repository.fetchBillProvider(
          getBillIconAndTitle(billType)["title"],
          stateName: mStateName);
      listProviderObs.value = ApiResult.fetched(data: data);
    } catch (e) {
      Get.to(ErrorScreen(e));
    }
  }

  void onProviderClick(BillProvider provider) async{
    Get.to(BillPayScreen(provider,billType));
  }
}
