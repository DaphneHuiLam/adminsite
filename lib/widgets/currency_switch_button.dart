// lib/widgets/currency_switch_button.dart

import 'package:flutter/material.dart';
import '../pages/currency_switch_page.dart';
import '../localization/app_localizations.dart';

class CurrencySwitchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CurrencySwitchPage()), // Navigate to CurrencySwitchPage
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Currency',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          SizedBox(width: 8),
          Icon(Icons.monetization_on, color: Colors.white),
        ],
      ),
    );
  }
}
