import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  bool _isInternetAvailable = true;

  bool get isInternetAvailable => _isInternetAvailable;

  ConnectivityProvider() {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _isInternetAvailable = false;
        notifyListeners();
      } else {
        _isInternetAvailable = true;
        notifyListeners();
      }
    });
  }
}
