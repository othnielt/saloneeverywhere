import 'package:flutter/material.dart';
import '../Logic/Aws_Auth.dart';
import '../Logic/AppLocalization.dart';
import '../Components/Animation.dart';
import '../Components/InputTextForm.dart';
import '../Components/FlatButton.dart';
import '../Components/RoundRectangleButton.dart';
import '../Screens/Profile.dart';

class ComfirmationPage extends StatefulWidget {
  @override
  final String email;
  final String firstName;
  final String lastName;

  ComfirmationPage({@required this.email, this.firstName, this.lastName});

  @override
  _ComfirmationPageState createState() => _ComfirmationPageState();
}

class _ComfirmationPageState extends State<ComfirmationPage> {
  final keyForm = GlobalKey<FormState>();
  String _code;

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Form(
            key: keyForm,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimationClass(
                        1.3,
                        Container(
                          padding: EdgeInsets.only(top: 120, right: 40),
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          // alignment: Alignment.center,
                          child: AnimationClass(
                              1.3,
                              Text(
                                AppLocalization.of(context)
                                    .translate("verification_Code"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 17,
                                    letterSpacing: 1),
                              )),
                        ),
                      ),
                      AnimationClass(
                        1.3,
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    child: Text(
                                  AppLocalization.of(context)
                                      .translate("digit_Code"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16, //
                                    color: Colors.grey,
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AnimationClass(
                        1.3,
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 2),
                                      child: Text(
                                        AppLocalization.of(context)
                                            .translate("code_Label"),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      )),
                                ),
                              ]),
                        ),
                      ),
                      AnimationClass(
                        1.3,
                        InputTextform(
                          keybord: TextInputType.emailAddress,
                          validator: (String ursername) {
                            if (ursername.isEmpty) {
                              return "please enter a valid  code";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (String saveUsername) {
                            _code = saveUsername;
                          },
                        ),
                      ),
                      AnimationClass(
                        1.3,
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: AnimationClass(
                              1.3,
                              Flatbutton(
                                leadingText: AppLocalization.of(context)
                                    .translate("didn't"),
                                titleText: AppLocalization.of(context)
                                    .translate("re-send"),
                                onPressed: () async {
                                  await AwsAuth.instance
                                      .resendConfirmationCode(widget.email);
                                },
                              )),
                        ),
                      ),
                      AnimationClass(
                        1.3,
                        Builder(builder: (context) {
                          return Center(
                            child: RoundRectangleButton(
                                color: Colors.red,
                                elevation: 4.0,
                                height: 50.0,
                                text: AppLocalization.of(context)
                                    .translate("verify"),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                minWidth: MediaQuery.of(context).size.width / 2,
                                onPresss: () async {
                                  try {
                                    if (keyForm.currentState.validate()) {
                                      keyForm.currentState.save();

                                      // print(_firstName);
                                      print(_code);

                                      await AwsAuth.instance
                                          .confirmSignUp(widget.email, _code);

                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => Profile(
                                                    firstName: widget.firstName,
                                                    lastName: widget.lastName,
                                                  )));
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                }),
                          );
                        }),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
