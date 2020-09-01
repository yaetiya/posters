import 'package:art/screens/UserScreen/RegistrationHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../configs/Palette.dart';

class LoginHome extends StatefulWidget {
  final Function() notifyParent;
  LoginHome({Key key, @required this.notifyParent}) : super(key: key);
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Login'),
      ),
      child: Center(
          child: Column(
        children: [
          Spacer(
            flex: 10,
          ),
          Card(
            color: CupertinoColors.darkBackgroundGray,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  (errorMessage != ''
                      ? Text(
                          errorMessage,
                          style: TextStyle(color: mainThemeColor),
                        )
                      : Container()),
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
                              errorStyle:
                                  TextStyle(color: CupertinoColors.white),
                              focusedBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: mainThemeColor,
                                    width: 2,
                                    style: BorderStyle.solid),
                              ),
                              labelText: "Email",
                              icon: Icon(
                                CupertinoIcons.mail,
                                color: mainThemeColor,
                              ),
                              fillColor: CupertinoColors.darkBackgroundGray,
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
                              errorStyle:
                                  TextStyle(color: CupertinoColors.white),
                              focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: mainThemeColor,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              labelText: "Password",
                              icon: Icon(
                                CupertinoIcons.padlock,
                                color: mainThemeColor,
                              ),
                              fillColor: CupertinoColors.darkBackgroundGray,
                              labelStyle: TextStyle(
                                color: mainThemeColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Get Register',
                            style: TextStyle(
                              fontSize: 18,
                              color: mainThemeColor,
                            ),
                          ),
                          onPressed: () {
                            return Navigator.of(context)
                                .push(CupertinoPageRoute(
                              builder: (context) {
                                return RegistrationHome();
                              },
                            ));
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: mainThemeColor,
                            ),
                          ),
                          onPressed: () {
                            if (_formStateKey.currentState.validate()) {
                              _formStateKey.currentState.save();
                              signIn(_emailId, _password).then((user) {
                                if (user != null) {
                                  print('Logged in successfully.');
                                  setState(() {
                                    successMessage =
                                        'Logged in successfully.\nYou can now navigate to Home Page.';
                                  });
                                  widget.notifyParent();
                                } else {
                                  print('Error while Login.');
                                }
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      )),
    );
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      FirebaseUser user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password';
        });
        break;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty) {
      return 'Password is empty';
    }
    return null;
  }
}
