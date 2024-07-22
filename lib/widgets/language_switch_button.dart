// lib/widgets/language_switch_button.dart
import 'package:flutter/material.dart';
import '../services/localization_service.dart';
import '../localization/app_localizations.dart';
import '../pages/language_switch_page.dart';

class LanguageSwitchButton extends StatelessWidget {
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
                LanguageSwitchPage(), // 假设有 LanguageSwitchPage 定义
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            localizations.language,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          SizedBox(width: 8),
          Icon(Icons.language, color: Colors.white),
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import '../pages/language_switch_page.dart';
import '../localization/app_localizations.dart';

class LanguageSwitchButton extends StatelessWidget {
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
                  LanguageSwitchPage()), // Navigate to LanguageSwitchPage
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            localizations.language,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          SizedBox(width: 8),
          Icon(Icons.language, color: Colors.white),
        ],
      ),
    );
  }
}
*/