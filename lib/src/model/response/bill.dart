import '../bill.dart';


//ELECTRICITY STATE LIST RESPONSE
class ElectricityStateListResponse {
  List<StateName> stateNames;
  int status;
  String message;

  ElectricityStateListResponse({this.stateNames, this.status, this.message});

  ElectricityStateListResponse.fromJson(Map<String, dynamic> json) {
    if (json['stateNames'] != null) {
      stateNames = new List<StateName>();
      json['stateNames'].forEach((v) {
        stateNames.add(new StateName.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stateNames != null) {
      data['stateNames'] = this.stateNames.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

//BILL PROVIDER LIST RESPONSE

class BillProviderResponse {
  List<BillProvider> providers;
  int status;
  String message;

  BillProviderResponse({this.providers, this.status, this.message});

  BillProviderResponse.fromJson(Map<String, dynamic> json) {
    if (json['providers'] != null) {
      providers = new List<BillProvider>();
      json['providers'].forEach((v) {
        providers.add(new BillProvider.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.providers != null) {
      data['providers'] = this.providers.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}


