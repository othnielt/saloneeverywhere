import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';


class AwsAuth extends ChangeNotifier {
  static AwsAuth instance = new AwsAuth();




  void registerAccount(
      String email, String password, String firstName, String lastName) async {
    try {
      await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: {"email": email},
        ),
      );
    } on AuthException catch (error) {
      print(error);
    }
  }

  void confirmSignUp(String email, String code) async {
    try {
      await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: code,
      );
    } on AuthException catch (error) {
      print(error);
    }
  }

  void resendConfirmationCode(String email) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: email);
    } catch (error) {
      print(error);
    }
  }
}
