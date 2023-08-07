import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = const Locale('en', 'US');

  Locale get appLocal => _appLocale;
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('en', 'US');
      return null;
    }
    _appLocale = Locale(prefs.getString('language_code')!,prefs.getString('countryCode'));
    return null;
  }


  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ar","")) {
      _appLocale = const Locale("ar","");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
      notifyListeners();
    } else {
      _appLocale = const Locale("en","US");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
      notifyListeners();
    }
  }

}