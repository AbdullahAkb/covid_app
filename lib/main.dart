import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:covid_app/screens/main_screen.dart';
import 'package:covid_app/utils/images.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:country_picker/country_picker.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en'),
        const Locale('ar'),
        const Locale('es'),
        const Locale('de'),
        const Locale('fr'),
        const Locale('el'),
        const Locale('et'),
        const Locale('nb'),
        const Locale('nn'),
        const Locale('pl'),
        const Locale('pt'),
        const Locale('ru'),
        const Locale('hi'),
        const Locale('ne'),
        const Locale('uk'),
        const Locale('hr'),
        const Locale('tr'),
        const Locale('lv'),
        const Locale('lt'),
        const Locale('ku'),
        const Locale('nl'),
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
        const Locale.fromSubtags(
            languageCode: 'zh',
            scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      home: AnimatedSplashScreen(
        splash: Images.splash_logo,
        animationDuration: Duration(seconds: 3),
        // duration: 20,
        splashIconSize: 130.0,
        nextScreen: MainScreen(),
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        backgroundColor: Color.fromARGB(255, 49, 49, 49),
      ),
    );
  }
}
