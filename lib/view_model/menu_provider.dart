import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:table_menu_customer/repository/menu_repository.dart';

import '../model/category_model.dart';
import '../model/menuItem_model.dart';
import '../utils/helpers.dart';
import '../utils/widgets/custom_flushbar_widget.dart';


class MenuProvider extends ChangeNotifier {

  int isSelectedIndex = -1;
  String categoryName = "";
  List<CategoryData> categories = [];
  List<MenuData> menuitems = [];
  List<MenuData> favMenuitems = [];
  bool favToggle = false;
  SfRangeValues values = const SfRangeValues(500, 1000);

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  FilterOptions filterOptions = FilterOptions();

  // toggle all filters and sort

  void toggleNewFilter() {
    filterOptions.isNew = !filterOptions.isNew;
    notifyListeners();
  }

  void togglePopularFilter() {
    filterOptions.isPopular = !filterOptions.isPopular;
    notifyListeners();
  }

  void toggleSpecialFilter() {
    filterOptions.isSpecial = !filterOptions.isSpecial;
    notifyListeners();
  }

  void toggleVegFilter() {
    filterOptions.isVeg = !filterOptions.isVeg;
    notifyListeners();
  }

  void toggleNonVegFilter() {
    filterOptions.isNonVeg = !filterOptions.isNonVeg;
    notifyListeners();
  }

  void toggleSweetFilter() {
    filterOptions.isSweet = !filterOptions.isSweet;
    notifyListeners();
  }

  void toggleSpicyFilter() {
    filterOptions.isSpicy = !filterOptions.isSpicy;
    notifyListeners();
  }

  void toggleRatingFilter(int rating) {
    filterOptions.selectedRatings[rating - 1] = !filterOptions.selectedRatings[rating - 1];
    notifyListeners();
  }

  void toggleSortByPriceHighToLow() {
    filterOptions.sortByPriceHighToLow = !filterOptions.sortByPriceHighToLow;
    notifyListeners();
  }

  void toggleSortByPriceLowToHigh() {
    filterOptions.sortByPriceLowToHigh = !filterOptions.sortByPriceLowToHigh;
    notifyListeners();
  }


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
    getMenuItems(categoryName: categoryName,context: context);
    notifyListeners();
  }

  String _generateFilterQuery() {
    List<String> filters = [];
    if (filterOptions.isNew) filters.add('menu_item_types=new');
    if (filterOptions.isPopular) filters.add('menu_item_types=popular');
    if (filterOptions.isSpecial) filters.add('menu_item_types=special');
    if (filterOptions.isVeg) filters.add('menu_item_types=veg');
    if (filterOptions.isNonVeg) filters.add('menu_item_types=non_veg');
    if (filterOptions.isSweet) filters.add('menu_item_types=sweet');
    if (filterOptions.isSpicy) filters.add('menu_item_types=spicy');

    if (filterOptions.selectedRatings.isNotEmpty) {
      String ratingFilter = 'menu_item_ratings=${filterOptions.selectedRatings.join(',')}';
      filters.add(ratingFilter);
    }

    if (filterOptions.sortByPriceHighToLow) filters.add('sort_by_price=high_to_low');
    if (filterOptions.sortByPriceLowToHigh) filters.add('sort_by_price=low_to_high');

    return filters.join(',');
  }


  // get request for categories

  getCategories(BuildContext context) {
    setLoading(true);
    menuRepository.getCategories().then((response){
      if(response != null) {
        if(response.statusCode == 200) {
          setLoading(false);
          CategoryModel categoryModel = CategoryModel.fromJson(response.data);
          categories = categoryModel.data!;
          notifyListeners();
        }else {
          setLoading(false);
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        setLoading(false);
        CustomFlushbar.showError(context, "Something went wrong");
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }
  MenuData singleMenuData = MenuData();

  // get request for menu items
  getMenuItems({required String categoryName,required BuildContext context, bool? fillterFavorites}) {
    menuRepository.getMenuItems(categoryName).then((response){
      setLoading(true);
      if(response != null) {
        if(response.statusCode == 200) {
          MenuItemModel menuItemModel = MenuItemModel.fromJson(response.data);
          menuitems = menuItemModel.menuData!;
          favMenuitems = menuItemModel.menuData!;
          if(fillterFavorites == true){
            favMenuitems = favMenuitems
                .where((menuitem) =>
            menuitem.isFavorite == true)
                .toList();
            setLoading(false);
            notifyListeners();
          }
          setLoading(false);
          notifyListeners();
        }else {
          CustomFlushbar.showError(context, response.data["message"]);
          setLoading(false);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "Something went wrong");
        setLoading(false);
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      setLoading(false);
    });
  }

  // add menu items to favorites api call

  addToFavoritesMenuItem(int id,BuildContext context){
    menuRepository.addToFavoriteMenuItem(id).then((response) {
      if(response != null){
        if(response.statusCode == 200){
          getMenuItemByID(id, context);
          notifyListeners();
        }else {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "Something went wrong");
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  MenuItem? menuItem;
  getMenuItemByID(int id,BuildContext context){
    setLoading(true);
    menuRepository.getMenuItemByID(id).then((response){
      if(response != null) {
        if(response.statusCode == 200) {
          setLoading(false);
          SingleMenuItem singleMenuItem = SingleMenuItem.fromJson(response.data);
          menuItem = singleMenuItem.menuItem;
          favToggle = menuItem!.isFavorite!;
          notifyListeners();
        }else {
          setLoading(false);
          notifyListeners();
        }
      }else {
        setLoading(false);
        notifyListeners();
      }
    });
  }

  void applyFilters() {
    String query = _generateFilterQuery();
    log("query -> $query");
    // Call the API with the query parameter
    // Add your API call logic here using Dio package with the generated query
  }

}

class FilterOptions {
  bool isNew = false;
  bool isPopular = false;
  bool isSpecial = false;
  bool isVeg = false;
  bool isNonVeg = false;
  bool isSweet = false;
  bool isSpicy = false;
  List<bool> selectedRatings = [false, false, false, false, false];
  bool sortByPriceHighToLow = false;
  bool sortByPriceLowToHigh = false;
}
