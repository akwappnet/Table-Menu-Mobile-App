import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';

import '../utils/constants/api_endpoints.dart';

class MenuRepository {
  final BaseApiService _apiService = NetworkApiService();

  getCategories() {
    try {
      return _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.categoryEndPoint);
    }catch (e) {
      rethrow;
    }
  }

  getMenuItems(String category_name) {
    var queryParams = {'query': category_name};
    try {
      return _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.filterEndPoint,
          queryParams);
    } catch (e) {
      rethrow;
    }
  }

  getMenuItemByID(int id) {
    try {
      return _apiService.getGetApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.menuEndPoint.menuItemEndPoint}$id/");
    } catch (e) {
      rethrow;
    }
  }

  // for add menu items to favorites
  addToFavoriteMenuItem(int id) {
    var data = {};
    try {
      return _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.menuEndPoint.menuItemEndPoint}$id/",
          data);
    } catch (e) {
      rethrow;
    }
  }
}
