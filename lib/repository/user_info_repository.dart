import 'package:dio/dio.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class UserInfoRepository {

  NetworkApiService _apiServices = NetworkApiService();

  Future<Response> saveUserInfo(dynamic data) async{

    try {
      Response response = await _apiServices.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint, data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> getUserInfo() async {

    try{
      Response response = await _apiServices.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> updateUserInfo(dynamic data) async {

    try{
      Response response = await _apiServices.getPatchApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint,
        data
      );
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> deleteUserInfo() async {

    try{
      Response response = await _apiServices.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

}