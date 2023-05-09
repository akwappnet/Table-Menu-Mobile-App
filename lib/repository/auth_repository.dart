import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class AuthRepository {

  BaseApiService _apiService = NetworkApiService();

  Future<Response> loginUser(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.login, data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> registrationUser(dynamic data) async {
    try {
      print(data);
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.registrarion, data);
      print("response $response");
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Response> verifyUser(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.verifyUser, data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> verifyForgotOtp(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.verifyForgotOtp, jsonEncode(data));
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> sendForgotPasswordOTP(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.sendForgotOtp, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> resetPassword(dynamic data) async {
    try {
      Response response = await _apiService.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.resetPassword, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null;
  }

}