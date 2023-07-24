import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../utils/constants/api_endpoints.dart';

class UserInfoRepository {

  final BaseApiService _apiService = NetworkApiService();

  saveUserInfo(dynamic data) {

    try {
      return _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint, data);
    } catch (e) {
      rethrow;
    }
  }

  getUserInfo() {
    try{
      return _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
    } catch (e) {
      rethrow;
    }
  }

  updateUserInfo(dynamic data) {
    try{
      return _apiService.getPatchApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint,
        data
      );
    } catch (e) {
      rethrow;
    }
  }

  deleteUserInfo() {
    try{
      return _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.userInfoEndPoint.userInfoEndpoint
      );
    }  catch (e) {
      rethrow;
    }
  }

}