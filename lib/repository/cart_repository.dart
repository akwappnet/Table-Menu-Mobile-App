import 'package:dio/dio.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';

class CartRepository {

  BaseApiService _apiService = NetworkApiService();

  Future<Response> addToCart(dynamic data) async{

    try{
      Response response = await _apiService.getPostApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint,
        data
      );
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> getCartItems() async {
    try{
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint
      );
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> updateCartItem(dynamic data, int id) async {

    try {
      Response response = await _apiService.getPatchApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint + "$id/",
          data
      );
      print(response);
      return response;
    }catch (e) {
      throw e;
    }
  }


  Future<Response> deleteCartItem(int id) async {

    try {
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.cartEndPoint.cartEndPoint + "$id/"
      );
      print(response);
      return response;
    }catch (e) {
      throw e;
    }
  }
}