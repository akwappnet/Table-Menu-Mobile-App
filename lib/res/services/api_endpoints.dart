class ApiEndPoint {
  static const String baseUrl = "http://192.168.10.147:8001/api/";
  static String baseImageUrl = "http://192.168.10.147:8001";
  static _AuthEndPoint authEndPoints = _AuthEndPoint();
  static _UserInfoEndPoint userInfoEndPoint = _UserInfoEndPoint();
  static _MenuEndPoint menuEndPoint = _MenuEndPoint();
  static _CartEndPoint cartEndPoint = _CartEndPoint();
  static _OrderEndPoint orderEndPoint = _OrderEndPoint();
  static _NotificationEndPoint notificationEndPoint = _NotificationEndPoint();
}

class _AuthEndPoint {
  final String registrarion = "auth/registration/";
  final String login = "auth/login/";
  final String verifyUser = "auth/verify-activationotp/";
  final String sendActivationOtp = "auth/send-activationotp/";
  final String verifyForgotOtp = "auth/verify-forgetotp/";
  final String sendForgotOtp = "auth/send-forgetotp/";
  final String resetPassword = "auth/forget-password/";
}

class _UserInfoEndPoint {
  final String userInfoEndpoint = "customer/userinfo/";
}

class _MenuEndPoint {
  final String categoryEndPoint = "customer/categories/";
  final String menuItemEndPoint = "customer/menu_items/";
  final String filterEndPoint = "customer/search/?query=spicy";
}

class _CartEndPoint {
  final String cartEndPoint = "customer/cartitems/";
}

class _OrderEndPoint {
  final String orderEndPoint = "customer/order/";
  final String cancelOrderEndPoint = "customer/cancelled_order/";
  final String orderBaseImageUrl = "http://192.168.10.179:8001/media/";
}

class _NotificationEndPoint {
  final String notificationEndPoint = "customer/notification/";
  final String notificationDeleteAllEndPoint = "customer/notification/deleteall/";
}
