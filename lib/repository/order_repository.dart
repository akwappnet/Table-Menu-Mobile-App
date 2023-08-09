import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/utils/services/api_endpoints.dart';

class OrderRepository {
  final BaseApiService _apiService = NetworkApiService();

  placeOrder(dynamic data) async {
    try {
      return await _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint, data);
    } catch (e) {
      rethrow;
    }
  }

  getOrders() async {
    try {
      return await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint);
    } catch (e) {
      rethrow;
    }
  }

  cancelOrder(int id, dynamic data) async {
    try {
      return await _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.cancelOrderEndPoint}$id/",
          data);
    } catch (e) {
      rethrow;
    }
  }

  trackOrderByID(int id) async {
    try {
      return await _apiService.getGetApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.orderEndPoint}$id/");
    } catch (e) {
      rethrow;
    }
  }

  changePaymentStatus(int id) async {
    var data = {};
    try {
      return await _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.orderEndPoint}$id/paid/",
          data);
    } catch (e) {
      rethrow;
    }
  }

  feedback(dynamic data, int id) async {
    try {
      return await _apiService.getPostApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.orderEndPoint}$id/feedback/",
          data);
    } catch (e) {
      rethrow;
    }
  }

  // order history

  getOrderHistory() async {
    var queryParams = {'order_history': true};
    try {
      return await _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint,
          queryParams);
    } catch (e) {
      rethrow;
    }
  }
}
