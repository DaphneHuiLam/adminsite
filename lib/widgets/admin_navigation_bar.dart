/*
// lib/widgets/admin_navigation_bar.dart

import 'package:flutter/material.dart';

class AdminNavigationBar extends StatelessWidget {
  final void Function(int)? onItemTapped;
  final int? selectedIndex;

  const AdminNavigationBar({
    this.onItemTapped,
    this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.dashboard),
          color: selectedIndex == 0 ? Colors.blue : Colors.grey,
          tooltip: 'Dashboard', // Add tooltip here
          onPressed: () => onItemTapped?.call(0),
        ),
        IconButton(
          icon: Icon(Icons.people),
          color: selectedIndex == 1 ? Colors.blue : Colors.grey,
          onPressed: () => onItemTapped?.call(1),
        ),
        IconButton(
          icon: Icon(Icons.business),
          color: selectedIndex == 2 ? Colors.blue : Colors.grey,
          onPressed: () => onItemTapped?.call(2),
        ),
        IconButton(
          icon: Icon(Icons.assignment),
          color: selectedIndex == 3 ? Colors.blue : Colors.grey,
          onPressed: () => onItemTapped?.call(3),
        ),
      ],
    );
  }
}
*/