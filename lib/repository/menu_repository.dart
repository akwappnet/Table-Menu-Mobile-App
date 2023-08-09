import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';

import '../utils/services/api_endpoints.dart';

class MenuRepository {
  final BaseApiService _apiService = NetworkApiService();

  getCategories() async {
    try {
      return await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.categoryEndPoint);
    } catch (e) {
      rethrow;
    }
  }

  getMenuItems(String category_name) async {
    var queryParams = {'query': category_name};
    try {
      return await _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.filterEndPoint,
          queryParams);
    } catch (e) {
      rethrow;
    }
  }

  filterMenuItems(String query) async {
    var queryParams = {'query': query};
    try {
      return await _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.menuItemEndPoint,
          queryParams);
    } catch (e) {
      rethrow;
    }
  }

  getMenuItemByID(int id) async {
    try {
      return await _apiService.getGetApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.menuEndPoint.menuItemEndPoint}$id/");
    } catch (e) {
      rethrow;
    }
  }

  // for add menu items to favorites
  addToFavoriteMenuItem(int id) async {
    var data = {};
    try {
      return await _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.menuEndPoint.menuItemEndPoint}$id/",
          data);
    } catch (e) {
      rethrow;
    }
  }
}
