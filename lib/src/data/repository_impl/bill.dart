import 'package:t_society/src/data/repository/bill.dart';
import 'package:t_society/src/model/response/bill.dart';
import 'package:t_society/src/service/dio/dio_client.dart';

class BillRepositoryImpl extends BillRepository{
  DioClient _dioClient;

  BillRepositoryImpl(this._dioClient);


  @override
  Future<ElectricityStateListResponse> fetchElectricityState() async{
    final result = await _dioClient.get("bill-payment/fetch-electricity-state");
    var response = ElectricityStateListResponse.fromJson(result);
    return response;
  }


  @override
  Future<BillProviderResponse> fetchBillProvider(String serviceType,{String stateName=""}) async{
    final result = await _dioClient.get("bill-payment/fetch-provider",queryParameters: {
      "serviceType" : serviceType,
      "stateName" : stateName
    });
    var response = BillProviderResponse.fromJson(result);
    return response;
  }


}
