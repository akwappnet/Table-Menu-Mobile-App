import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/data/app_exceptions.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';

class CartRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<Response> addToCart(dynamic data, BuildContext context) async {
    try {
      Response response = await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint, data);
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  Future<Response> getCartItems(BuildContext context) async {
    try {
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint);
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  Future<Response> updateCartItem(dynamic data, int id, BuildContext context) async {
    try {
      Response response = await _apiService.getPatchApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint + "$id/",
          data);
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  Future<Response> deleteCartItem(int id,BuildContext context) async {
    try {
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint + "$id/");
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }
}
