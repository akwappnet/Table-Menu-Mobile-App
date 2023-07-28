import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/view/cart_screen/cart_screen.dart';
import 'package:table_menu_customer/view/profile_screen/profile_screen.dart';

import '../app_localizations.dart';
import '../view_model/nav_provider.dart';
import 'menu_screeen/menu_screen.dart';
import 'orders_screen/orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _widgetOptions = <Widget>[
    const MenuScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final nav_provider = Provider.of<NavProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Center(
            child: _widgetOptions.elementAt(nav_provider.index),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        useLegacyColorScheme : true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: AppLocalizations.of(context).translate('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            label: AppLocalizations.of(context).translate('title_cart'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fastfood_outlined),
            label: AppLocalizations.of(context).translate('orders'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: AppLocalizations.of(context).translate('profile'),
          ),
        ],
        currentIndex: nav_provider.index,
        onTap: (int index) async {
          nav_provider.changeIndex(index);
        },
      ),
    );
  }
}
