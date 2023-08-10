import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  String _token = '';

  String _verifyToken = '';

  String _deviceId = '';

  String get token => _token;

  String get verifyToken => _verifyToken;

  String get deviceId => _deviceId;

  Future<void> saveDeviceId(String deviceId) async {
    SharedPreferences prefs = await _pref;
    prefs.setString('device_id', deviceId);
    _deviceId = deviceId;
    notifyListeners();
  }

  Future<String> getSavedDeviceId() async {
    SharedPreferences prefs = await _pref;
    String? deviceId = prefs.getString('device_id');
    if (deviceId != null) {
      _deviceId = deviceId;
      notifyListeners();
      return deviceId;
    }
    return '';
  }

  Future<String> getDeviceId() async {
    if (_deviceId.isNotEmpty) {
      return _deviceId;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _deviceId = iosInfo.identifierForVendor!;
    }
    notifyListeners();
    return _deviceId;
  }

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
