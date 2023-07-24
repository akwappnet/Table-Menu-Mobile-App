import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/utils/constants/api_endpoints.dart';

class OrderRepository {
  final BaseApiService _apiService = NetworkApiService();

  placeOrder(dynamic data) {
    try {
      return _apiService.getPostApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint, data);
    }  catch (e) {
      rethrow;
    }
  }

  getOrders() {
    try {
      return _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint);
    } catch (e) {
      rethrow;
    }
  }

  cancelOrder(int id, dynamic data) {
    try {
      return _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.cancelOrderEndPoint}$id/",
          data);
    }  catch (e) {
      rethrow;
    }
  }

  trackOrderByID(int id) {
    try {
      return _apiService.getGetApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.orderEndPoint}$id/");
    }  catch (e) {
      rethrow;
    }
  }

  changePaymentStatus(int id){
    var data = {};
    try {
      return _apiService.getPatchApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.orderEndPoint}$id/paid/",data);
    } catch (e) {
      rethrow;
    }
  }


  feedback(dynamic data,int id) {
    try {
      return _apiService.getPostApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.orderEndPoint.orderEndPoint}$id/feedback/", data);
    } catch (e) {
      rethrow;
    }
  }

}
