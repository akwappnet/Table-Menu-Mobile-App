import 'package:dio/dio.dart';
import '../data/app_exceptions.dart';
import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class UserInfoRepository {

  final BaseApiService _apiService = NetworkApiService();

  Future<Response> saveUserInfo(dynamic data) async{

    try {
      Response response = await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint, data);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> getUserInfo() async {

    try{
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> updateUserInfo(dynamic data) async {

    try{
      Response response = await _apiService.getPatchApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint,
        data
      );
      return response;
    }catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> deleteUserInfo() async {

    try{
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

}