import 'dart:convert';

import 'package:flutter/cupertino.dart';

class QRProvider extends ChangeNotifier {

  int _table_number = 1;
  bool _show_menu = false;
  int get table_number => _table_number;
  bool get show_menu => _show_menu;


  getDataFromQR(String data) {
    final json_data = json.decode(data);
    _table_number = json_data['table_no'];
    _show_menu = json_data['show_menu'];
    notifyListeners();
  }

}