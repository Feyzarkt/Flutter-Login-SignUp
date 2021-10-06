class CityResponseModel {
  CityResponseModel({
    this.id,
    this.countyCode,
    this.code,
    this.name,
    this.orderNumber,
  });

  String id;
  String countyCode;
  String code;
  String name;
  String orderNumber;

  factory CityResponseModel.fromJson(Map<String, dynamic> json) =>
      CityResponseModel(
        id: json['Id'] == null ? null : json['Id'],
        countyCode: json['CountyCode'] == null ? null : json['CountyCode'],
        code: json['Code'] == null ? null : json['Code'],
        name: json['Name'] == null ? null : json['Name'],
        orderNumber: json['OrderNumber'] == null ? null : json['OrderNumber'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id == null ? null : id,
      'CountyCode': countyCode == null ? null : countyCode,
      'Code': code == null ? null : code,
      'Name': name == null ? null : name,
      'OrderNumber': orderNumber == null ? null : orderNumber,
    };
  }
}

class CityRequestModel {
  String us;
  String ps;

  CityRequestModel({
    this.us = '******',
    this.ps = '*******',
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'us': us.trim(),
      'ps': ps.trim(),
    };

    return map;
  }
}
