// lib/pages/admin_page_settings.dart

import 'package:flutter/material.dart';

class AdminPageSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              // Navigate to profile settings page
            },
          ),
          ListTile(
            title: Text('Notifications'),
            leading: Icon(Icons.notifications),
            onTap: () {
              // Navigate to notifications settings page
            },
          ),
          ListTile(
            title: Text('Language'),
            leading: Icon(Icons.language),
            onTap: () {
              // Navigate to language settings page
            },
          ),
          ListTile(
            title: Text('Currency'),
            leading: Icon(Icons.attach_money),
            onTap: () {
              // Navigate to currency settings page
            },
          ),
          ListTile(
            title: Text('Privacy'),
            leading: Icon(Icons.lock),
            onTap: () {
              // Navigate to privacy settings page
            },
          ),
        ],
      ),
    );
  }
}
