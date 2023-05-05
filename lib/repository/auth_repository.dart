import 'package:dio/dio.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class AuthRepository {

  NetworkApiService _apiServices = NetworkApiService();



  Future<Response> loginUser(dynamic data) async {
    try {
      Response response = await _apiServices.getAuthApiResponse(
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
      Response response = await _apiServices.getAuthApiResponse(
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
      Response response = await _apiServices.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.verifyUser, data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> sendForgotPasswordOTP(dynamic data) async {
    try {
      Response response = await _apiServices.getAuthApiResponse(
      ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.sendForgotOtp, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> resetPassword(dynamic data) async {
    try {
      Response response = await _apiServices.getAuthApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.authEndPoints.resetPassword, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}