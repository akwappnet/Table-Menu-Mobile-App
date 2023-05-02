

class MenuItemModel {

  final String? createdAt;
  final String? menuId;
  final String? menuImage;
  final String? menuName;
  final String? menuCateory;
  final String? menuIngredients;
  final int? menuPrice;
  final String? menuDescription;
  final bool? isEnableNew;
  final bool? isEnableVeg;
  final bool? isEnableNonVeg;
  final bool? isEnableSpicy;
  final bool? isEnableJain;
  final bool? isEnableSpecial;
  final bool? isEnableSweet;
  final bool? isEnablePopular;


  MenuItemModel({
    this.createdAt,
    this.menuId,
    this.menuImage,
    this.menuName,
    this.menuCateory,
    this.menuIngredients,
    this.menuPrice,
    this.menuDescription,
    this.isEnableNew,
    this.isEnableVeg,
    this.isEnableNonVeg,
    this.isEnableSpicy,
    this.isEnableJain,
    this.isEnableSpecial,
    this.isEnableSweet,
    this.isEnablePopular
  });


  Map<String, dynamic> toMap() {
    return {
      'createdAt' : createdAt,
      'menu_id': menuId,
      'menu_image' : menuImage,
      'menu_name': menuName,
      'menu_category': menuCateory,
      'menu_ingredients': menuIngredients,
      'menu_price': menuPrice,
      'menu_description': menuDescription,
      'is_new': isEnableNew,
      'is_veg': isEnableVeg,
      'is_nonveg': isEnableNonVeg,
      'is_spicy': isEnableSpicy,
      'is_jain': isEnableJain,
      'is_special': isEnableSpecial,
      'is_sweet': isEnableSweet,
      'is_popular': isEnablePopular
    };
  }


  MenuItemModel.fromFirestore(Map<String, dynamic> firestore)
      : createdAt = firestore['createdAt'],
        menuId = firestore['menu_id'],
        menuImage = firestore['menu_image'],
        menuName = firestore['menu_name'],
        menuCateory = firestore['menu_category'],
        menuIngredients = firestore['menu_ingredients'],
        menuPrice = firestore['menu_price'],
        menuDescription = firestore['menu_description'],
        isEnableNew = firestore['is_new'],
        isEnableVeg = firestore['is_veg'],
        isEnableNonVeg = firestore['is_nonveg'],
        isEnableSpicy = firestore['is_spicy'],
        isEnableJain = firestore['is_jain'],
        isEnableSpecial = firestore['is_special'],
        isEnableSweet = firestore['is_sweet'],
        isEnablePopular = firestore['is_popular'];
}


