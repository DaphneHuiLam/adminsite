// lib/localization/app_localizations.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? '';
  }

  // 添加所有需要的字符串getter
  String get loginTitle => translate('loginTitle');
  String get loginAsUser => translate('loginAsUser');
  String get loginAsAdmin => translate('loginAsAdmin');
  String get switchLanguage => translate('switchLanguage');
  String get switchCurrency => translate('switchCurrency');
  String get welcomeMessage => translate('welcomeMessage');
  String get language => translate('language');
  String get currency => translate('currency');
  String get english => translate('english');
  String get chinese => translate('chinese');
  String get hindi => translate('hindi');
  String get thai => translate('thai');
  String get tagalog => translate('tagalog');
  String get vietnamese => translate('vietnamese');
  String get manageUsersTitle => translate('manageUsersTitle');
  String get userName => translate('userName');
  String get email => translate('email');
  String get addUser => translate('addUser');

  // 添加新需要的getter
  String get adminSite => translate('adminSite');
  String get main => translate('main');
  String get dashboard => translate('dashboard');
  String get management => translate('management');
  String get users => translate('users');
  String get orders => translate('orders');
  String get products => translate('products');
  String get thirdPartyCollects => translate('thirdPartyCollects');
  String get reports => translate('reports');
  String get firebaseData => translate('firebaseData');
  String get settings => translate('settings');
  String get profile => translate('profile');
  String get helpSupport => translate('helpSupport');
  String get logout => translate('logout');
  String get data => translate('data'); // 添加缺失的 'data' getter

  // 添加 getLocaleName 方法
  String getLocaleName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return english;
      case 'zh':
        return chinese;
      case 'hi':
        return hindi;
      case 'th':
        return thai;
      case 'tl':
        return tagalog;
      case 'vi':
        return vietnamese;
      default:
        return locale.languageCode;
    }
  }

  // 添加 getCurrencyName 方法
  String getCurrencyName(String currency) {
    switch (currency) {
      case 'USD':
        return 'US Dollar';
      case 'EUR':
        return 'Euro';
      case 'JPY':
        return 'Japanese Yen';
      case 'GBP':
        return 'British Pound';
      case 'AUD':
        return 'Australian Dollar';
      case 'CAD':
        return 'Canadian Dollar';
      case 'CHF':
        return 'Swiss Franc';
      case 'CNY':
        return 'Chinese Yuan';
      case 'SEK':
        return 'Swedish Krona';
      case 'NZD':
        return 'New Zealand Dollar';
      default:
        return currency;
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh', 'hi', 'th', 'tl', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
