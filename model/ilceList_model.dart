class StateResponseModel {
  StateResponseModel({
    this.id,
    this.cityCode,
    this.name,
  });

  String id;
  String cityCode;
  String name;

  factory StateResponseModel.fromJson(Map<String, dynamic> json) =>
      StateResponseModel(
        id: json['Id'] == null ? null : json['Id'],
        cityCode: json['CityCode'] == null ? null : json['CityCode'],
        name: json['Name'] == null ? null : json['Name'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id == null ? null : id,
      'CountyCode': cityCode == null ? null : cityCode,
      'Name': name == null ? null : name,
    };
  }
}

class StateRequestModel {
  String us;
  String ps;

  StateRequestModel({
    this.us = '******',
    this.ps = '******',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'us': us.trim(),
      'ps': ps.trim(),
    };

    return map;
  }
}
