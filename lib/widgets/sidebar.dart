// lib/widgets/sidebar.dart

import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  Sidebar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.white, // Sidebar background
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Image.asset(
              'assets/images/industryday_redLogo03.png',
              height: 86, // Adjusted height for logo
            ),
          ),
          Divider(color: Colors.grey[300]),

          // Menu items
          _buildMenuItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            index: 0,
          ),
          _buildMenuItem(
            context,
            icon: Icons.people_outline,
            title: 'Users',
            index: 1,
          ),
          _buildMenuItem(
            context,
            icon: Icons.business_outlined,
            title: 'Companies',
            index: 2,
          ),
          _buildMenuItem(
            context,
            icon: Icons.bar_chart_outlined,
            title: 'Help & Support',
            index: 3,
          ),
          Spacer(),
          Divider(color: Colors.grey[300]),

          // Logout button
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.redAccent,
              size: 21,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 18,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/logout'); // Navigate to logout page
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon, required String title, required int index}) {
    bool isActive = selectedIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.blue : Colors.grey[600],
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.grey[800],
          fontSize: 18,
        ),
      ),
      tileColor: isActive ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      onTap: () => onItemTapped(index),
    );
  }
}
