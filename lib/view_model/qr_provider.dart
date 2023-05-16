import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRProvider extends ChangeNotifier {

  int _table_number = 1;

  int get table_number => _table_number;


  getDataFromQR(String data) async {
    final json_data = json.decode(data);
    _table_number = json_data['table_no'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('qr_scanned', json_data['show_menu']);
    notifyListeners();
  }

}