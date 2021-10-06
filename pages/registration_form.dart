import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/api/api_service_register.dart';
import 'package:flutter_http_post_request/model/cityList_model.dart';
import 'package:flutter_http_post_request/model/countryList_model.dart';
import 'package:flutter_http_post_request/model/districtList_model.dart';
import 'package:flutter_http_post_request/model/genderList_model.dart';
import 'package:flutter_http_post_request/model/ilceList_model.dart';
import 'package:flutter_http_post_request/pages/login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../ProgressHUD.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationForm> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  CountryRequestModel countryRequestModel;
  CityRequestModel cityRequestModel;
  StateRequestModel stateRequestModel;
  DistrictRequestModel districtRequestModel;
  GenderRequestModel genderRequestModel;

  var name, surname, email, phone, password;
  var _chosenCountry, _chosenCity, _chosenIlce, _chosenMahalle, _chosenGender;
  var _chosenCountryCode,
      _chosenCityCode,
      _chosenStateCode = "111111111",
      _chosenMahalleCode = "111111111",
      _chosenGenderCode;

  List<String> countries = new List();
  List<CountryResponseModel> countries_model = new List();

  List<String> cities = new List();
  List<CityResponseModel> cities_model = new List();

  List<String> ilceler = new List();
  List<StateResponseModel> states_model = new List();

  List<String> mahalleler = new List();

  List<String> genderList = new List();
  List<GenderResponseModel> genders_model = new List();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  APIService_register apiService = new APIService_register();

  Future getCountries() async {
    apiService.countryList(countryRequestModel).then((value) {
      for (int i = 0; i < value.length; i++) {
        countries.add(value[i].name);
        print(countries[i]);
      }
      setState(() {
        countries_model = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    countryRequestModel = new CountryRequestModel();
    cityRequestModel = new CityRequestModel();
    stateRequestModel = new StateRequestModel();
    districtRequestModel = new DistrictRequestModel();
    genderRequestModel = new GenderRequestModel();

    getCountries();

    apiService.cityList(cityRequestModel).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          cities_model.add(value[i]);
        }
      }
    });

    apiService.ilceList(stateRequestModel).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          states_model.add(value[i]);
        }
      }
    });

    apiService.genderList(genderRequestModel).then((value) {
      if (value != null) {
        for (int i = 0; i < value.length; i++) {
          genderList.add(value[i].name);
          genders_model.add(value[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    String recipient;
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Back",
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          "Registration Form",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 10),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          //onSaved: (input) => loginRequestModel.email = input,
                          validator: (input) {
                            if (input.length < 3)
                              return "Name should be entered";
                            else {
                              name = input;
                              return null;
                            }
                          },
                          decoration: new InputDecoration(
                            hintText: "Name",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          //onSaved: (input) => loginRequestModel.email = input,
                          validator: (input) {
                            if (input.length < 3)
                              return "Surname should be entered";
                            else {
                              surname = input;
                              return null;
                            }
                          },
                          decoration: new InputDecoration(
                            hintText: "Surname",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.person_rounded,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        new TextFormField(
                          keyboardType: TextInputType.phone,
                          //onSaved: (input) => recipient = input,
                          validator: (input) {
                            if (input.length != 11)
                              return "Phone Number length should be 11";
                            else {
                              phone = input;
                              return null;
                            }
                          },
                          decoration: new InputDecoration(
                            hintText: "Phone Number",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => recipient = input,
                          validator: (input) {
                            if (!input.contains('@'))
                              return "Email Id should be valid";
                            else {
                              email = input;
                              return null;
                            }
                          },
                          decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        new TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          validator: (input) {
                            if (input.length < 3)
                              return "Password should be more than 3 characters";
                            else {
                              password = input;
                              return null;
                            }
                          },
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.teal)),
                              padding: EdgeInsets.only(
                                  left: 64.0, right: 24.0, bottom: 5),
                              margin: EdgeInsets.only(top: 15.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _chosenCountry,
                                validator: (value) => value == null
                                    ? 'Please fill in country'
                                    : null,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                items: countries.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Choose Country",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenCountry = value;
                                    if (cities != null) {
                                      cities.clear();
                                      _chosenCity = null;
                                      ilceler.clear();
                                      _chosenIlce = null;
                                    }
                                    cityList();
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 28.0, left: 10.0),
                              child: Icon(
                                Icons.assistant_photo_rounded,
                                color: Theme.of(context).accentColor,
                                size: 25.0,
                              ),
                            )
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.teal)),
                              padding: EdgeInsets.only(
                                  left: 64.0, right: 24.0, bottom: 5),
                              margin: EdgeInsets.only(top: 15.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _chosenCity,
                                validator: (value) =>
                                    (value == null && cities.length != 0)
                                        ? 'Please fill in city'
                                        : null,
                                //elevation: 5,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                items: cities.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Choose City",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenCity = value;
                                    if (ilceler != null) {
                                      ilceler.clear();
                                      _chosenIlce = null;
                                    }
                                    stateList();
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 28.0, left: 10.0),
                              child: Icon(
                                Icons.assistant_photo_rounded,
                                color: Theme.of(context).accentColor,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.teal)),
                              padding: EdgeInsets.only(
                                  left: 64.0, right: 24.0, bottom: 5),
                              margin: EdgeInsets.only(top: 15.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _chosenIlce,
                                validator: (value) =>
                                    (value == null && ilceler.length != 0)
                                        ? 'Please fill in state'
                                        : null,
                                //elevation: 5,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),

                                items: ilceler.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Choose State",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenIlce = value;
                                    mahalleler = new List();
                                    for (int i = 0;
                                        i < states_model.length;
                                        i++) {
                                      if (_chosenIlce == states_model[i].name)
                                        _chosenStateCode = states_model[i].id;
                                    }
                                    print(_chosenStateCode + "*************");
                                    /*    APIService_register apiService =
                                        new APIService_register();
                                    apiService
                                        .districtList(districtRequestModel)
                                        .then((value) {
                                      if (value != null) {
                                        for (int i = 0; i < value.length; i++) {
                                          if (value[i].stateCode ==
                                              _chosenStateCode) {
                                            mahalleler.add(value[i].name);
                                          }
                                        }
                                      }
                                    });*/
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 28.0, left: 10.0),
                              child: Icon(
                                Icons.assistant_photo_rounded,
                                color: Theme.of(context).accentColor,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.teal)),
                              padding: EdgeInsets.only(
                                  left: 64.0, right: 24.0, bottom: 5),
                              margin: EdgeInsets.only(top: 15.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _chosenMahalle,
                                validator: (value) =>
                                    (value == null && mahalleler.length != 0)
                                        ? 'Please fill in district'
                                        : null,
                                //elevation: 5,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),

                                items: mahalleler.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Choose District",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenMahalle = value;
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 28.0, left: 10.0),
                              child: Icon(
                                Icons.assistant_photo_rounded,
                                color: Theme.of(context).accentColor,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.teal)),
                              padding: EdgeInsets.only(
                                  left: 64.0, right: 24.0, bottom: 5),
                              margin: EdgeInsets.only(top: 15.0),
                              child: DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _chosenGender,
                                validator: (value) => value == null
                                    ? 'Please fill in your gender'
                                    : null,
                                //elevation: 5,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),

                                items: genderList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Choose Gender",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: (String value) {
                                  setState(() {
                                    _chosenGender = value;

                                    for (int i = 0;
                                        i < genders_model.length;
                                        i++) {
                                      if (_chosenGender ==
                                          genders_model[i].name)
                                        _chosenGenderCode = genders_model[i].id;
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 28.0, left: 10.0),
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).accentColor,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () {
                            if (validateAndSave()) {
                              //main(recipient);
                              APIService_register apiReg =
                                  new APIService_register();
                              apiReg
                                  .createMemAccount(
                                      name,
                                      surname,
                                      phone,
                                      email,
                                      password,
                                      _chosenGenderCode,
                                      _chosenCountryCode,
                                      _chosenCityCode,
                                      _chosenStateCode,
                                      _chosenMahalleCode)
                                  .then((value) {
                                if (value == "1") {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Register Successful...'),
                                        actions: <Widget>[
                                          SpinKitRipple(
                                            color: Colors.teal.shade200,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  Future.delayed(
                                      const Duration(seconds: 4),
                                      () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage())));
                                } else {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Register Unsuccessful. Please Try Again'),
                                        actions: <Widget>[
                                          SpinKitChasingDots(
                                            color: Colors.teal.shade200,
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  Future.delayed(const Duration(seconds: 4),
                                          () => Navigator.pop(context))
                                      .then((_) => {
                                            globalFormKey.currentState.reset(),
                                            setState(() {
                                              _chosenCountry = null;
                                              _chosenCity = null;
                                              _chosenIlce = null;
                                              _chosenGender = null;
                                            }),
                                          });
                                }
                              });
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 15),
                        Text("*Your password will be sent via e-mail and SMS."),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  countryList() {
    for (int i = 0; i < countries_model.length; i++) {
      countries.add(countries_model[i].name);
      print(countries[i]);
    }
  }

  cityList() {
    for (int i = 0; i < countries_model.length; i++) {
      if (_chosenCountry == countries_model[i].name)
        _chosenCountryCode = countries_model[i].code;
    }
    print(_chosenCountryCode + "*************");

    for (int i = 0; i < cities_model.length; i++) {
      if (cities_model[i].countyCode == _chosenCountryCode) {
        cities.add(cities_model[i].name);
      }
    }
  }

  stateList() {
    if (cities_model != null) {
      for (int i = 0; i < cities_model.length; i++) {
        if (_chosenCity == cities_model[i].name)
          _chosenCityCode = cities_model[i].code;
      }
    }

    print(_chosenCityCode + "*************");

    for (int i = 0; i < states_model.length; i++) {
      if (states_model[i].cityCode == _chosenCityCode) {
        ilceler.add(states_model[i].name);
      }
    }
  }

}
