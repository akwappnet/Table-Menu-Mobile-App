import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/model/notification_model.dart';
import 'package:table_menu_customer/repository/notification_repository.dart';

class NotificationProvider extends ChangeNotifier{

  NotificationRepository notificationRepository = NotificationRepository();

  List<NotificationData> notificationList = [];

  // get list of notification

  Future<List<NotificationData>> getAllNotification() async{
      var response = await notificationRepository.getNotifications();
        if (response.statusCode == 200) {
          var getNotification = NotificationModel.fromJson(response.data);
          if (getNotification.notificationData!.isNotEmpty) {
            var addedIds = Set<int>();
            notificationList.clear();
            notificationList.addAll(getNotification.notificationData!);
            log("categoryList:${notificationList.length}");
            for (var data in getNotification.notificationData!) {
              // Check if category already exists
              if (!addedIds.contains(data.id)) {
                // categoryList.add(GetCategory(data: [data]));
                addedIds.add(data.id!); // Add categoryId to Set
              }
            }

            return notificationList;
          }
        } else {}
    // Return an empty list if there was an error
    return [];
  }

  // delete notification

  Future<CustomResultModel?> deleteSingleNotification(int id) async{
    var response = await notificationRepository.deleteSingleNotification(id);

      if (response.data["status"] == true) {
        notificationList.removeWhere((item) => item.id == id);
        notifyListeners();
        return CustomResultModel(status: true, message: response.data["message"]);
      } else if (response.data['status'] == false) {
        return CustomResultModel(status: false, message: response.data["message"]);
      }
      return CustomResultModel(status: false, message: "An error occurred");
  }

  // delete all notification

  Future<CustomResultModel?> deleteAllNotification() async{
    var response = await notificationRepository.deleteAllNotification();
      if (response.data["status"] == true) {
        notificationList.clear();
        getAllNotification();
        notifyListeners();
        return CustomResultModel(status: true, message: response.data["message"]);
      } else if (response.data['status'] == false) {
        return CustomResultModel(status: false, message: response.data["message"]);
      }
      return CustomResultModel(status: false, message: "An error occurred");
  }

  // mark as read notification
  Future<CustomResultModel?> markAsReadNotification(int id) async{
    var response = await notificationRepository.markAsReadNotification(id);
      if (response.data["status"] == true) {
        getAllNotification();
        return CustomResultModel(status: true, message: response.data["message"]);
      } else if (response.data['status'] == false) {
        return CustomResultModel(status: false, message: response.data["message"]);
      }
      return CustomResultModel(status: false, message: "An error occurred");
  }
}