import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/repository/menu_repository.dart';

import '../model/category_model.dart';
import '../model/menuItem_model.dart';

class MenuProvider extends ChangeNotifier {



  int isSelectedIndex = 0;
  String categoryName = "";
  List<Data> _categories = [];

  List<Data> get categories => _categories;
  List<MenuData> _menuitems = [];

  List<MenuData> get menuitems => _menuitems;


  final MenuRepository menuRepository = MenuRepository();

  void selectCategory(int index){
    isSelectedIndex = index;
    notifyListeners();
  }

  void setCategoryName(String value){
    categoryName = value;
    notifyListeners();
  }


  // get request for categories

  Future<List<Data>> getCategories() async {
    var response = await menuRepository.getCategories();
    if (response != null) {
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);

        var getCategory = CategoryModel.fromJson(response.data);
        print(getCategory.data![0].categoryName);
        if (getCategory.data!.isNotEmpty) {
          var addedIds = Set<int>();
          _categories.clear();
          _categories.addAll(getCategory.data!);
          log("categoryList:${_categories.length}");
          getCategory.data!.forEach((data) {
            // Check if category already exists
            if (!addedIds.contains(data.categoryId)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.categoryId!); // Add categoryId to Set
            }
          });

          print('###$_categories');
          return _categories;
        }
      } else {}
    }
    // Return an empty list if there was an error
    return [];
  }


  // get request for menu items

  Future<List<MenuData>> getMenuItems() async {
    var response = await menuRepository.getMenuItems();
    if (response != null) {
      if (response.statusCode == 200) {
        var result = response.data;
        //print(result);

        var getMenuItem = MenuItemModel.fromJson(response.data);

        if (getMenuItem.menuData!.isNotEmpty) {
          var addedIds = Set<int>();
          _menuitems.clear();
          _menuitems.addAll(getMenuItem.menuData!);
          getMenuItem.menuData!.forEach((data) {
            // Check if category already exists
            if (!addedIds.contains(data.id)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.id!); // Add categoryId to Set
            }
          });

          print('###$_menuitems');
          return _menuitems;
        }
      } else {}
    }
    // Return an empty list if there was an error
    return [];
  }


}