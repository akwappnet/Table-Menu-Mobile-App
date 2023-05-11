

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';
import 'package:table_menu_customer/res/services/api_endpoints.dart';

class OrderRepository {

  BaseApiService _apiService = NetworkApiService();


  Future<Response> placeOrder(dynamic data) async {

    try {
      Response response = await _apiService.getPostApiResponse(
        ApiEndPoint.baseUrl + ApiEndPoint.orderEndPoint.orderEndPoint,
        data
      );
      print(response);
      return response;
    }catch (e) {
      throw e;
    }

  }


}