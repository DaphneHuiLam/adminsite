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
      decoration: BoxDecoration(
        color: Colors.white, // Light background for sidebar
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical:
                    5.0), // Reduced padding to allow more space for the image
            child: Image.asset(
              'assets/images/industryday_redLogo03.png',
              height: 86, // Increased height for a bigger image
            ),
          ),
          Divider(color: Colors.grey[300]),
          _buildMenuItem(
            context,
            icon: Icons.dashboard_outlined,
            title: 'Dashboard',
            isActive: selectedIndex == 0,
            onTap: () => onItemTapped(0),
          ),
          _buildMenuItem(
            context,
            icon: Icons.people_outline,
            title: 'Users',
            isActive: selectedIndex == 1,
            onTap: () => onItemTapped(1),
          ),
          _buildMenuItem(
            context,
            icon: Icons.business_outlined,
            title: 'Companies',
            isActive: selectedIndex == 2,
            onTap: () => onItemTapped(2),
          ),
          _buildMenuItem(
            context,
            icon: Icons.bar_chart_outlined,
            title: 'Help & Support',
            isActive: selectedIndex == 3,
            onTap: () => onItemTapped(3),
          ),
          Spacer(),
          Divider(color: Colors.grey[300]),
          ListTile(
            leading: Icon(Icons.logout,
                color: Colors.redAccent, size: 21), // Increased icon size
            title: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.redAccent, fontSize: 18), // Increased font size
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 22.0, vertical: 6.0), // Increased padding
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String title,
      required bool isActive,
      required VoidCallback onTap}) {
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
      onTap: onTap,
    );
  }
}
