

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
        menuData!.add(new MenuData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.menuData != null) {
      data['data'] = this.menuData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuData {
  int? id;
  String? categoryName;
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
  int? categoryId;

  MenuData(
      {this.id,
        this.categoryName,
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
        this.categoryId});

  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
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
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['name'] = this.name;
    data['ingredients'] = this.ingredients;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['is_new'] = this.isNew;
    data['is_veg'] = this.isVeg;
    data['is_non_veg'] = this.isNonVeg;
    data['is_spicy'] = this.isSpicy;
    data['is_jain'] = this.isJain;
    data['is_special'] = this.isSpecial;
    data['is_sweet'] = this.isSweet;
    data['is_popular'] = this.isPopular;
    data['category_id'] = this.categoryId;
    return data;
  }
}