import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../utils/services/api_endpoints.dart';

class UserInfoRepository {
  final BaseApiService _apiService = NetworkApiService();

  saveUserInfo(dynamic data) async {
    try {
      return await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint,
          data);
    } catch (e) {
      rethrow;
    }
  }

  getUserInfo() async {
    try {
      return await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint);
    } catch (e) {
      rethrow;
    }
  }

  updateUserInfo(dynamic data) async {
    try {
      return await _apiService.getPatchApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint,
          data);
    } catch (e) {
      rethrow;
    }
  }

  deleteUserInfo() async {
    try {
      return await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint);
    } catch (e) {
      rethrow;
    }
  }
}
