import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class AuthRepository {

  final BaseApiService _apiService = NetworkApiService();

  Future<Response> loginUser(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.login, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> registrationUser(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.registrarion, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyUser(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.verifyUser, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyForgotOtp(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.verifyForgotOtp, jsonEncode(data));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> sendForgotPasswordOTP(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.sendForgotOtp, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> resetPassword(dynamic data,String verifyToken) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.resetPassword, data,verifyToken: verifyToken);
      return response;
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