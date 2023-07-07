import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/model/auth_model.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/model/user_model.dart';
import 'package:table_menu_customer/repository/user_info_repository.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import '../repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final UserInfoRepository _userInfoRepository = UserInfoRepository();

  // login controllers
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  // register controllers
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController passwordRegisterController =
  TextEditingController();
  final TextEditingController repeatePasswordRegisterController =
  TextEditingController();

  // verify user Controller
  final TextEditingController activationOTPController = TextEditingController();

  // forgot password Controller
  final TextEditingController forgotPassEmailController =
  TextEditingController();
  final TextEditingController forgotPassOTPController = TextEditingController();
  final TextEditingController resetPassController = TextEditingController();
  final TextEditingController resetrepeatPassController =
  TextEditingController();

  // user info controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;

  UserData? _userData;

  UserData? get userData => _userData;

  String _user_name = "";

  String get user_name => _user_name;

  void setUserName(String value) {
    _user_name = value;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  loadValues(UserData userData) {
    nameController.text = userData.name!;
    phoneNoController.text = userData.phoneNumber!;
  }

  Future<CustomResultModel?> userRegisteration(dynamic data) async {
    setLoading(true);
    var result = await _authRepository.registrationUser(data);
    log(result.statusCode.toString());
    log(result.statusMessage.toString());
    if (result.data["status"] == true) {
      setLoading(false);
      return CustomResultModel(status: true, message: result.data['message']);
    } else if (result.data['status'] == "False") {
      setLoading(false);
      return CustomResultModel(status: false, message: result.data['message']);
    }
    setLoading(false);
     // return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<CustomResultModel?> userLogin(String email, String password) async {
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
      } else if (Platform.isLinux) {
        deviceType = 'Linux';
      } else if (Platform.isMacOS) {
        deviceType = 'MacOS';
      } else if (Platform.isWindows) {
        deviceType = 'Windows';
      } else if (Platform.isFuchsia) {
        deviceType = 'Fuchsia';
      } else {
        deviceType = '';
      }
    }
    var data = AuthModel(
        email: email,
        password: password,
        deviceType: deviceType,
        fcmToken: fcmToken);

    var result = await _authRepository.loginUser(data.toJson());
    if (result.data['status'] == true) {
      setLoading(false);
      String token = result.data['data']['token'];
      bool userinfo = result.data['data']['user_info_exists'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      if (userinfo) {
        setLoading(false);
        return CustomResultModel(
            status: true, message: result.data['message'], optionalBool: true);
      } else {
        setLoading(false);
        return CustomResultModel(
            status: true, message: result.data['message'], optionalBool: false);
      }
    } else if (result.data['status'] == "False") {
      setLoading(false);
      return CustomResultModel(status: false, message: result.data['message']);
    }
    setLoading(false);
    return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<CustomResultModel?> verifyUser(String otp,String email) async {
    setLoading(true);
    Map<String, dynamic> data = {
      "email": email,
      "otp": otp
    };
    var result = await _authRepository.verifyUser(data);

    if (result.data['status'] == true) {
      setLoading(false);
      return CustomResultModel(status: true, message: result.data['message']);
    } else if (result.data['status'] == "False") {
      setLoading(false);
      return CustomResultModel(status: false, message: result.data['message']);
    }
    setLoading(false);
    return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<CustomResultModel?> verifyForgotOtp(String otp, String email) async {
    setLoading(true);
    Map<String, dynamic> data = {
      "email": email,
      "otp": otp
    };
    var result = await _authRepository.verifyForgotOtp(data);
    log(result.data.toString());
    if (result.data['status'] == true) {
      String verifyPasswordToken = result.data['data']['token'];
      log("verify token : $verifyPasswordToken");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('verify_pass_token', verifyPasswordToken);
      setLoading(false);
      return CustomResultModel(status: true, message: result.data["message"]);
    } else if (result.data['status'] == false) {
      setLoading(false);
      return CustomResultModel(status: false, message: result.data["message"]);
    }
    setLoading(false);
    return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<CustomResultModel?> sendVerifiactionMail(String email) async {
    Map<String, dynamic> data = {'email': email};
    var result = await _authRepository.sendForgotPasswordOTP(data);

    if (result.data['status'] == true) {
      return CustomResultModel(status: true, message: result.data["message"]);
    } else if (result.data['status'] == "False") {
      return CustomResultModel(status: false, message: result.data["message"]);
    }
    return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<CustomResultModel?> resetPasswordUser(String email,
      String password) async {
    setLoading(true);
    Map<String, dynamic> data = {"email": email, "password": password};
    final prefs = await SharedPreferences.getInstance();
    final verifyToken = prefs.getString('verify_pass_token');
    log("verify token : $verifyToken");
    log("${data.toString()}");
    var result = await _authRepository.resetPassword(data,verifyToken!);

    if (result.data['status'] == true) {
      setLoading(false);
      return CustomResultModel(status: true, message: result.data["message"]);
    } else if (result.data['status'] == "False") {
      setLoading(false);
      return CustomResultModel(status: false, message: result.data["message"]);
    }
    setLoading(false);
    return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<CustomResultModel?> saveUserInfo(BuildContext context) async {
    setLoading(true);
    var userData = UserData(
        name: nameController.text,
        phoneNumber: phoneNoController.text,
        profilePhoto: await MultipartFile.fromFile(_temp_image!.path),
        accountCreatedDate: DateTime.now().toString(),
        email: emailLoginController.text,
        customerReview: "",
        totalOrders: 0,
        customerRating: 0.0);

    FormData formData = userData.toFormData();
    var result = await _userInfoRepository.saveUserInfo(formData);

    if (result.data['status'] == true) {
      setLoading(false);
      return CustomResultModel(status: true, message: result.data["message"]);
    } else if (result.data['status'] == "False") {
      setLoading(false);
      return CustomResultModel(status: false, message: result.data["message"]);
    }
    setLoading(false);
    return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<UserModel> getUserInfo(BuildContext context) async {
    var response = await _userInfoRepository.getUserInfo();
    if (response.data['status'] == true) {
      var userModel = UserModel.fromJson(response.data);
      setUserName(userModel.userData!.name!);
      return userModel;
    } else if (response.data['status'] == "False") {
      CustomFlushbar.showError(context, response.data['message']);
    }
    return UserModel();
  }

  Future<CustomResultModel?> updateUserInfo(BuildContext context) async {
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

    if (result.data['status'] == true) {
      setLoading(false);
      return CustomResultModel(status: true, message: result.data["message"]);
    } else if (result.data['status'] == "False") {
      setLoading(false);
      return CustomResultModel(status: false, message: result.data["message"]);
    }
    setLoading(false);
    return CustomResultModel(status: false, message: "An error occurred");
  }

  Future<CustomResultModel?> deleteUserInfo(BuildContext context) async {
    var response = await _userInfoRepository.deleteUserInfo();

    if (response.data["status"] == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('token');
      emailLoginController.text = "";
      passwordLoginController.text = "";
      return CustomResultModel(status: true, message: response.data["message"]);
    } else if (response.data['status'] == "False") {
      return CustomResultModel(
          status: false, message: response.data["message"]);
    }
    return CustomResultModel(status: false, message: "An error occurred");
  }

  File? _temp_image;

  get temp_image => _temp_image;

  void setImagetemp(File temp_image) {
    _temp_image = temp_image;
    notifyListeners();
  }

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    repeatePasswordRegisterController.dispose();
    activationOTPController.dispose();
    forgotPassEmailController.dispose();
    forgotPassOTPController.dispose();
    resetPassController.dispose();
    resetrepeatPassController.dispose();
    nameController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  clearToken() async {
    SharedPreferences preferences =
        await SharedPreferences.getInstance();
    await preferences.remove('token');
    await preferences.remove('verify_pass_token');
  }

  void logout(BuildContext context) {
    clearToken();
    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.LOGIN_SCREEN_ROUTE,
          (route) => false, // Clear the entire backstack
    );
  }

}