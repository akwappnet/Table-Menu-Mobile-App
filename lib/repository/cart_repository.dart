import 'package:dio/dio.dart';
import 'package:table_menu_customer/data/app_exceptions.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';

class CartRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<Response> addToCart(dynamic data) async {
    try {
      Response response = await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint, data);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> getCartItems() async {
    try {
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> updateCartItem(dynamic data, int id) async {
    try {
      Response response = await _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.cartEndPoint.cartEndPoint}$id/",
          data);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> deleteCartItem(int id) async {
    try {
      Response response = await _apiService.getDeleteApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.cartEndPoint.cartEndPoint}$id/");
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  // clear all cart items

  Future<Response> deleteAllCartItem() async {
    try {
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint);
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
