// lib/components/user_list_tile.dart
// wf - 72 lines

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/colors.dart';

class UserListTile extends StatelessWidget {
  final String watchName;
  final String watchDescription;
  final double irWatchPrice;
  final String watchCategory;

  const UserListTile({
    super.key,
    required this.watchName,
    required this.watchDescription,
    required this.irWatchPrice,
    required this.watchCategory,
  });

  @override
  Widget build(BuildContext context) {
    // Format the price with a currency symbol using NumberFormat
    final NumberFormat currencyFormat = NumberFormat.currency(symbol: '\$');

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          title: Text(
            watchName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                watchDescription,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                currencyFormat.format(irWatchPrice),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                watchCategory,
                style: TextStyle(
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
