// lib/services/network_test.dart

import 'package:http/http.dart' as http;

void main() async {
  final response = await http.get(Uri.parse('https://www.google.com'));
  if (response.statusCode == 200) {
    print('Network connection is fine.');
  } else {
    print('Network connection issue.');
  }
}
