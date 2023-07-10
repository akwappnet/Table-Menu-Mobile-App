import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/repository/menu_repository.dart';
import 'package:table_menu_customer/utils/routes/routes_name.dart';
import 'package:table_menu_customer/utils/widgets/custom_snack_bar.dart';

import '../model/category_model.dart';
import '../model/custom_result_model.dart';
import '../model/menuItem_model.dart';
import '../utils/widgets/custom_flushbar_widget.dart';
import 'cart_provider.dart';

class MenuProvider extends ChangeNotifier {

  int isSelectedIndex = -1;
  String categoryName = "";
  List<CategoryData> categories = [];
  List<MenuData> menuitems = [];
  bool favToggle = false;


  MenuRepository menuRepository = MenuRepository();

  void selectCategory(int index){
    isSelectedIndex = index;
    notifyListeners();
  }

  void toggleFavorite(){
    favToggle = !favToggle;
    notifyListeners();
  }

  void setCategoryName(String value,BuildContext context){
    categoryName = value;
    getMenuItems(categoryName,context);
    notifyListeners();
  }

  // get request for categories

  getCategories(BuildContext context) {
    menuRepository.getCategories().then((response){
      if(response != null) {
        if(response.statusCode == 200) {
          CategoryModel categoryModel = CategoryModel.fromJson(response.data);
          categories = categoryModel.data!;
          notifyListeners();
        }else {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "Something went wrong");
        notifyListeners();
      }
    });
  }

  // get request for menu items
  getMenuItems(String category_name,BuildContext context) {
    menuRepository.getMenuItems(category_name).then((response){
      if(response != null) {
        if(response.statusCode == 200) {
          MenuItemModel menuItemModel = MenuItemModel.fromJson(response.data);
          menuitems = menuItemModel.menuData!;
          notifyListeners();
        }else {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "Something went wrong");
        notifyListeners();
      }
    });
  }
}