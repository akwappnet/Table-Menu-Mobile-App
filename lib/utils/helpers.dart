

import 'package:shared_preferences/shared_preferences.dart';

getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token;
}
