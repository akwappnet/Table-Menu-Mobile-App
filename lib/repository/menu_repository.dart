import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';

import '../data/app_exceptions.dart';
import '../utils/constants/api_endpoints.dart';

class MenuRepository {
  final BaseApiService _apiService = NetworkApiService();

  getCategories() {
    try {
      return _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.categoryEndPoint);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  getMenuItems(String category_name) {
    try {
      return _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.filterEndPoint,
          category_name);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  // for add menu items to favorites
  addToFavoriteMenuItem(int id) {
    var data = {};
    try {
      return _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.menuEndPoint.menuItemEndPoint}$id/",
          data);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }


}
