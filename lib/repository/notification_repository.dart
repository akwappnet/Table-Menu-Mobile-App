import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../utils/services/api_endpoints.dart';

class NotificationRepository {
  final BaseApiService _apiService = NetworkApiService();

  // get list of notification

  getNotifications() async {
    try {
      return await _apiService.getGetApiResponse(ApiEndPoint.baseUrl +
          ApiEndPoint.notificationEndPoint.notificationEndPoint);
    } catch (e) {
      rethrow;
    }
  }

  // delete notification

  deleteSingleNotification(int id) async {
    try {
      return await _apiService.getDeleteApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.notificationEndPoint.notificationEndPoint}$id/");
    } catch (e) {
      rethrow;
    }
  }

  // delete all notification

  deleteAllNotification() async {
    try {
      return await _apiService.getDeleteApiResponse(ApiEndPoint.baseUrl +
          ApiEndPoint.notificationEndPoint.notificationEndPoint);
    } catch (e) {
      rethrow;
    }
  }

  // mark as read notification

  markAsReadNotification(int id) async {
    try {
      var data = {};
      return await _apiService.getPutApiResponse(
          "${ApiEndPoint.baseUrl}${ApiEndPoint.notificationEndPoint.notificationEndPoint}$id/",
          data);
    } catch (e) {
      rethrow;
    }
  }
}
