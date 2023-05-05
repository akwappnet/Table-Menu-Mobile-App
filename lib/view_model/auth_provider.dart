import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/model/auth_model.dart';
import 'package:table_menu_customer/view/home_screen.dart';
import 'package:table_menu_customer/view/login_screen.dart';
import 'package:table_menu_customer/view/reset_password_screen.dart';
import 'package:table_menu_customer/view/verify_user_screen.dart';
import '../repository/auth_repository.dart';
import '../utils/widgets/custom_dialog.dart';

class AuthProvider extends ChangeNotifier {

  final AuthRepository _authRepository = AuthRepository();

  // login controllers
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  // register controllers
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController = TextEditingController();
  final TextEditingController repeatePasswordRegisterController = TextEditingController();

  // verify user Controller
  final TextEditingController activationOTPController = TextEditingController();

  // forgot password Controller
  final TextEditingController forgotPassEmailController = TextEditingController();
  final TextEditingController forgotPassOTPController = TextEditingController();
  final TextEditingController resetPassController = TextEditingController();
  final TextEditingController resetrepeatPassController = TextEditingController();


  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> userRegisteration(String email, String password, BuildContext context) async {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? fcmToken = await messaging.getToken();
      String deviceType = '';
      if (!kIsWeb) {
        // Get the device type for non-web platforms

        if (Platform.isIOS) {
          deviceType = 'iOS';
        } else if (Platform.isAndroid) {
          deviceType = 'Android';
        } else if (Platform.isLinux){
          deviceType = 'Linux';
        } else if (Platform.isMacOS) {
          deviceType = 'MacOS';
        } else if (Platform.isWindows) {
          deviceType = 'Windows';
        } else if (Platform.isFuchsia) {
          deviceType = 'Fuchsia';
        }else {
          deviceType = '';
        }
        print('Device Type: $deviceType');
      }
      print('FCM Token: $fcmToken');


      var data = AuthModel(
        email: email,
        password: password,
        deviceType: deviceType,
        fcmToken: fcmToken
      );
      var result = await _authRepository.registrationUser(data.toJson());

      if(result.data['status'] == true && result.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifyUserScreen(),));
      }else if (result.data['status'] == false){
        print("status : ${result.data['data']['status']}");
      }
  }

  Future<void> userLogin(dynamic data, BuildContext context) async {
    setLoading(true);

    var result = await _authRepository.loginUser(data);

    if(result.data['status'] == true && result.statusCode == 200){
      setLoading(false);
      String token = result.data['token'];
      print(token);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

    } else if (result.data['status'] == false) {
      showDialog(
          barrierDismissible: true,
          barrierLabel: '',
          barrierColor: Colors.black38,
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              heading: "Verification",
              icon: Icon(Icons.not_listed_location),
              backgroundColor: Colors.red,
              title: result.data['message']['errors'][0].toString(),
              descriptions: "", //
              btn1Text: "",
              btn2Text: "",
            );
          });
      await Future.delayed(const Duration(seconds: 3))
          .then((value) => Navigator.of(context).pop());
    }
  }

  Future<void> verifyUser (String otp, BuildContext context, String checkRequest) async{

    Map<String,dynamic> data = {
      'otp' : otp
    };
    var result = await _authRepository.verifyUser(data);

    if(checkRequest == "userActivation"){
      if(result.data['status'] == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }
    }else {
      if(result.data['status'] == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(otp: otp,),));
      }
    }

  }

  Future<void> sendVerifiactionMail(String email, BuildContext context) async{

    Map<String,dynamic> data = {
      'email' : email
    };
    var result = await _authRepository.sendForgotPasswordOTP(data);

    if(result.data['status'] == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifyUserScreen(true),));
    }
  }

  Future<void> resetPasswordUser(String email, String password, String otp, BuildContext context) async{

    Map<String,dynamic> data = {
      "email": email,
      "otp": otp,
      "password": password
    };
    var result = await _authRepository.resetPassword(data);

    if(result.data['status'] == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }

  }


}
