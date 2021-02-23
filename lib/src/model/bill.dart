// ELECTRICITY STATE NAME MODEL
class StateName {
  String stateName;

  StateName({this.stateName});

  StateName.fromJson(Map<String, dynamic> json) {
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateName'] = this.stateName;
    return data;
  }
}

//BILL PROVIDER MODEL
class BillProvider {
  String sId;
  String providerKey;
  String serviceType;
  String providerName;

  BillProvider({this.sId, this.providerKey, this.serviceType, this.providerName});

  BillProvider.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    providerKey = json['providerKey'];
    serviceType = json['serviceType'];
    providerName = json['providerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['providerKey'] = this.providerKey;
    data['serviceType'] = this.serviceType;
    data['providerName'] = this.providerName;
    return data;
  }
}
