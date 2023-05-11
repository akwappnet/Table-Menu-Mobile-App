import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRProvider extends ChangeNotifier {

  int _table_number = 1;
  bool _show_menu = false;
  int get table_number => _table_number;
  bool get show_menu => _show_menu;


  getDataFromQR(String data) async {
    final json_data = json.decode(data);
    _table_number = json_data['table_no'];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('show_menu', true);
    _show_menu = (await prefs.getBool('show_menu'))!;
    notifyListeners();
  }

}