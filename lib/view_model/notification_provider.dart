import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/model/notification_model.dart';
import 'package:table_menu_customer/repository/notification_repository.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/view_model/nav_provider.dart';

import '../app_localizations.dart';
import '../utils/helpers.dart';
import '../utils/widgets/custom_flushbar_widget.dart';

class NotificationProvider extends ChangeNotifier{

  NotificationRepository notificationRepository = NotificationRepository();

  List<NotificationData> notificationList = [];

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // get list of notification

  getAllNotification(BuildContext context) {
    notificationRepository.getNotifications().then((response) {
      setLoading(true);
      if(response != null) {
        if (response.statusCode == 200) {
            NotificationModel notificationModel = NotificationModel.fromJson(response.data);
            notificationList = notificationModel.notificationData!;
            setLoading(false);
            notifyListeners();
        } else {
          setLoading(false);
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          notifyListeners();
        }
      }else {
        setLoading(false);
        CustomFlushbar.showError(context, AppLocalizations.of(context).translate('error_occurred_error_message'),onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  // delete notification

  deleteSingleNotification(int id,BuildContext context) {
    notificationRepository.deleteSingleNotification(id).then((response) {
      if(response != null) {
        if (response.data["status"] == true) {
          notificationList.removeWhere((item) => item.id == id);
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {});
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, AppLocalizations.of(context).translate('error_occurred_error_message'),onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // delete all notification

  deleteAllNotification(BuildContext context) {
    notificationRepository.deleteAllNotification().then((response) {
      if(response != null) {
        if (response.data["status"] == true) {
          notificationList.clear();
          getAllNotification(context);
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {});
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, AppLocalizations.of(context).translate('error_occurred_error_message'),onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // mark as read notification
  markAsReadNotification(int id,BuildContext context) {
    notificationRepository.markAsReadNotification(id).then((response) {
      if(response != null) {
        if (response.data["status"] == true) {
          getAllNotification(context);
          CustomFlushbar.showSuccess(context, response.data["message"],onDismissed: () {
            Provider.of<NavProvider>(context,listen: false).changeIndex(2);
            Navigator.popAndPushNamed(context, RoutesName.HOME_SCREEN_ROUTE);
          });
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(context, response.data["message"],onDismissed: () {});
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, AppLocalizations.of(context).translate('error_occurred_error_message'),onDismissed: () {});
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }
}
