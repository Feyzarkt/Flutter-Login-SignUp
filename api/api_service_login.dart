import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../model/login_model.dart';

class APIService {
  static var name = '';
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url =
        "**your url**";

    Xml2Json xml2json = new Xml2Json();

    final response =
        await http.post(Uri.parse(url), body: requestModel.toJson());

    debugPrint('statuscode= ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var jsonResponse = jsonDecode(jsondata);

      debugPrint(jsonResponse.toString());

      var jsonResponseData = jsonResponse['ArrayOfLoginResult']['LoginResult'];

      print(jsonResponseData.toString());
	  
      return LoginResponseModel.fromJson(jsonResponseData);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
