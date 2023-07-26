// Function to show error messages using Flushbar
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/utils/widgets/custom_flushbar_widget.dart';
import 'package:table_menu_customer/view_model/auth_provider.dart';

void showErrorFlushbar(BuildContext context, String message) {
  CustomFlushbar.showError(context, message,onDismissed: () {});
}

// Function to handle DioExceptions and show error messages
void handleDioException(BuildContext context, dynamic exception) {
  if (exception.type == DioExceptionType.connectionTimeout ||
      exception.type == DioExceptionType.receiveTimeout ||
      exception.type == DioExceptionType.sendTimeout) {
    showErrorFlushbar(context, "Connection timeout. Please try again later.");
  } else if (exception.type == DioExceptionType.badResponse) {
    // Handle HTTP error response statuses
    if (exception.response?.statusCode == 401) {
      showErrorFlushbar(context, "Unauthorized. Please log in again.");
      Provider.of<AuthProvider>(context,listen: false).logout(context);
      // Handle other status codes as needed
    } else {
      showErrorFlushbar(
          context, "An error occurred. Please try again later.");
    }
  } else {
    showErrorFlushbar(context, "An error occurred. Please try again later.");
  }
}

// Function to handle generic exceptions and show error messages
void handleGenericException(BuildContext context, dynamic exception) {
  log("Generic Exception: $exception");
  showErrorFlushbar(context, "An error occurred. Please try again later.");
}

// app context global key

class AppContext {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}


// check internet connectivity

