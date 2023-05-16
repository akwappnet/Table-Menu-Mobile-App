import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<Response> getMenuItems(String category_name) async {

    try{
      Response response = await _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.filterEndPoint,
        category_name
      );
      // print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

  // Future<bool> isLoadedMenu() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? value = prefs.getBool('qr_scanned') ?? false;
  //   return value != null;
  // }

}