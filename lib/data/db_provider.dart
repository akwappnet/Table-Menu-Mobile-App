
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = '';

  String _verifyToken = '';

  String get token => _token;

  String get verifyToken => _verifyToken;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('token', token);
  }

  void saveVerifyToken(String token) async {
    SharedPreferences value = await _pref;

    value.setString('verify_pass_token', token);
  }

  Future<String> getVerifyToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('verify_pass_token')) {
      String data = value.getString('verify_pass_token')!;
      _verifyToken = data;
      notifyListeners();
      return data;
    } else {
      _verifyToken = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  void clear() async {
    final value = await _pref;
    value.clear();
  }
}
