import 'package:flutter/material.dart';
import '../Logic/Aws_Auth.dart';
import '../Components/Animation.dart';
import '../Logic/AppLocalization.dart';
import '../Components/RoundRectangleButton.dart';
import '../Components/InputTextForm.dart';
import '../Screens/ComfirmationPage.dart';

class SignUp_Page extends StatefulWidget {
  @override
  _SignUp_PageState createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  String _email;
  String _password;
  String _firstName;
  String _lastName;

  final keyForm = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SafeArea(
          child: Form(
            key: keyForm,
            child: Builder(builder: (context) {
              return ListView(
                children: <Widget>[
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 60, right: 40),
                        alignment: Alignment.center,
                        child: AnimationClass(
                            1.3,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Salon",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 30,
                                      letterSpacing: 1),
                                ),
                                Text(
                                  "Everywhere",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 30,
                                      letterSpacing: 1),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AnimationClass(
                        1.3,
                        Container(
                          padding: EdgeInsets.only(left: 17, right: 30),
                          //alignment: Alignment.centerLeft,
                          child: Center(
                            child: AnimationClass(
                                1.3,
                                Text(
                                  AppLocalization.of(context)
                                      .translate("create_account"),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      AnimationClass(
                          1.3,
                          InputTextform(
                            label: AppLocalization.of(context)
                                .translate("username"),
                            keybord: TextInputType.emailAddress,
                            validator: (String ursername) {
                              if (ursername.isEmpty) {
                                return "please enter a valid username";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (String saveUsername) {
                              _firstName = saveUsername;
                            },
                          )),
                      AnimationClass(
                        1.3,
                        InputTextform(
                          label:
                              AppLocalization.of(context).translate("lastName"),
                          keybord: TextInputType.emailAddress,
                          validator: (String ursername) {
                            if (ursername.isEmpty) {
                              return "please enter a valid username";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String saveUsername) {
                            _lastName = saveUsername;
                          },
                        ),
                      ),
                      AnimationClass(
                        1.3,
                        InputTextform(
                            label: ("email"),
                            keybord: TextInputType.emailAddress,
                            validator: (String validEmail) {
                              Pattern validEmailForm =
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              RegExp regexp = RegExp(validEmailForm);
                              if (validEmail.isEmpty) {
                                return "Please enter a valid email address";
                              } else {
                                if (!regexp.hasMatch(validEmail)) {
                                  return "Please enter a valid email address";
                                } else {
                                  return null;
                                }
                              }
                            },
                            onSaved: (String validEmail) {
                              _email = validEmail;
                            }),
                      ),
                      AnimationClass(
                          1.3,
                          InputTextform(
                            label: AppLocalization.of(context)
                                .translate("password"),
                            obscureText: obscureText,
                            keybord: TextInputType.emailAddress,
                            surfixeIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                if (obscureText == true) {
                                  setState(() {
                                    obscureText = false;
                                  });
                                } else {
                                  setState(() {
                                    obscureText = true;
                                  });
                                }
                              },
                            ),
                            validator: (String validPassword) {
                              Pattern validPasswordForm =
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!-@#\$&*~_()])';
                              RegExp regexp = RegExp(validPasswordForm);

                              if (validPassword.length < 8) {
                                return "your password must be greater than 8 characters";
                              } else {
                                if (!regexp.hasMatch(validPassword)) {
                                  return "minumun of one capical letter, lower letter, special caractere, is  required ";
                                } else {
                                  return null;
                                }
                              }
                            },
                            onSaved: (String savePassword) {
                              _password = savePassword;
                            },
                          )),
                      SizedBox(height: 20),
                      AnimationClass(
                        1.3,
                        Builder(builder: (context) {
                          return RoundRectangleButton(
                              color: Colors.red,
                              elevation: 4.0,
                              height: 70.0,
                              text: AppLocalization.of(context)
                                  .translate("signUP"),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              minWidth:
                                  MediaQuery.of(context).size.width / 1.13,
                              onPresss: () async {
                                try {
                                  if (keyForm.currentState.validate()) {
                                    keyForm.currentState.save();

                                    print(_firstName);
                                    print(_lastName);
                                    print(_email);

                                    await AwsAuth.instance.registerAccount(
                                        _email,
                                        _password,
                                        _firstName,
                                        _lastName);

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => ComfirmationPage(
                                                  email: _email,
                                                  firstName: _firstName,
                                                  lastName: _lastName,
                                                )));
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              });
                        }),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
