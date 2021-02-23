
//State Model
class CountryState {
  int id;
  String name;

  CountryState({this.id, this.name});

  CountryState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  static getStateByName(List<CountryState> stateList,String stateName){
    for (CountryState states in stateList) {
      if(states.name == stateName){
        return states;
      }
    }
    return null;
  }
}

//District Model
class District {
  int id;
  String name;
  int stateId;

  District({this.id, this.name, this.stateId});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    return data;
  }

  static getDistrictByName(List<District> districtList,String districtName){
    for (District district in districtList) {
      if(district.name == districtName){
        return district;
      }
    }
    return null;
  }
}