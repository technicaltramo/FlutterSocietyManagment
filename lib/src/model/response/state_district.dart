import '../state_district.dart';



//District Response
class DistrictResponse {
  int status;
  String message;
  List<District> districts;

  DistrictResponse({this.status, this.message, this.districts});

  DistrictResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['districts'] != null) {
      districts = new List<District>();
      json['districts'].forEach((v) {
        districts.add(new District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.districts != null) {
      data['districts'] = this.districts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//State Response
class StateResponse {
  int status;
  String message;
  List<CountryState> states;

  StateResponse({this.status, this.message, this.states});

  StateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['states'] != null) {
      states = new List<CountryState>();
      json['states'].forEach((v) {
        states.add(new CountryState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.states != null) {
      data['states'] = this.states.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
