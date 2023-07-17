import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/model/notification_model.dart';
import 'package:table_menu_customer/repository/notification_repository.dart';

import '../utils/widgets/custom_flushbar_widget.dart';

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

  deleteSingleNotification(int id,BuildContext context) {
    notificationRepository.deleteSingleNotification(id).then((response) {
      if(response != null) {
        if (response.data["status"] == true) {
          notificationList.removeWhere((item) => item.id == id);
          CustomFlushbar.showSuccess(context, response.data["message"]);
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred");
        notifyListeners();
      }
    });
  }

  // delete all notification

  deleteAllNotification(BuildContext context) {
    notificationRepository.deleteAllNotification().then((response) {
      print(response.data);
      if(response != null) {
        if (response.data["status"] == true) {
          notificationList.clear();
          getAllNotification();
          CustomFlushbar.showSuccess(context, response.data["message"]);
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred");
        notifyListeners();
      }
    });
  }

  // mark as read notification
  markAsReadNotification(int id,BuildContext context) {
    notificationRepository.markAsReadNotification(id).then((response) {
      if(response != null) {
        if (response.data["status"] == true) {
          getAllNotification();
          CustomFlushbar.showSuccess(context, response.data["message"]);
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred");
        notifyListeners();
      }
    });
  }
}
