import 'package:art/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/Palette.dart';

class RegistrationHome extends StatefulWidget {
  @override
  _RegistrationHomeState createState() => _RegistrationHomeState();
}

class _RegistrationHomeState extends State<RegistrationHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Registration'),
      ),
      child: Center(
        child: Column(
          children: [
            Card(
              color: CupertinoColors.darkBackgroundGray,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Form(
                      key: _formStateKey,
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              style: TextStyle(color: CupertinoColors.white),
                              validator: validateEmail,
                              onSaved: (value) {
                                _emailId = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailIdController,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: mainThemeColor,
                                      width: 2,
                                      style: BorderStyle.solid),
                                ),
                                labelText: "Email Id",
                                icon: Icon(
                                  Icons.email,
                                  color: mainThemeColor,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: mainThemeColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              style: TextStyle(color: CupertinoColors.white),
                              validator: validatePassword,
                              onSaved: (value) {
                                _password = value;
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: mainThemeColor,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelText: "Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: mainThemeColor,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: mainThemeColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, bottom: 5),
                            child: TextFormField(
                              style: TextStyle(color: CupertinoColors.white),
                              validator: validateConfirmPassword,
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: new UnderlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: mainThemeColor,
                                        width: 2,
                                        style: BorderStyle.solid)),
                                labelText: "Confirm Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: mainThemeColor,
                                ),
                                fillColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: mainThemeColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (errorMessage != ''
                        ? Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red),
                          )
                        : Container()),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Registration',
                              style: TextStyle(
                                fontSize: 18,
                                color: mainThemeColor,
                              ),
                            ),
                            onPressed: () {
                              if (_formStateKey.currentState.validate()) {
                                _formStateKey.currentState.save();
                                signUp(_emailId, _password).then((user) {
                                  if (user != null) {
                                    setState(() {
                                      successMessage =
                                          'Registered Successfully.';
                                    });
                                  } else {
                                    print('Error while Login.');
                                  }
                                });
                              }
                            },
                          ),
                          FlatButton(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 12,
                                color: mainThemeColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (successMessage != ''
                ? Text(
                    successMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: mainThemeColor),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> signUp(email, password) async {
    try {
      FirebaseUser user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id!!!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'Password Mismatch!!!';
    }
    return null;
  }
}
