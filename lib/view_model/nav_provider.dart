import 'package:flutter/cupertino.dart';

class NavProvider extends ChangeNotifier {

  int _index = 0;


  int get index => _index;

  void changeIndex(int value) {
    _index = value;
    notifyListeners();
  }

}