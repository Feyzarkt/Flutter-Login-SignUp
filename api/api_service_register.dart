import 'dart:convert';

import 'package:flutter_http_post_request/model/cityList_model.dart';
import 'package:flutter_http_post_request/model/districtList_model.dart';
import 'package:flutter_http_post_request/model/genderList_model.dart';
import 'package:flutter_http_post_request/model/ilceList_model.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../model/countryList_model.dart';

class APIService_register {
  Future<List<CountryResponseModel>> countryList(
      CountryRequestModel requestModel) async {
    String url_CountryList =
        "**your url**";
    Xml2Json xml2json = new Xml2Json();

    final response = await http.post(Uri.parse(url_CountryList),
        body: requestModel.toJson());

    List<dynamic> values = new List();

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var jsonResponse = jsonDecode(jsondata);

      values = jsonResponse['ArrayOfAP_Country']['AP_Country'];

      List<CountryResponseModel> countries = new List();

      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          countries.add(CountryResponseModel.fromJson(values[i]));
        }
      }
      return countries;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<CityResponseModel>> cityList(
      CityRequestModel requestModel) async {
    String url_CityList =
        "**your url**";
    Xml2Json xml2json = new Xml2Json();

    final response =
        await http.post(Uri.parse(url_CityList), body: requestModel.toJson());

    List<dynamic> values = new List();

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var jsonResponse = jsonDecode(jsondata);
	  
      values = jsonResponse['ArrayOfAP_City']['AP_City'];

      List<CityResponseModel> cities = new List();

      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          cities.add(CityResponseModel.fromJson(values[i]));
        }
      }
      return cities;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<StateResponseModel>> ilceList(
      StateRequestModel requestModel) async {
    String url_IlceList =
        "**your url**";
    Xml2Json xml2json = new Xml2Json();

    final response =
        await http.post(Uri.parse(url_IlceList), body: requestModel.toJson());

    List<dynamic> values = new List();

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var jsonResponse = jsonDecode(jsondata);

      values = jsonResponse['ArrayOfAP_State']['AP_State'];

      List<StateResponseModel> ilceler = new List();

      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          ilceler.add(StateResponseModel.fromJson(values[i]));
        }
      }
      return ilceler;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<DistrictResponseModel>> districtList(
      DistrictRequestModel requestModel) async {
    String url_DistrictList =
        "**your url**";
    Xml2Json xml2json = new Xml2Json();

    final response = await http.post(Uri.parse(url_DistrictList),
        body: requestModel.toJson());

    List<dynamic> values = new List();

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var jsonResponse = jsonDecode(jsondata);

      values = jsonResponse['ArrayOfAP_State']['AP_State'];

      List<DistrictResponseModel> districts = new List();

      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          districts.add(DistrictResponseModel.fromJson(values[i]));
        }
      }
      return districts;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<List<GenderResponseModel>> genderList(
      GenderRequestModel requestModel) async {
    String url_GenderList =
        "**your url**";
    Xml2Json xml2json = new Xml2Json();

    final response =
        await http.post(Uri.parse(url_GenderList), body: requestModel.toJson());

    List<dynamic> values = new List();

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var jsonResponse = jsonDecode(jsondata);

      values = jsonResponse['ArrayOfAP_Gender']['AP_Gender'];

      List<GenderResponseModel> genders = new List();

      for (int i = 0; i < values.length; i++) {
        if (values[i] != null) {
          genders.add(GenderResponseModel.fromJson(values[i]));
        }
      }
      return genders;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  //POST register
  Future<String> createMemAccount(
      var name,
      var surname,
      var telephone,
      var email,
      var password,
      var genderid,
      var countrycode,
      var citycode,
      var statecode,
      var districtid) async {
    var url =
        "**your url**";
   

    Map mapped = {
      'langid': "1",
      'us': "*****",
      'ps': "******",
      'name': name,
      'surname': surname,
      'telephone': telephone,
      'email': email,
      'password': password,
      'genderid': genderid,
      'countrycode': countrycode,
      'citycode': citycode,
      'statecode': statecode,
      'districtid': districtid,
      'MacAdress': "****",
    };

    Xml2Json xml2json = new Xml2Json();
    Map map = new Map();

    final response = await http.post(Uri.parse(url), body: mapped);

    if (response.statusCode == 200) {
      xml2json.parse(response.body);
      var jsondata = xml2json.toParker();
      var jsonResponse = jsonDecode(jsondata);

      map = jsonResponse['ArrayOfLoginResult']['LoginResult'];

      return map['ResultType'];
    } else {
      return "Failed to load data!";
    }
  }
}
