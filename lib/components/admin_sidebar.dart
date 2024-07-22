// lib/components/admin_sidebar.dart

import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../pages/language_switch_page.dart';
import '../pages/currency_switch_page.dart';
import '../localization/app_localizations.dart';

class AdminSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback onLogout;

  AdminSidebar({
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: 250,
      color: primaryColor1,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            color: primaryColor1,
            child: Center(
              child: Text(
                localizations.adminSite,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _createDrawerCategory(localizations.main),
                _createDrawerItem(
                  icon: Icons.dashboard,
                  text: localizations.dashboard,
                  onTap: () => onItemTapped(0),
                  selected: selectedIndex == 0,
                ),
                _createDrawerCategory(localizations.management),
                _createDrawerItem(
                  icon: Icons.people,
                  text: localizations.users,
                  onTap: () => onItemTapped(1),
                  selected: selectedIndex == 1,
                ),
                _createDrawerItem(
                    icon: Icons.shopping_cart,
                    text: localizations.orders,
                    onTap: () => onItemTapped(2),
                    selected: selectedIndex == 2),
                _createDrawerItem(
                    icon: Icons.inventory,
                    text: localizations.products,
                    onTap: () => onItemTapped(3),
                    selected: selectedIndex == 3),
                _createDrawerItem(
                    icon: Icons.inventory_2,
                    text: localizations.thirdPartyCollects,
                    onTap: () => onItemTapped(4),
                    selected: selectedIndex == 4),
                _createDrawerCategory(localizations.reports),
                _createDrawerItem(
                    icon: Icons.bar_chart,
                    text: localizations.reports,
                    onTap: () => onItemTapped(5),
                    selected: selectedIndex == 5),
                _createDrawerCategory(localizations.data),
                _createDrawerItem(
                    icon: Icons.storage,
                    text: localizations.firebaseData,
                    onTap: () => onItemTapped(6),
                    selected: selectedIndex == 6),
                _createDrawerCategory(localizations.settings),
                _createDrawerItem(
                    icon: Icons.language,
                    text: localizations.language,
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LanguageSwitchPage(),
                          ),
                        ),
                    selected: false),
                _createDrawerItem(
                    icon: Icons.attach_money,
                    text: localizations.currency,
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CurrencySwitchPage(),
                          ),
                        ),
                    selected: false),
                _createDrawerCategory(localizations.profile),
                _createDrawerItem(
                    icon: Icons.person,
                    text: localizations.profile,
                    onTap: () => onItemTapped(7),
                    selected: selectedIndex == 7),
                _createDrawerCategory(localizations.helpSupport),
                _createDrawerItem(
                    icon: Icons.help,
                    text: localizations.helpSupport,
                    onTap: () => onItemTapped(8),
                    selected: selectedIndex == 8),
              ],
            ),
          ),
          Divider(color: Colors.white),
          _createDrawerItem(
              icon: Icons.exit_to_app,
              text: localizations.logout,
              onTap: onLogout,
              selected: false),
        ],
      ),
    );
  }

  Widget _createDrawerCategory(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 8, bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
    bool selected = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: selected ? secondaryColor2 : Colors.white70),
      title: Text(
        text,
        style: TextStyle(
          color: selected ? secondaryColor2 : Colors.white70,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}
