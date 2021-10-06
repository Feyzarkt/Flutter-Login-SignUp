import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/api/api_service_login.dart';
import 'package:flutter_http_post_request/model/login_model.dart';
import 'package:flutter_http_post_request/pages/main_page.dart';
import 'package:flutter_http_post_request/pages/registration_form.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
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
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(
          "My First App",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        backgroundColor: Theme.of(context).accentColor,
        automaticallyImplyLeading: false,
      ),
      key: scaffoldKey,
      //backgroundColor: Theme.of(context).accentColor,
      body: //ClipPath(
          // clipper: BottomWaveClipper(),
          // child:
          Container(
        height: 700.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.green.shade300, Colors.teal.shade600])),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
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
                            "Login",
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 25),
                          new TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => loginRequestModel.email = input,
                            validator: (input) => !input.contains('@')
                                ? "Email Id should be valid"
                                : null,
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
                          SizedBox(height: 20),
                          new TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.text,
                            onSaved: (input) =>
                                loginRequestModel.password = input,
                            validator: (input) => input.length < 3
                                ? "Password should be more than 3 characters"
                                : null,
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
                          SizedBox(height: 30),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () {
                              if (validateAndSave()) {
                                //print(loginRequestModel.toJson());

                                setState(() {
                                  isApiCallProcess = true;
                                });

                                APIService apiService = new APIService();
                                apiService
                                    .login(loginRequestModel)
                                    .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      isApiCallProcess = false;
                                    });
                                    //debugPrint('resultType: ' + value.resultType);
                                    if (value.resultType == '1') {
                                      debugPrint('Successful!!!!!!!');
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Login Successful...'),
                                            actions: <Widget>[
                                              SpinKitRipple(
                                                color: Colors.teal.shade200,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      /*final snackBar =
                                            SnackBar(content: Text(value.message));
                                        scaffoldKey.currentState
                                            .showSnackBar(snackBar);*/
                                      Future.delayed(
                                          const Duration(seconds: 3),
                                          () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainPage())));
                                      /* */
                                    } else if (value.resultType == '5') {
                                      debugPrint('Error!!!!!!');
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Login Unsuccessful. Please Try Again'),
                                            actions: <Widget>[
                                              SpinKitChasingDots(
                                                color: Colors.teal.shade200,
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      Future.delayed(const Duration(seconds: 3),
                                              () => Navigator.pop(context))
                                          .then((_) => globalFormKey
                                              .currentState
                                              .reset());
                                      /*final snackBar =
                                            SnackBar(content: Text(value.message));
                                        scaffoldKey.currentState
                                            .showSnackBar(snackBar);*/
                                    } //else
                                    // debugPrint('Invalid resultType');
                                  }
                                });
                              }
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            color: Theme.of(context).accentColor,
                            shape: StadiumBorder(),
                          ),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationForm()));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            color: Theme.of(context).accentColor,
                            shape: StadiumBorder(),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // ),
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
}

