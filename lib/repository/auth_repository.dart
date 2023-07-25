import 'dart:convert';

import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/view_model/db_provider.dart';
import '../data/network/network_api_service.dart';
import '../utils/constants/api_endpoints.dart';

class AuthRepository {

  final BaseApiService apiService = NetworkApiService();

  loginUser(dynamic data) {
    try {
      return apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.login, data);
    } catch (e) {
      rethrow;
    }
  }

  registrationUser(dynamic data) {
    try {
      return apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.registrarion, data);
    } catch (e) {
      rethrow;
    }
  }

  verifyUser(dynamic data) {
    try {
      return apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.verifyUser, data);
    } catch (e) {
      rethrow;
    }
  }

  verifyForgotOtp(dynamic data) {
    try {
      return apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.verifyForgotOtp, jsonEncode(data));
    } catch (e) {
      rethrow;
    }
  }

  sendForgotPasswordOTP(dynamic data) {
    try {
      return apiService.getAuthApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.sendForgotOtp, data);
    } catch (e) {
      rethrow;
    }
  }

  resetPassword(dynamic data,String verifyToken) {
    try {
      return apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.resetPassword, data,verifyToken: verifyToken);
    } catch (e) {
      rethrow;
    }
  }

  pushNotificationToggle(){
    var data = {};
    try {
      return apiService.getPutApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.notificationEndPoint.pushNotificationEndPoint,
        data
      );
    } catch (e) {
      rethrow;
    }
  }


  Future<String> isLoggedIn() async {
    String? token = await DatabaseProvider().getToken();
    return token;
  }

}