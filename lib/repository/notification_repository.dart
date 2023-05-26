import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../data/app_exceptions.dart';
import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';
import '../utils/routes/routes_name.dart';

class NotificationRepository {

  BaseApiService _apiService = NetworkApiService();

  // get list of notification

  Future<Response> getNotifications(BuildContext context) async {
    try {
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationEndPoint);
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

  // delete notification

  Future<Response> deleteSingleNotification(int id,
      BuildContext context) async {
    try {
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationEndPoint+"$id/"
      );
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }


  // delete all notification

  Future<Response> deleteAllNotification(BuildContext context) async {
    try {
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationDeleteAllEndPoint
      );
      print(response);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        Navigator.pushReplacementNamed(context, RoutesName.LOGIN_SCREEN_ROUTE);
        throw UnauthorisedException;
      } else {
        throw error;
      }
    }
  }

}



