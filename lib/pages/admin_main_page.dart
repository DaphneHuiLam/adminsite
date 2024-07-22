// lib/pages/admin_main_page.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_manage_users.dart';
import 'admin_manage_orders.dart';
import 'admin_manage_third_party_collects.dart';
import 'admin_manage_products.dart';
import 'admin_page_reports.dart';
import 'admin_list_firebase_data.dart';
import 'admin_page_profile.dart';
import 'admin_page_notifications.dart';
import 'admin_page_help_support.dart';
import '../components/admin_sidebar.dart';
import '../services/search_service.dart';

class AdminMainPage extends StatefulWidget {
  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [];
  final List<String> _titles = [
    'Dashboard',
    'Manage Users',
    'Manage Orders',
    'Manage Products',
    'Manage Third Party Collects',
    'Reports',
    'Firebase Data',
    'Profile',
    'Notifications',
    'Help & Support'
  ];

  final SearchService _searchService = SearchService(
    firestore: FirebaseFirestore.instance,
  );

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      Center(
        child: Text(
          'Admin Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      AdminManageUsers(searchService: _searchService),
      AdminManageOrders(searchService: _searchService),
      AdminManageProducts(searchService: _searchService),
      AdminManageThirdPartyCollects(searchService: _searchService),
      AdminPageReports(searchService: _searchService),
      AdminListFirebaseData(),
      AdminPageProfile(),
      AdminPageNotifications(),
      AdminHelpSupport(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onLogout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AdminSidebar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
            onLogout: _onLogout,
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
