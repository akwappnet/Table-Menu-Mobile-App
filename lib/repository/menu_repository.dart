import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';

import '../data/app_exceptions.dart';
import '../res/services/api_endpoints.dart';
import '../utils/routes/routes_name.dart';


class MenuRepository {

  BaseApiService _apiService = NetworkApiService();

  Future<Response> getCategories([BuildContext? context]) async {

    try{
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.categoryEndPoint
      );
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        if(context != null){
          Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        }
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  Future<Response> getMenuItems(String category_name, [BuildContext? context]) async {

    try{
      Response response = await _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.filterEndPoint,
        category_name
      );
      // print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        if(context != null){
          Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        }
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  // Future<bool> isLoadedMenu() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? value = prefs.getBool('qr_scanned') ?? false;
  //   return value != null;
  // }

}