class GenderResponseModel {
  GenderResponseModel({
    this.id,
    this.langId,
    this.name,
  });

  String id;
  String langId;
  String name;

  factory GenderResponseModel.fromJson(Map<String, dynamic> json) =>
      GenderResponseModel(
        id: json['Id'] == null ? null : json['Id'],
        langId: json['LangId'] == null ? null : json['LangId'],
        name: json['Name'] == null ? null : json['Name'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id == null ? null : id,
      'LangId': langId == null ? null : langId,
      'Name': name == null ? null : name,
    };
  }
}

class GenderRequestModel {
  String us;
  String ps;

  GenderRequestModel({
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
