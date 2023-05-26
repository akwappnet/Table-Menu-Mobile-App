import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../data/app_exceptions.dart';
import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';
import '../utils/routes/routes_name.dart';

class UserInfoRepository {

  final BaseApiService _apiService = NetworkApiService();

  Future<Response> saveUserInfo(dynamic data, BuildContext context) async{

    try {
      Response response = await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint, data);
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  Future<Response> getUserInfo(BuildContext context) async {

    try{
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  Future<Response> updateUserInfo(dynamic data, BuildContext context) async {

    try{
      Response response = await _apiService.getPatchApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint,
        data
      );
      print(response);
      return response;
    }catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  Future<Response> deleteUserInfo(BuildContext context) async {

    try{
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

}