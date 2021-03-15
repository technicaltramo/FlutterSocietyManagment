import 'package:t_society/src/model/response/bill.dart';

abstract class BillRepository{
  Future<ElectricityStateListResponse> fetchElectricityState();
  Future<BillProviderResponse> fetchBillProvider(String serviceType, {String stateName = ""});
}