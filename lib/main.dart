import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:saloneverywhere/amplifyconfiguration.dart';
import 'package:saloneverywhere/Screens/SigneUp_Page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:saloneverywhere/Logic/AppLocalization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureAmplify();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp_Page(),
      supportedLocales: [Locale("en", "CA"), Locale("fr", "CA")],
      localizationsDelegates: [
        AppLocalization.Delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supported in supportedLocales) {
          if (supported.languageCode == locale.languageCode &&
              supported.countryCode == locale.countryCode) {
            return supported;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

Future<void> configureAmplify() async {
  try {
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugins([authPlugin]);
    await Amplify.configure(amplifyconfig);
  } catch (e) {
    print(e);
  }
}
