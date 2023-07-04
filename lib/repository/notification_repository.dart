import 'package:dio/dio.dart';

import '../data/app_exceptions.dart';
import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../res/services/api_endpoints.dart';

class NotificationRepository {

  final BaseApiService _apiService = NetworkApiService();

  // get list of notification

  Future<Response> getNotifications() async {
    try {
      Response response = await _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationEndPoint);
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  // delete notification

  Future<Response> deleteSingleNotification(int id) async {
    try {
      Response response = await _apiService.getDeleteApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.notificationEndPoint.notificationEndPoint}$id/"
      );
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }


  // delete all notification

  Future<Response> deleteAllNotification() async {
    try {
      Response response = await _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationEndPoint
      );
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  // mark as read notification

  Future<Response> markAsReadNotification(int id) async {
    try {
      var data = {};
      Response response = await _apiService.getPutApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.notificationEndPoint.notificationEndPoint}$id/",
        data
      );
      return response;
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }
}