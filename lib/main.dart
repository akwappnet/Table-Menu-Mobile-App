import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/view/welcome_screen.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';
import 'package:table_menu_customer/view_model/cart_provider.dart';
import 'package:table_menu_customer/view_model/menu_provider.dart';
import 'package:table_menu_customer/view_model/nav_provider.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

import 'model/cart_model.dart';
import 'model/category_model.dart';
import 'model/menuItem_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       // StreamProvider<List<CategoryModel>>(create: (_) => FireStoreService().getCategories(), initialData: const [],),
        //StreamProvider<List<MenuItemModel>>(create: (_) => FireStoreService().getMenuItems(), initialData: const [],),
        //StreamProvider<List<CartModel>>(create: (_) => FireStoreService().getCartItems(), initialData: const [],),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => QRProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Table Menu Customer',
        theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.purple,
            fontFamily: 'Roboto'
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
      ),
    );
  }
}



