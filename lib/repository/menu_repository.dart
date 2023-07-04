import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/data/network/base_api_service.dart';
import 'package:table_menu_customer/data/network/network_api_service.dart';

import '../data/app_exceptions.dart';
import '../res/services/api_endpoints.dart';
import '../utils/routes/routes_name.dart';


class MenuRepository {

  final BaseApiService _apiService = NetworkApiService();

  Future<Response> getCategories([BuildContext? context]) async {

    try{
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.categoryEndPoint
      );
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        if(context != null){
          Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        }
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> getMenuItems(String category_name, [BuildContext? context]) async {

    try{
      Response response = await _apiService.getGetApiResponseWithParams(
          ApiEndPoint.baseUrl + ApiEndPoint.menuEndPoint.filterEndPoint,
        category_name
      );
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        if(context != null){
          Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        }
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }
}