import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRProvider extends ChangeNotifier {

  int _table_number = 1;

  int get table_number => _table_number;

  bool _show_menu = false;

  bool _isVisible = false;

  bool get isVisible => _isVisible;


  getDataFromQR(String data) {
    final json_data = json.decode(data);
    _table_number = json_data['table_no'];
    _show_menu = json_data['show_menu'];
    setVisibilityOfMenu(_show_menu);
    notifyListeners();
  }

  setVisibilityOfMenu(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('qr_scanned', value);
  }

  getVisibilityOfMenu() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isVisible = prefs.getBool("qr_scanned") ?? false;
  }
}