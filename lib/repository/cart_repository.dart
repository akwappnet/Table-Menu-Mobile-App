import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/utils/services/api_endpoints.dart';

class CartRepository {
  final BaseApiService _apiService = NetworkApiService();

  addToCart(dynamic data) async {
    try {
      return await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint, data);
    } catch (e) {
      rethrow;
    }
  }

  getCartItems() async {
    try {
      return await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint);
    } catch (e) {
      rethrow;
    }
  }

  updateCartItem(dynamic data, int id) async {
    try {
      return await _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.cartEndPoint.cartEndPoint}$id/",
          data);
    } catch (e) {
      rethrow;
    }
  }

  deleteCartItem(int id) async {
    try {
      return await _apiService.getDeleteApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.cartEndPoint.cartEndPoint}$id/");
    } catch (e) {
      rethrow;
    }
  }

  // clear all cart items

  deleteAllCartItem() async {
    try {
      return await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint);
    } catch (e) {
      rethrow;
    }
  }
}
