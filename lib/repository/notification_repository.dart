import '../data/app_exceptions.dart';
import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../utils/constants/api_endpoints.dart';

class NotificationRepository {

  final BaseApiService _apiService = NetworkApiService();

  // get list of notification

  getNotifications() {
    try {
      return _apiService.getGetApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationEndPoint);
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  // delete notification

  deleteSingleNotification(int id) {
    try {
      return _apiService.getDeleteApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.notificationEndPoint.notificationEndPoint}$id/"
      );
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }


  // delete all notification

   deleteAllNotification() {
    try {
      return _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationEndPoint
      );
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }

  // mark as read notification

  markAsReadNotification(int id) {
    try {
      var data = {};
      return _apiService.getPutApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.notificationEndPoint.notificationEndPoint}$id/",
        data
      );
    } catch (error) {
      if (error is UnauthorisedException) {
        throw UnauthorisedException;
      } else {
        rethrow;
      }
    }
  }
}