import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../app_localizations.dart';
import '../helpers.dart';

String getTimeAgo(String dateString, {bool numericDates = true}) {
  BuildContext? context = AppContext.navigatorKey.currentContext;
  // Parse the input date string to UTC DateTime
  DateTime date = DateTime.parse(dateString);

  // Convert the date to local timezone
  DateTime localDate = date.toLocal();
  DateTime now = DateTime.now();

  Duration difference = now.difference(localDate);

  if (difference.inSeconds < 5) {
    return AppLocalizations.of(context!).translate('just_now');
  } else if (difference.inSeconds <= 60) {
    return '${difference.inSeconds} ${AppLocalizations.of(context!).translate('seconds_ago')}';
  } else if (difference.inMinutes <= 1) {
    return (numericDates) ? AppLocalizations.of(context!).translate('1_minute_ago') : AppLocalizations.of(context!).translate('a_minute_ago');
  } else if (difference.inMinutes <= 60) {
    return '${difference.inMinutes} ${AppLocalizations.of(context!).translate('minutes_ago')}';
  } else if (difference.inHours <= 1) {
    return (numericDates) ? AppLocalizations.of(context!).translate('1_hour_ago') : AppLocalizations.of(context!).translate('an_hour_ago');
  } else if (difference.inHours <= 24) {
    return '${difference.inHours} ${AppLocalizations.of(context!).translate('hours_ago')}';
  } else if (difference.inDays <= 1) {
    return (numericDates) ? AppLocalizations.of(context!).translate('hours_ago') : AppLocalizations.of(context!).translate('yesterday');
  } else if (difference.inDays <= 6) {
    return '${difference.inDays} ${AppLocalizations.of(context!).translate('days_ago')}';
  } else if ((difference.inDays / 7).ceil() <= 1) {
    return (numericDates) ? AppLocalizations.of(context!).translate('1_week_ago') : AppLocalizations.of(context!).translate('last_week');
  } else if ((difference.inDays / 7).ceil() <= 4) {
    return '${(difference.inDays / 7).ceil()} ${AppLocalizations.of(context!).translate('weeks_ago')}';
  } else if ((difference.inDays / 30).ceil() <= 1) {
    return (numericDates) ? AppLocalizations.of(context!).translate('1_month_ago') : AppLocalizations.of(context!).translate('last_month');
  } else if ((difference.inDays / 30).ceil() <= 30) {
    return '${(difference.inDays / 30).ceil()} ${AppLocalizations.of(context!).translate('months_ago')}';
  } else if ((difference.inDays / 365).ceil() <= 1) {
    return (numericDates) ? AppLocalizations.of(context!).translate('1_year_ago') : AppLocalizations.of(context!).translate('last_year');
  }
  return '${(difference.inDays / 365).floor()} ${AppLocalizations.of(context!).translate('years_ago')}';
}


// date time format for orders listing page's order
String formatDateTime(DateTime date) {
  BuildContext? context = AppContext.navigatorKey.currentContext;
  // Convert the date to local timezone
  DateTime localDateTime = date.toLocal();

  // Format the time in 12-hour format with AM/PM
  String formattedTime = DateFormat.jm().format(localDateTime);

  // Check if the date is today
  DateTime now = DateTime.now();
  if (localDateTime.year == now.year && localDateTime.month == now.month && localDateTime.day == now.day) {
    return '${AppLocalizations.of(context!).translate('today_at')} $formattedTime';
  } else {
    // Format the date in the desired format "May 15, 2023"
    String formattedDate = DateFormat.yMMMMd().format(localDateTime);
    return '$formattedDate ${AppLocalizations.of(context!).translate('at')} $formattedTime';
  }
}