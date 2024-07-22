// lib/services/localization_service.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../localization/app_localizations.dart';
import '../main.dart';
import 'currency_service.dart';

class LocalizationService {
  static Locale? locale;
  static String currency = 'USD';
  static Map<String, double> exchangeRates = {};

  static List<Locale> get supportedLocales => [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('hi', ''),
        Locale('th', ''),
        Locale('tl', ''),
        Locale('vi', ''),
      ];

  static List<String> get supportedCurrencies => [
        'USD',
        'EUR',
        'JPY',
        'GBP',
        'AUD',
        'CAD',
        'CHF',
        'CNY',
        'SEK',
        'NZD',
      ];

  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates =>
      [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  static Future<void> setLocale(BuildContext context, Locale newLocale) async {
    locale = newLocale;
    MyApp.setLocale(context, newLocale);
  }

  static Future<void> setCurrency(String newCurrency) async {
    currency = newCurrency;
    exchangeRates = await CurrencyService().getExchangeRates(newCurrency);
    // Refresh UI
  }

  static double convertCurrency(
      double amount, String fromCurrency, String toCurrency) {
    if (exchangeRates.isEmpty || fromCurrency == toCurrency) return amount;
    double rate = exchangeRates[toCurrency] ?? 1.0;
    return amount * rate;
  }
}
