class CartModel {
  bool? status;
  String? message;
  List<CartData>? cartData;

  CartModel({this.status, this.message, this.cartData});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      cartData = <CartData>[];
      json['data'].forEach((v) {
        cartData?.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cartData != null) {
      data['data'] = this.cartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartData {
  int? id;
  int? user;
  int? menuItem;
  int? quantity;
  String? totalPrice;
  String? menuItemName;
  double? menuItemPrice;
  String? menuItemImage;

  CartData(
      {this.id,
        this.user,
        this.menuItem,
        this.quantity,
        this.totalPrice,
        this.menuItemName,
        this.menuItemPrice,
        this.menuItemImage});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    menuItem = json['menu_item'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    menuItemName = json['menu_item_name'];
    menuItemPrice = json['menu_item_price'];
    menuItemImage = json['menu_item_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['menu_item'] = this.menuItem;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['menu_item_name'] = this.menuItemName;
    data['menu_item_price'] = this.menuItemPrice;
    data['menu_item_image'] = this.menuItemImage;
    return data;
  }

  // json decode for orders

  Map<String, dynamic> toJsonOrder() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_price'] = this.totalPrice;
    data['quantity'] = this.quantity;
    data['menu_item_name'] = this.menuItemName;
    return data;
  }

}