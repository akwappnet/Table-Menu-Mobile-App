import 'package:dio/dio.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';

import '../data/app_exceptions.dart';

class OrderRepository {
  final BaseApiService _apiService = NetworkApiService();

  Future<Response> placeOrder(dynamic data) async {
    try {
      Response response = await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint, data);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> getOrders() async {
    try {
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> cancelOrder(int id, dynamic data) async {
    try {
      Response response = await _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.cancelOrderEndPoint}$id/",
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
}
