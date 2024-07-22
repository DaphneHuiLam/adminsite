// lib/components/user_drawer.dart
// wf - 126 lines

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  // Logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Drawer header
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              // Home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("H O M E"),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ),
              const SizedBox(height: 25),

              // Product category tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.category,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("P R O D U C T C A T E G O R Y"),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushNamed(
                        context, '/user_screen_product_category');
                  },
                ),
              ),
              const SizedBox(height: 25),

              // Product detail tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("P R O D U C T D E T A I L"),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushNamed(
                      context,
                      '/user_screen_product_info',
                      arguments: {'productID': 'exampleProductID'},
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Product cart tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.group,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("P R O D U C T C A R T "),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushNamed(context, '/user_screen_cart');
              },
            ),
          ),
          const SizedBox(height: 25),

          // AR screen tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.category,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("A R S C E N E"),
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushNamed(context, '/user_screen_ar');
              },
            ),
          ),
        ],
      ),
    );
  }
}
