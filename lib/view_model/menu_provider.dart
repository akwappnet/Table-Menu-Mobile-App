import 'package:flutter/cupertino.dart';

class MenuProvider extends ChangeNotifier {


  int isSelectedIndex = 0;
  String categoryName = "";

  void selectCategory(int index){
    isSelectedIndex = index;
    notifyListeners();
  }

  void setCategoryName(String value){
    categoryName = value;
    notifyListeners();
  }


}