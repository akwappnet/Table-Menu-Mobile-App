import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/cart_screen.dart';
import 'package:table_menu_customer/view/home_screen.dart';
import 'package:table_menu_customer/view/menu_screen.dart';
import 'package:table_menu_customer/view/orders_screen.dart';
import 'package:table_menu_customer/view/profile_screen.dart';
import 'package:table_menu_customer/view/qr_scanner_screen.dart';
import 'package:table_menu_customer/view/registration_screen.dart';
import 'package:table_menu_customer/view/user_information_screen.dart';
import 'package:table_menu_customer/view/verify_user_screen.dart';
import 'package:table_menu_customer/view/welcome_screen.dart';
import '../../model/user_model.dart';
import '../../view/login_screen.dart';
import '../../view/reset_password_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    UserData? userData = settings.arguments as UserData?;
    switch (settings.name) {

      case RoutesName.WELCOME_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => WelcomeScreen());

      case RoutesName.REGISTER_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => RegistrationScreen());

      case RoutesName.LOGIN_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen());

      case RoutesName.HOME_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());

      case RoutesName.USER_INFO_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => UserInfoScreen(userData));

      case RoutesName.RESET_PASSWORD_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => ResetPasswordScreen());

      case RoutesName.MENU_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => MenuScreen());

      case RoutesName.QR_SCANNER_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => QRScannerScreen());

      case RoutesName.CART_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => CartScreen());

      case RoutesName.ORDER_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => OrdersScreen());

      case RoutesName.PROFILE_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => ProfileScreen());

      case RoutesName.VERIFY_USER_SCREEN_ROUTE:
        return MaterialPageRoute(
            builder: (BuildContext context) => VerifyUserScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }
}
