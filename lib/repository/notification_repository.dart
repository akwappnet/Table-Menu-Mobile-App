
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
    } catch (e) {
      rethrow;
    }
  }

  // delete notification

  deleteSingleNotification(int id) {
    try {
      return _apiService.getDeleteApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.notificationEndPoint.notificationEndPoint}$id/"
      );
    } catch (e) {
      rethrow;
    }
  }


  // delete all notification

   deleteAllNotification() {
    try {
      return _apiService.getDeleteApiResponse(
          ApiEndPoint.baseUrl +
              ApiEndPoint.notificationEndPoint.notificationEndPoint
      );
    } catch (e) {
      rethrow;
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
    } catch (e) {
      rethrow;
    }
  }
}