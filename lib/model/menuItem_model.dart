

class MenuItemModel {
  bool? status;
  String? message;
  List<MenuData>? menuData;

  MenuItemModel({this.status, this.message, this.menuData});

  MenuItemModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      menuData = <MenuData>[];
      json['data'].forEach((v) {
        menuData!.add(MenuData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (menuData != null) {
      data['data'] = menuData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuData {
  int? id;
  String? categoryName;
  bool? isFavorite;
  String? name;
  String? ingredients;
  String? price;
  String? description;
  String? image;
  bool? isNew;
  bool? isVeg;
  bool? isNonVeg;
  bool? isSpicy;
  bool? isJain;
  bool? isSpecial;
  bool? isSweet;
  bool? isPopular;
  String? rating;
  int? rated;
  int? duration;
  int? categoryId;

  MenuData(
      {this.id,
        this.categoryName,
        this.isFavorite,
        this.name,
        this.ingredients,
        this.price,
        this.description,
        this.image,
        this.isNew,
        this.isVeg,
        this.isNonVeg,
        this.isSpicy,
        this.isJain,
        this.isSpecial,
        this.isSweet,
        this.isPopular,
        this.rating,
        this.rated,
        this.duration,
        this.categoryId});

  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    isFavorite = json['is_favorite'];
    name = json['name'];
    ingredients = json['ingredients'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    isNew = json['is_new'];
    isVeg = json['is_veg'];
    isNonVeg = json['is_non_veg'];
    isSpicy = json['is_spicy'];
    isJain = json['is_jain'];
    isSpecial = json['is_special'];
    isSweet = json['is_sweet'];
    isPopular = json['is_popular'];
    rating = json['rating'];
    rated = json['rated'];
    duration = json['duration'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['is_favorite'] = isFavorite;
    data['name'] = name;
    data['ingredients'] = ingredients;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    data['is_new'] = isNew;
    data['is_veg'] = isVeg;
    data['is_non_veg'] = isNonVeg;
    data['is_spicy'] = isSpicy;
    data['is_jain'] = isJain;
    data['is_special'] = isSpecial;
    data['is_sweet'] = isSweet;
    data['is_popular'] = isPopular;
    data['rating'] = rating;
    data['rated'] = rated;
    data['duration'] = duration;
    data['category_id'] = categoryId;
    return data;
  }
}

// single menu item model

class SingleMenuItem {
  bool? status;
  String? message;
  MenuItem? menuItem;

  SingleMenuItem({this.status, this.message, this.menuItem});

  SingleMenuItem.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    menuItem = json['data'] != null ? MenuItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (menuItem != null) {
      data['data'] = menuItem!.toJson();
    }
    return data;
  }
}

class MenuItem {
  int? id;
  String? categoryName;
  bool? isFavorite;
  String? name;
  String? ingredients;
  String? price;
  String? description;
  String? image;
  bool? isNew;
  bool? isVeg;
  bool? isNonVeg;
  bool? isSpicy;
  bool? isJain;
  bool? isSpecial;
  bool? isSweet;
  bool? isPopular;
  String? rating;
  int? rated;
  int? duration;
  int? categoryId;

  MenuItem(
      {this.id,
        this.categoryName,
        this.isFavorite,
        this.name,
        this.ingredients,
        this.price,
        this.description,
        this.image,
        this.isNew,
        this.isVeg,
        this.isNonVeg,
        this.isSpicy,
        this.isJain,
        this.isSpecial,
        this.isSweet,
        this.isPopular,
        this.rating,
        this.rated,
        this.duration,
        this.categoryId});

  MenuItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    isFavorite = json['is_favorite'];
    name = json['name'];
    ingredients = json['ingredients'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    isNew = json['is_new'];
    isVeg = json['is_veg'];
    isNonVeg = json['is_non_veg'];
    isSpicy = json['is_spicy'];
    isJain = json['is_jain'];
    isSpecial = json['is_special'];
    isSweet = json['is_sweet'];
    isPopular = json['is_popular'];
    rating = json['rating'];
    rated = json['rated'];
    duration = json['duration'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['is_favorite'] = isFavorite;
    data['name'] = name;
    data['ingredients'] = ingredients;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    data['is_new'] = isNew;
    data['is_veg'] = isVeg;
    data['is_non_veg'] = isNonVeg;
    data['is_spicy'] = isSpicy;
    data['is_jain'] = isJain;
    data['is_special'] = isSpecial;
    data['is_sweet'] = isSweet;
    data['is_popular'] = isPopular;
    data['rating'] = rating;
    data['rated'] = rated;
    data['duration'] = duration;
    data['category_id'] = categoryId;
    return data;
  }
}

