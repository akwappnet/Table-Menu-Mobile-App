// Function to show error messages using Flushbar
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

import '../app_localizations.dart';

void showErrorFlushbar(BuildContext context, String message) {
  CustomFlushbar.showError(context, message,onDismissed: () {});
}

// Function to handle DioExceptions and show error messages
void handleDioException(BuildContext context, dynamic exception) {
  if (exception.type == DioExceptionType.connectionTimeout ||
      exception.type == DioExceptionType.receiveTimeout ||
      exception.type == DioExceptionType.sendTimeout) {
    showErrorFlushbar(context, AppLocalizations.of(context).translate('connection_timeout_error_message'));
  } else if (exception.type == DioExceptionType.badResponse) {
    // Handle HTTP error response statuses
    if (exception.response?.statusCode == 401) {
      showErrorFlushbar(context, AppLocalizations.of(context).translate('unauthorized_error_message'));
      Provider.of<AuthProvider>(context,listen: false).logout(context);
      // Handle other status codes as needed
    } else {
      showErrorFlushbar(
          context, AppLocalizations.of(context).translate('error_occurred_try_again_error_message'));
    }
  } else {
    showErrorFlushbar(context, AppLocalizations.of(context).translate('error_occurred_try_again_error_message'));
  }
}

// Function to handle generic exceptions and show error messages
void handleGenericException(BuildContext context, dynamic exception) {
  log("Generic Exception: $exception");
  showErrorFlushbar(context, AppLocalizations.of(context).translate('error_occurred_try_again_error_message'));
}

// app context global key

class AppContext {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}


// check internet connectivity

