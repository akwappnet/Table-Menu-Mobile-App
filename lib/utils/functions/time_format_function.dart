import 'package:intl/intl.dart';

String getTimeAgo(String dateString, {bool numericDates = true}) {
  // Parse the input date string to UTC DateTime
  DateTime date = DateTime.parse(dateString);

  // Convert the date to local timezone
  DateTime localDate = date.toLocal();
  DateTime now = DateTime.now();

  Duration difference = now.difference(localDate);

  if (difference.inSeconds < 5) {
    return 'Just now';
  } else if (difference.inSeconds <= 60) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes <= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inMinutes <= 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours <= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inHours <= 24) {
    return '${difference.inHours} hours ago';
  } else if (difference.inDays <= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inDays <= 6) {
    return '${difference.inDays} days ago';
  } else if ((difference.inDays / 7).ceil() <= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if ((difference.inDays / 7).ceil() <= 4) {
    return '${(difference.inDays / 7).ceil()} weeks ago';
  } else if ((difference.inDays / 30).ceil() <= 1) {
    return (numericDates) ? '1 month ago' : 'Last month';
  } else if ((difference.inDays / 30).ceil() <= 30) {
    return '${(difference.inDays / 30).ceil()} months ago';
  } else if ((difference.inDays / 365).ceil() <= 1) {
    return (numericDates) ? '1 year ago' : 'Last year';
  }
  return '${(difference.inDays / 365).floor()} years ago';
}


// date time format for orders listing page's order
String formatDateTime(DateTime date) {
  // Convert the date to local timezone
  DateTime localDateTime = date.toLocal();

  // Format the time in 12-hour format with AM/PM
  String formattedTime = DateFormat.jm().format(localDateTime);

  // Check if the date is today
  DateTime now = DateTime.now();
  if (localDateTime.year == now.year && localDateTime.month == now.month && localDateTime.day == now.day) {
    return 'Today at $formattedTime';
  } else {
    // Format the date in the desired format "May 15, 2023"
    String formattedDate = DateFormat.yMMMMd().format(localDateTime);
    return '$formattedDate at $formattedTime';
  }
}