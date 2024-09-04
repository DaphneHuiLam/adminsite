//lib/pages/logout_page.dart

import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 204, 204),
      body: Center(
        child: SingleChildScrollView(
          // resolve pixel overflow
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/industryday_redLogo03.png',
                height: 360, // enlarge image
              ),
              SizedBox(height: 30),
              Text(
                'You have been logged out',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
