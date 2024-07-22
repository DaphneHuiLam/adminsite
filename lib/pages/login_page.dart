// lib/pages/login_page.dart

import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../localization/app_localizations.dart';
import 'user_home_page.dart';
import 'admin_main_page.dart';
import '../widgets/switch_button.dart';
import '../widgets/language_switch_button.dart' as lang; // Import with prefix
import '../widgets/currency_switch_button.dart' as curr; // Import with prefix

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.loginTitle),
        actions: [
          lang.LanguageSwitchButton(),
          SizedBox(width: 8), // Add some spacing between the buttons
          curr.CurrencySwitchButton(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SwitchButton(
              text: localizations.loginAsUser,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHomePage(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            SwitchButton(
              text: localizations.loginAsAdmin,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminMainPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 40), // Adjust spacing here as needed
            Text(
              localizations.welcomeMessage,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
