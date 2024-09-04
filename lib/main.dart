// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/dashboard_page.dart';
import 'pages/users_page.dart';
import 'pages/companies_page.dart';
import 'pages/help_support_page.dart';
import 'widgets/sidebar.dart';
import 'widgets/custom_footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAJ6lmbx1jzbXI_olS_2jVJ3DndbBn0D2E",
      authDomain: "industry-day-ekyc-ba963.firebaseapp.com",
      projectId: "industry-day-ekyc-ba963",
      storageBucket: "industry-day-ekyc-ba963.appspot.com",
      messagingSenderId: "679137968740",
      appId: "1:679137968740:web:81f4f78effb649df9fd571",
      measurementId: "G-RL7EV81381",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QIU Industry Day Admin Site',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100], // Gray background
        textTheme: TextTheme(
          headlineLarge: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue,
          selectionColor: Colors.blue.withOpacity(0.4),
          selectionHandleColor: Colors.blue,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    DashboardPage(),
    UsersPage(),
    CompaniesPage(),
    HelpSupportPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Sidebar(
                  selectedIndex: _selectedIndex,
                  onItemTapped: _onItemTapped,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height:
                            100, // Match the height of the sidebar logo area
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'QIU Industry Day Admin Site',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 243, 204, 204),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: _pages[_selectedIndex],
                            ),
                          ),
                        ),
                      ),
                      CustomFooter(), // Footer inside Expanded
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
