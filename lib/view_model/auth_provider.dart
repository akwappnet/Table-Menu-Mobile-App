import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/model/auth_model.dart';
import 'package:table_menu_customer/model/user_model.dart';
import 'package:table_menu_customer/repository/user_info_repository.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view/verify_user_screen.dart';
import '../repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {

  final AuthRepository _authRepository = AuthRepository();
  final UserInfoRepository _userInfoRepository = UserInfoRepository();

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

  // user info controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();


  bool _loading = false;
  bool get loading => _loading;

  UserData? _userData;
  UserData? get userData => _userData;

  String _user_name= "";
  String get user_name => _user_name;

  void setUserName(String value) {
    _user_name = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  loadValues(UserData userData){
    nameController.text = userData.name!;
    phoneNoController.text = userData.phoneNumber!;
  }

  Future<void> userRegisteration(String email, String password, BuildContext context) async {
      setLoading(true);
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
      print(result);
      if(result.data["status"] == true) {
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesName.VERIFY_USER_SCREEN_ROUTE);
      }else if (result.data['status'] == "False"){
        setLoading(false);
        // TODO show error message to user
        print("status : ${result.data['data']['status']}");
      }
  }

  Future<void> userLogin(dynamic data, BuildContext context) async {
    setLoading(true);
    var result = await _authRepository.loginUser(data);
    if(result.data['status'] == true){
      setLoading(false);
      String token = result.data['data']['token'];
      print(token);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      if(await prefs.getBool("userDataBool") == true){
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesName.HOME_SCREEN_ROUTE);
      }else {
        setLoading(false);
        Navigator.pushReplacementNamed(context, RoutesName.USER_INFO_SCREEN_ROUTE);
      }
    } else if (result.data['status'] == "False") {
      setLoading(false);
      // TODO show error message to user
    }
  }

  Future<void> verifyUser (String otp, BuildContext context) async{
    setLoading(true);
    Map<String,dynamic> data = {
      'otp' : otp
    };
    var result = await _authRepository.verifyUser(data);

    if(result.data['status'] == true){
      setLoading(false);
      Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
    }else if(result.data['status'] == "False"){
      setLoading(false);
      // TODO show error to user
    }

  }

  Future<void> verifyForgotOtp (String otp, BuildContext context) async{
    setLoading(true);
    Map<String,dynamic> data = {
      'otp' : otp
    };
    var result = await _authRepository.verifyForgotOtp(data);

    if(result.data['status'] == true){
      setLoading(false);
      Navigator.pushReplacementNamed(context, RoutesName.RESET_PASSWORD_SCREEN_ROUTE);
    }else if(result.data['status'] == "False"){
      setLoading(false);
      // TODO show error to user
    }

  }

  Future<void> sendVerifiactionMail(String email, BuildContext context) async{

    Map<String,dynamic> data = {
      'email' : email
    };
    var result = await _authRepository.sendForgotPasswordOTP(data);

    if(result.data['status'] == true){
      Navigator.pushReplacementNamed(context, RoutesName.VERIFY_USER_SCREEN_ROUTE, arguments: VerifyUserScreen(true));
    }else if(result.data['status'] == "False"){
      // TODO show error message to user
    }
  }

  Future<void> resetPasswordUser(String email, String password, BuildContext context) async{
    setLoading(true);
    Map<String,dynamic> data = {
      "email": email,
      "password": password
    };
    var result = await _authRepository.resetPassword(data);

    if(result.data['status'] == true){
      setLoading(false);
      Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
    }else if(result.data['status'] == "False") {
      setLoading(false);
      // TODO show error message to user
    }

  }

  Future<void> saveUserInfo(BuildContext context) async{
    setLoading(true);
    var userData = UserData(
      name: nameController.text,
      phoneNumber: phoneNoController.text,
      profilePhoto: await MultipartFile.fromFile(_temp_image!.path),
      accountCreatedDate: DateTime.now().toString(),
      email: emailLoginController.text,
      customerReview: "",
      totalOrders: 0,
      customerRating: 0.0
    );

    FormData formData = userData.toFormData();
    var result = await _userInfoRepository.saveUserInfo(formData);
    print(result.data);
    if(result.data['status'] == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('userDataBool', true);
      setLoading(false);
      Navigator.pushReplacementNamed(context, RoutesName.HOME_SCREEN_ROUTE);
    }else if (result.data['status'] == "False"){
      setLoading(false);
      // TODO show error message to user
      print("status : ${result.data['status']}");
    }
  }

  Future<UserModel> getUserInfo() async{
    var response = await _userInfoRepository.getUserInfo();
    if(response != null){
      if(response.data['status'] == true){
        var userModel = UserModel.fromJson(response.data);
        setUserName(userModel.userData!.name!);
        return userModel;
      }else if(response.data['status'] == "False"){
        // TODO show error message to user
      }
    }
    return UserModel();
  }

  Future<void> updateUserInfo(BuildContext context) async{
    setLoading(true);
    var userData = UserData(
      name: nameController.text,
      phoneNumber: phoneNoController.text,
      profilePhoto: await MultipartFile.fromFile(_temp_image!.path),
      accountCreatedDate: DateTime.now().toString(),
      email: emailLoginController.text,
    );

    FormData formData = userData.toFormData();
    var result = await _userInfoRepository.updateUserInfo(formData);
    print(result.data);
    if(result.data['status'] == true) {
      setLoading(false);
      Navigator.pop(context);
    }else if (result.data['status'] == "False"){
      setLoading(false);
      // TODO show error message to user
      print("status : ${result.data['status']}");
    }
  }

  Future<void> deleteUserInfo(BuildContext context) async{
    var response = await _userInfoRepository.deleteUserInfo();
    if(response != null){
      if(response.statusCode == 204){
        SharedPreferences preferences = await SharedPreferences
            .getInstance();
        await preferences.remove('token');
        emailLoginController.text = "";
        passwordLoginController.text = "";
        Navigator.popAndPushNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
      }else if(response.data['status'] == "False"){
        // TODO show error message to user
      }
    }
  }


  File? _temp_image;
  get temp_image => _temp_image;

  void setImagetemp(File temp_image) {
    _temp_image = temp_image;
    notifyListeners();
  }
}