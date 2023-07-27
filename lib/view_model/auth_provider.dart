import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:table_menu_customer/model/auth_model.dart';
import 'package:table_menu_customer/model/user_model.dart';
import 'package:table_menu_customer/repository/user_info_repository.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/data/db_provider.dart';
import '../repository/auth_repository.dart';
import '../utils/helpers.dart';

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

  UserData? userData;


  String _user_name = "";

  String get user_name => _user_name;

  bool boolPushNotification = false;

togglePushNotification(BuildContext context) {
  boolPushNotification = !boolPushNotification;
  togglePushNotificationApi(context);
  notifyListeners();
}

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

  userRegisteration(dynamic data,BuildContext context) {
    _authRepository.registrationUser(data).then((response) {
      setLoading(true);
      if(response != null) {
        if (response.data["status"] == true) {
          setLoading(false);
          CustomFlushbar.showSuccess(context, response.data['message'],onDismissed: () {
            Navigator.pushReplacementNamed(
                context, RoutesName.VERIFY_USER_SCREEN_ROUTE, arguments: false);
          });
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data['message'],onDismissed: (){});
          setLoading(false);
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: (){});
        setLoading(false);
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  userLogin(String email, String password,BuildContext context) async {
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

    _authRepository.loginUser(data.toJson()).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          setLoading(false);
          String token = response.data['data']['token'];
          bool userinfo = response.data['data']['user_info_exists'];
          DatabaseProvider().saveToken(token);

          if (userinfo) {
            setLoading(false);
            CustomFlushbar.showSuccess(
                context, response.data['message'],onDismissed: () {
              Navigator.pushReplacementNamed(context,
                  RoutesName.HOME_SCREEN_ROUTE);
            });
          } else {
            setLoading(false);
            CustomFlushbar.showSuccess(
                context, response.data['message'],onDismissed: (){
              Navigator.pushReplacementNamed(
                  context,
                  RoutesName.USER_INFO_SCREEN_ROUTE,arguments: null);
            });
          }
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(
              context, response.data['message'],onDismissed: (){});
          setLoading(false);
        }
      }else {
        CustomFlushbar.showError(
            context, "An error occurred",onDismissed: (){});
        setLoading(false);
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  verifyUser(String otp,String email,BuildContext context) {
    setLoading(true);
    Map<String, dynamic> data = {
      "email": email,
      "otp": otp
    };

    _authRepository.verifyUser(data).then((response) {
      if(response != null){
        if (response.data['status'] == true) {
          setLoading(false);
          CustomFlushbar.showSuccess(context, response.data['message'],onDismissed: (){
            Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
          });
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data['message'],onDismissed: () {});
          setLoading(false);
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: () {});
        setLoading(false);
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  verifyForgotOtp(String otp, String email,BuildContext context) {
    setLoading(true);
    Map<String, dynamic> data = {
      "email": email,
      "otp": otp
    };

    _authRepository.verifyForgotOtp(data).then((response) {
      if(response != null){
        log(response.data.toString());
        if (response.data['status'] == true) {
          String verifyPasswordToken = response.data['data']['token'];
          log("verify token : $verifyPasswordToken");
          DatabaseProvider().saveVerifyToken(verifyPasswordToken);
          setLoading(false);
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {
            Navigator.pushReplacementNamed(
                context, RoutesName.RESET_PASSWORD_SCREEN_ROUTE);
          });
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          setLoading(false);
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: () {});
        setLoading(false);
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }


  sendVerifiactionMail(String email,BuildContext context) {
    Map<String, dynamic> data = {'email': email};

    _authRepository.sendForgotPasswordOTP(data).then((response) {
      if(response != null){
        if (response.data['status'] == true) {
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {
            Navigator.pushReplacementNamed(
                context, RoutesName.VERIFY_USER_SCREEN_ROUTE,
                arguments: true);
          });
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: () {});
      }
    }).catchError((error) {
      handleDioException(context, error);
    });
  }

  resetPasswordUser(String email,String password,BuildContext context) async{
    setLoading(true);
    Map<String, dynamic> data = {"email": email, "password": password};
    final verifyToken = await DatabaseProvider().getVerifyToken();
    log("verify token : $verifyToken");
    log(data.toString());

    _authRepository.resetPassword(data,verifyToken).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          setLoading(false);
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {
            Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
          });
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"], onDismissed: () {});
          setLoading(false);
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred", onDismissed: () {});
        setLoading(false);
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  saveUserInfo(BuildContext context) async {
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

    await _userInfoRepository.saveUserInfo(formData).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          setLoading(false);
          clearController();
          CustomFlushbar.showSuccess(context, response.data["message"], onDismissed: () {
            Navigator.pushReplacementNamed(context, RoutesName.HOME_SCREEN_ROUTE);
          });
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          setLoading(false);
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: () {});
        setLoading(false);
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  getUserInfo(BuildContext context)  {
    _userInfoRepository.getUserInfo().then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          var userModel = UserModel.fromJson(response.data);
          userData = userModel.userData;
          setUserName(userModel.userData!.name!);
          notifyListeners();
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data['message'],onDismissed: () {});
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  updateUserInfo(BuildContext context) async {
    setLoading(true);
    var userData = UserData(
      name: nameController.text,
      phoneNumber: phoneNoController.text,
      profilePhoto: await MultipartFile.fromFile(_temp_image!.path),
      accountCreatedDate: DateTime.now().toString(),
      email: emailLoginController.text,
    );

    FormData formData = userData.toFormData();
    await _userInfoRepository.updateUserInfo(formData).then((response) {
      if(response != null){
        if (response.data['status'] == true) {
          setLoading(false);
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {
            Navigator.of(context).pop();
          });
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          setLoading(false);
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: () {});
        setLoading(false);
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  deleteUserInfo(BuildContext context) {
    _userInfoRepository.deleteUserInfo().then((response) {
      if(response != null){
        if (response.data["status"] == true) {
          DatabaseProvider().clear();
          clearController();
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.LOGIN_SCREEN_ROUTE,
                  (route) => false, // Clear the entire backstack
            );
          });
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred",onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }


  togglePushNotificationApi(BuildContext context)  {
    _authRepository.pushNotificationToggle().then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          notifyListeners();
        } else if (response.data['status'] == "False") {
          notifyListeners();
        }
      }else {
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  File? _temp_image;

  get temp_image => _temp_image;

  void setImagetemp(File temp_image) {
    _temp_image = temp_image;
    notifyListeners();
  }

  clearController() {
    emailLoginController.clear();
    passwordLoginController.clear();
    emailRegisterController.clear();
    passwordRegisterController.clear();
    repeatePasswordRegisterController.clear();
    activationOTPController.clear();
    forgotPassEmailController.clear();
    forgotPassOTPController.clear();
    resetPassController.clear();
    resetrepeatPassController.clear();
    nameController.clear();
    phoneNoController.clear();
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

  void logout(BuildContext context) {
    DatabaseProvider().clear();
    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.LOGIN_SCREEN_ROUTE,
          (route) => false, // Clear the entire backstack
    );
  }

}
