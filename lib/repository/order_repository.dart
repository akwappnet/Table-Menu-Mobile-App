import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';

import '../data/app_exceptions.dart';
import '../utils/routes/routes_name.dart';

class OrderRepository {
  BaseApiService _apiService = NetworkApiService();

  Future<Response> placeOrder(dynamic data, BuildContext context) async {
    try {
      Response response = await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint, data);
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

  Future<Response> getOrders(BuildContext context) async {
    try {
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint);
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

  Future<Response> cancelOrder(int id, dynamic data, BuildContext context) async {
    try {
      Response response = await _apiService.getPatchApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.orderEndPoint.cancelOrderEndPoint +
              "$id/",
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
}
