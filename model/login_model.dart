class LoginResponseModel {
  LoginResponseModel({
    this.id,
    this.ad,
    this.telephone,
    this.resultType,
    this.message,
  });

  String id;
  String ad;
  String telephone;
  String resultType;
  String message;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json['Id'] == null ? null : json['Id'],
        ad: json['Ad'] == null ? null : json['Ad'],
        telephone: json['Telephone'] == null ? null : json['Telephone'],
        resultType: json['ResultType'] == null ? null : json['ResultType'],
        message: json['Message'] == null ? null : json['Message'],
      );

  Map<String, dynamic> toJson() {
    return {
      'Id': id == null ? null : id,
      'Ad': ad == null ? null : ad,
      'Telephone': telephone == null ? null : telephone,
      'ResultType': resultType == null ? null : resultType,
      'Message': message == null ? null : message,
    };
  }
}

class LoginRequestModel {
  String us;
  String ps;
  String email;
  String password;

  LoginRequestModel({
    this.us = '******',
    this.ps = '******',
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'us': us.trim(),
      'ps': ps.trim(),
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
