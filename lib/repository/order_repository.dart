import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/utils/constants/api_endpoints.dart';

import '../data/app_exceptions.dart';

class OrderRepository {
  final BaseApiService _apiService = NetworkApiService();

  placeOrder(dynamic data) {
    try {
      return _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint, data);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  getOrders() {
    try {
      return _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  cancelOrder(int id, dynamic data) {
    try {
      return _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.cancelOrderEndPoint}$id/",
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
