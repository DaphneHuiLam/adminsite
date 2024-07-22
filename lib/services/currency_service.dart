// lib/services/currency_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyService {
  final String apiKey = '3298a47ca6d14316b3bf2a3e';
  final String baseUrl = 'https://v6.exchangerate-api.com/v6/';

  Future<Map<String, double>> getExchangeRates(String base) async {
    final response =
        await http.get(Uri.parse('${baseUrl}$apiKey/latest/$base'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, double> rates = {};
      data['conversion_rates'].forEach((key, value) {
        rates[key] = value.toDouble();
      });
      return rates;
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}
