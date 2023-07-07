import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
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

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null;
  }

}