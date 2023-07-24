import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/cart_screen/cart_screen.dart';
import 'package:table_menu_customer/view/checkout_screen/checkout_screen.dart';
import 'package:table_menu_customer/view/feedback_screeen/feedback_screen.dart';
import 'package:table_menu_customer/view/home_screen.dart';
import 'package:table_menu_customer/view/menu_screeen/menu_screen.dart';
import 'package:table_menu_customer/view/no_internet_screen.dart';
import 'package:table_menu_customer/view/notification_screen.dart';
import 'package:table_menu_customer/view/order_tracking_screen.dart';
import 'package:table_menu_customer/view/order_sucessful_screen.dart';
import 'package:table_menu_customer/view/orders_screen/orders_screen.dart';
import 'package:table_menu_customer/view/payment_successful_screen.dart';
import 'package:table_menu_customer/view/profile_screen/favorites_menuitem_screen.dart';
import 'package:table_menu_customer/view/profile_screen/help_support_screen.dart';
import 'package:table_menu_customer/view/profile_screen/profile_screen.dart';
import 'package:table_menu_customer/view/profile_screen/settings_payment_screen.dart';
import 'package:table_menu_customer/view/profile_screen/settings_profile_screen.dart';
import 'package:table_menu_customer/view/profile_screen/settings_screen.dart';
import 'package:table_menu_customer/view/qr_scanner_screen.dart';
import 'package:table_menu_customer/view/registration_screen.dart';
import 'package:table_menu_customer/view/user_information_screen.dart';
import 'package:table_menu_customer/view/verify_user_screen.dart';
import 'package:table_menu_customer/view/welcome_screen.dart';
import 'package:table_menu_customer/view_model/connectivity_provider.dart';

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
        return _buildPageRoute(RegistrationScreen());

      case RoutesName.LOGIN_SCREEN_ROUTE:
        return _buildPageRoute(LoginScreen());

      case RoutesName.HOME_SCREEN_ROUTE:
        return _buildPageRoute(const HomeScreen());

      case RoutesName.USER_INFO_SCREEN_ROUTE:
          return _buildPageRoute(UserInfoScreen(arguments));

      case RoutesName.RESET_PASSWORD_SCREEN_ROUTE:
        return _buildPageRoute(ResetPasswordScreen());

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
        return _buildPageRoute(OrderSuccessfulScreen(order_id: arguments,));

      case RoutesName.ORDER_TRACKING_SCREEN_ROUTE:
        return _buildPageRoute(OrderTrackingScreen(order_id: arguments,));

      case RoutesName.CHECKOUT_SCREEN_ROUTE:
        return _buildPageRoute(CheckoutScreen(arguments: arguments,));

      case RoutesName.PAYMENT_SUCCESSFUL_SCREEN_ROUTE:
        return _buildPageRoute(PaymentSuccessfulScreen(orderID: arguments,));

      case RoutesName.FEEDBACK_SCREEN_ROUTE:
        return _buildPageRoute(FeedbackScreen(orderID: arguments,));

      case RoutesName.SETTINGS_PROFILE_SCREEN_ROUTE:
        return _buildPageRoute(const SettingsProfileScreen());

      case RoutesName.SETTINGS_PAYMENT_SCREEN_ROUTE:
        return _buildPageRoute(const SettingsPaymentScreen());

      case RoutesName.HELP_SUPPORT_SCREEN_ROUTE:
        return _buildPageRoute(const HelpSupportScreen());

      case RoutesName.SETTINGS_SCREEN_ROUTE:
        return _buildPageRoute(const SettingsScreen());

      case RoutesName.NO_INTERNET_SCREEN_ROUTE:
        return _buildPageRoute(const NoInternetScreen());

      case RoutesName.FAVORITES_MENUITEM_SCREEN_ROUTE:
        return _buildPageRoute(const FavoritesMenuItems());

      default:
        return _buildPageRoute(const Scaffold(
          body: Center(child: Text('No route defined')),
        ));
    }
  }

  static PageRouteBuilder<Object> _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        final isInternetAvailable = Provider.of<ConnectivityProvider>(context).isInternetAvailable;
        if(!isInternetAvailable){
          return const NoInternetScreen();
        }else {
          return page;
        }
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
}
