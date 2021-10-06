class DistrictResponseModel {
  DistrictResponseModel({
    this.id,
    this.stateCode,
    this.name,
    this.zipCode,
  });

  String id;
  String stateCode;
  String name;
  String zipCode;

  factory DistrictResponseModel.fromJson(Map<String, dynamic> json) =>
      DistrictResponseModel(
        id: json['Id'] == null ? null : json['Id'],
        stateCode: json['StateCode'] == null ? null : json['StateCode'],
        name: json['Name'] == null ? null : json['Name'],
        zipCode: json['ZipCode'] == null ? null : json['ZipCode'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id == null ? null : id,
      'StateCode': stateCode == null ? null : stateCode,
      'Name': name == null ? null : name,
      'ZipCode': zipCode == null ? null : zipCode,
    };
  }
}

class DistrictRequestModel {
  String us;
  String ps;

  DistrictRequestModel({
    this.us = '*****',
    this.ps = '*****',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'us': us.trim(),
      'ps': ps.trim(),
    };

    return map;
  }
}
