import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:table_menu_customer/repository/menu_repository.dart';


import '../model/category_model.dart';
import '../model/custom_result_model.dart';
import '../model/menuItem_model.dart';
import '../utils/widgets/custom_flushbar_widget.dart';


class MenuProvider extends ChangeNotifier {

  int isSelectedIndex = -1;
  String categoryName = "";
  List<CategoryData> categories = [];
  List<MenuData> menuitems = [];
  bool favToggle = false;

  bool toogleBoolean = false;

  toggleBool(){
    toogleBoolean = !toogleBoolean;
    notifyListeners();
  }


  SfRangeValues values = const SfRangeValues(500, 1000);

  updateRangeValues(SfRangeValues value){
    values = value;
    notifyListeners();
  }


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