
class ApiEndPoint {
   static const String baseUrl = "http://192.168.10.179:8001/api/";
   static String baseImageUrl = "";
   static _AuthEndPoint authEndPoints = _AuthEndPoint();
   static _UserInfoEndPoint userInfoEndPoint = _UserInfoEndPoint();
}

class _AuthEndPoint {
  final String registrarion = "auth/registration/";
  final String login = "auth/login/";
  final String verifyUser = "auth/verify-activationotp/";
  final String sendActivationOtp = "auth/send-activationotp/";
  final String sendForgotOtp = "auth/send-forgetotp/";
  final String resetPassword = "auth/forget-password/";
}

class _UserInfoEndPoint {


}