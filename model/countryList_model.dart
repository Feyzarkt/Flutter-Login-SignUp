class CountryResponseModel {
  CountryResponseModel({
    this.id,
    this.code,
    this.name,
  });

  String id;
  String code;
  String name;

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) =>
      CountryResponseModel(
        id: json['Id'] == null ? null : json['Id'],
        code: json['Code'] == null ? null : json['Code'],
        name: json['Name'] == null ? null : json['Name'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id == null ? null : id,
      'Code': code == null ? null : code,
      'Name': name == null ? null : name,
    };
  }
}

class CountryRequestModel {
  String us;
  String ps;

  CountryRequestModel({
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
