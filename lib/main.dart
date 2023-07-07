import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/repository/auth_repository.dart';
import 'package:table_menu_customer/utils/assets/assets_utils.dart';
import 'package:table_menu_customer/utils/routes/routes.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/home_screen.dart';
import 'package:table_menu_customer/view/login_screen.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';
import 'package:table_menu_customer/view_model/cart_provider.dart';
import 'package:table_menu_customer/view_model/menu_provider.dart';
import 'package:table_menu_customer/view_model/nav_provider.dart';
import 'package:table_menu_customer/view_model/notification_provider.dart';
import 'package:table_menu_customer/view_model/order_provider.dart';
import 'package:table_menu_customer/view_model/qr_provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NetworkApiService().setupInterceptors();
  final AuthRepository authRepository = AuthRepository();
  bool loggedIn = await authRepository.isLoggedIn();
  runApp(MyApp(
    loggedIn: loggedIn,
  ));
}



class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.loggedIn});
  final bool loggedIn;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => MenuProvider()),
          ChangeNotifierProvider(create: (_) => NavProvider()),
          ChangeNotifierProvider(create: (_) => QRProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
        ],
        child: MaterialApp(
          title: 'Table Menu Customer',
          theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.purple,
              fontFamily: 'Roboto'),
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            duration: 3000,
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.white,
            animationDuration: const Duration(seconds: 1),
            splashIconSize: 300,
            splash: Center(
              child: Image.asset(
                AssetsUtils.ASSETS_TABLE_MENU_LOGO,
                height: 300,
                width: 300,
              ),
            ),
            nextScreen: widget.loggedIn ? const HomeScreen() : const LoginScreen(),
          ),
          initialRoute: widget.loggedIn
              ? RoutesName.HOME_SCREEN_ROUTE
              : RoutesName.LOGIN_SCREEN_ROUTE,
          onGenerateRoute: Routes.generateRoute,
        )
    );

  }
}
