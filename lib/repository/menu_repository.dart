import 'package:dio/dio.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';

import '../res/services/api_endpoints.dart';


class MenuRepository {

  BaseApiService _apiService = NetworkApiService();

  Future<Response> getCategories() async {

    try{
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.categoryEndPoint
      );
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> getMenuItems() async {

    try{
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.menuItemEndPoint
      );
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }


}