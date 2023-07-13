import 'package:flutter/material.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/cart_screen/cart_screen.dart';
import 'package:table_menu_customer/view/checkout_screen/checkout_screen.dart';
import 'package:table_menu_customer/view/feedback_screeen/feedback_screen.dart';
import 'package:table_menu_customer/view/home_screen.dart';
import 'package:table_menu_customer/view/menu_screeen/menu_screen.dart';
import 'package:table_menu_customer/view/notification_screen.dart';
import 'package:table_menu_customer/view/order_details_screen.dart';
import 'package:table_menu_customer/view/order_sucessful_screen.dart';
import 'package:table_menu_customer/view/orders_screen/orders_screen.dart';
import 'package:table_menu_customer/view/payment_successful_screen.dart';
import 'package:table_menu_customer/view/profile_screen.dart';
import 'package:table_menu_customer/view/qr_scanner_screen.dart';
import 'package:table_menu_customer/view/registration_screen.dart';
import 'package:table_menu_customer/view/user_information_screen.dart';
import 'package:table_menu_customer/view/verify_user_screen.dart';
import 'package:table_menu_customer/view/welcome_screen.dart';

import '../../view/login_screen.dart';
import '../../view/menu_item_details_screen.dart';
import '../../view/reset_password_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic arguments = settings.arguments;
    switch (settings.name) {
      case RoutesName.WELCOME_SCREEN_ROUTE:
        return _buildPageRoute(const WelcomeScreen());

      case RoutesName.REGISTER_SCREEN_ROUTE:
        return _buildPageRoute(const RegistrationScreen());

      case RoutesName.LOGIN_SCREEN_ROUTE:
        return _buildPageRoute(const LoginScreen());

      case RoutesName.HOME_SCREEN_ROUTE:
        return _buildPageRoute(const HomeScreen());

      case RoutesName.USER_INFO_SCREEN_ROUTE:
          return _buildPageRoute(UserInfoScreen(arguments));

      case RoutesName.RESET_PASSWORD_SCREEN_ROUTE:
        return _buildPageRoute(const ResetPasswordScreen());

      case RoutesName.MENU_SCREEN_ROUTE:
        return _buildPageRoute(const MenuScreen());

      case RoutesName.QR_SCANNER_SCREEN_ROUTE:
        return _buildPageRoute(const QRScannerScreen());

      case RoutesName.CART_SCREEN_ROUTE:
        return _buildPageRoute(const CartScreen());

      case RoutesName.ORDER_SCREEN_ROUTE:
        return _buildPageRoute(const OrdersScreen());

      case RoutesName.PROFILE_SCREEN_ROUTE:
        return _buildPageRoute(const ProfileScreen());

      case RoutesName.VERIFY_USER_SCREEN_ROUTE:
          return _buildPageRoute(VerifyUserScreen(arguments));

      case RoutesName.NOTIFICATION_SCREEN_ROUTE:
        return _buildPageRoute(const NotificationScreen());

      case RoutesName.MENU_ITEM_DETAILS_SCREEN_ROUTE:
        return _buildPageRoute(MenuItemDetailsPage(menuData : arguments));

      case RoutesName.ORDER_SUCCESSFUL_SCREEN_ROUTE:
        return _buildPageRoute(const OrderSuccessfulScreen());

      case RoutesName.ORDER_DETAILS_SCREEN_ROUTE:
        return _buildPageRoute(const OrderDetailsScreen());

      case RoutesName.CHECKOUT_SCREEN_ROUTE:
        return _buildPageRoute(CheckoutScreen());

      case RoutesName.PAYMENT_SUCCESSFUL_SCREEN_ROUTE:
        return _buildPageRoute(const PaymentSuccessfulScreen());

      case RoutesName.FEEDBACK_SCREEN_ROUTE:
        return _buildPageRoute(FeedbackScreen());

      default:
        return _buildPageRoute(const Scaffold(
          body: Center(child: Text('No route defined')),
        ));
    }
  }

  static PageRouteBuilder<Object> _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        final Animation<Offset> slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 600), // Adjust the duration as needed
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('No route defined')),
      ),
    );
  }
}
