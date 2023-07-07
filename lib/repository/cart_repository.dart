import 'package:table_menu_customer/data/app_exceptions.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/utils/constants/api_endpoints.dart';

class CartRepository {
  final BaseApiService _apiService = NetworkApiService();

  addToCart(dynamic data) {
    try {
      return _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint, data);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  getCartItems() {
    try {
      return _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  updateCartItem(dynamic data, int id) {
    try {
      return _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.cartEndPoint.cartEndPoint}$id/",
          data);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  deleteCartItem(int id) {
    try {
      return _apiService.getDeleteApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.cartEndPoint.cartEndPoint}$id/");
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  // clear all cart items

  deleteAllCartItem() {
    try {
      return _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }
}
