import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/model/notification_model.dart';
import 'package:table_menu_customer/repository/notification_repository.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';

class NotificationProvider extends ChangeNotifier{

  NotificationRepository notificationRepository = NotificationRepository();

  List<NotificationData> notificationList = [];

  // get list of notification

  Future<List<NotificationData>> getAllNotification(BuildContext context) async{
    if(context != null){
      var response = await notificationRepository.getNotifications(context);
      if (response != null) {
        if (response.statusCode == 200) {
          var result = response.data;
          print(result);

          var getNotification = NotificationModel.fromJson(response.data);
          print(getNotification.notificationData![0].title);
          if (getNotification.notificationData!.isNotEmpty) {
            var addedIds = Set<int>();
            notificationList.clear();
            notificationList.addAll(getNotification.notificationData!);
            log("categoryList:${notificationList.length}");
            getNotification.notificationData!.forEach((data) {
              // Check if category already exists
              if (!addedIds.contains(data.id)) {
                // categoryList.add(GetCategory(data: [data]));
                addedIds.add(data.id!); // Add categoryId to Set
              }
            });

            print('###$notificationList');
            return notificationList;
          }
        } else {}
      }
    }
    // Return an empty list if there was an error
    return [];
  }

  // delete notification

  Future<void> deleteSingleNotification(int id, BuildContext context) async{
    var response = await notificationRepository.deleteSingleNotification(id,context);
    if (response != null) {
      if (response.statusCode == 204) {
        getAllNotification(context);
        CustomFlushbar.showSuccess(context, response.data['message']);
        notifyListeners();
      } else if (response.data['status'] == false) {
        CustomFlushbar.showError(context, response.data['message']);
        notifyListeners();
      }
    }
  }

  // delete all notification

  Future<void> deleteAllNotification(BuildContext context) async{
    var response = await notificationRepository.deleteAllNotification(context);
    if (response != null) {
      if (response.statusCode == 204) {
        getAllNotification(context);
        CustomFlushbar.showSuccess(context, response.data['message']);
        notifyListeners();
      } else if (response.data['status'] == false) {
        CustomFlushbar.showError(context, response.data['message']);
        notifyListeners();
      }
    }
  }
}