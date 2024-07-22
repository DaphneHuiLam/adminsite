// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/firebase_options.dart';
import 'localization/app_localizations.dart';
import 'services/localization_service.dart';
import 'pages/login_page.dart';
import 'pages/admin_main_page.dart';
import 'pages/user_home_page.dart';
import 'pages/language_switch_page.dart';
import 'pages/currency_switch_page.dart';
import 'services/search_service.dart';
import 'theme/theme.dart';
import 'pages/admin_list_firebase_data.dart';
// Import other project screens
import 'pages/user_screen_3dviewer.dart';
import 'pages/user_screen_ar.dart';
import 'pages/user_screen_cart.dart';
import 'pages/user_screen_product_category.dart';
import 'pages/user_screen_product_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Site',
      theme: appTheme,
      locale: _locale,
      supportedLocales: LocalizationService.supportedLocales,
      localizationsDelegates: LocalizationService.localizationsDelegates,
      home: LoginPage(),
      routes: {
        '/adminHome': (context) => AdminMainPage(),
        '/userHome': (context) => UserHomePage(),
        '/languageSwitch': (context) => LanguageSwitchPage(),
        '/currencySwitch': (context) => CurrencySwitchPage(),
        '/user_screen_ar': (context) => const UserScreenAR(),
        '/user_screen_product_category': (context) =>
            const UserScreenProductCategory(),
        '/user_screen_cart': (context) => UserScreenCart(),
        '/user_screen_3dviewer': (context) => UserScreen3DViewer(),
        '/admin_list_firebase_data': (context) => AdminListFirebaseData(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/user_screen_product_info') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return UserScreenProductInfo(
                productID: args['productID'],
              );
            },
          );
        }
        return null;
      },
    );
  }
}

/*
flutter run -d chrome
*/

