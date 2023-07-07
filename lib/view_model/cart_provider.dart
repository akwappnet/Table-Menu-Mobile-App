import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/model/cart_model.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/repository/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _cartRepository = CartRepository();

  int _counter = 0;
  int _quantity = 1;

  int get counter => _counter;
  int get quantity => _quantity;

  double _totalPrice = 0;

  double _itemPrice = 0;
  double get itemPrice => _itemPrice;

  double get totalPrice => _totalPrice;

  List<CartData> cartList = [];

  void setQuantity(int value) {
    _quantity = value;
    notifyListeners();
  }

  Future<CustomResultModel?> addCart(dynamic data, int id) async {
    var result = await _cartRepository.addToCart(data);
    getCartItems();

      if (result.data['status'] == true) {
        return CustomResultModel(status: true, message: result.data["message"]);
      } else if (result.data['status'] == "False") {
        return CustomResultModel(status: false, message: result.data["message"]);
      }
      return CustomResultModel(status: false, message: "An error occurred");
  }

  // get cart item

  Future<List<CartData>> getCartItems() async {
    var response = await _cartRepository.getCartItems();
      if (response.statusCode == 200) {
        var getCartItem = CartModel.fromJson(response.data);
        var addedIds = Set<int>();
        cartList.clear();
        cartList.addAll(getCartItem.cartData!);
        log("cart list:${cartList.length}");
        getCartItem.cartData!.forEach((data) {
          // Check if category already exists
          if (!addedIds.contains(data.id)) {
            // categoryList.add(GetCategory(data: [data]));
            addedIds.add(data.id!); // Add categoryId to Set
          }
        });
        updateTotalPrice();
        return cartList;
      } else {
      }
    // Return an empty list if there was an error
    return [];
  }

  void incrementCartCount() {
    _counter++;
    notifyListeners();
  }

  void decrementCartCount() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  incrementItemQuantity() {
    _quantity++;
    notifyListeners();
  }

  decrementItemQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void incrementItemQuantityUpdate(CartData item) {
    item.quantity = (item.quantity ?? 0) + 1;
    notifyListeners();
  }

  void decrementItemQuantityUpdate(CartData item) {
    if (item.quantity != null && item.quantity! > 1) {
      item.quantity = (item.quantity ?? 0) - 1;
      notifyListeners();
    }
  }

  Future<void> updateItemQuantity(dynamic data, int id) async {
    var response = await _cartRepository.updateCartItem(data, id);
      if (response.statusCode == 200) {
        var updatedItem = CartData.fromJson(response.data);
        // Find the item in the cartList and update its quantity
        var index = cartList.indexWhere((item) => item.id == updatedItem.id);
        if (index != -1) {
          cartList[index] = updatedItem;
          updateTotalPrice();
          notifyListeners();
        }
        getCartItems();
      } else {
        // TODO: Handle error
      }
  }

  Future<CustomResultModel?> deleteCartItem(int id) async {
    var response = await _cartRepository.deleteCartItem(id);
      if (response.data["status"] == true) {
        cartList.removeWhere((item) => item.id == id);
        getCartItems();
        // Recalculate the total price
        updateTotalPrice();
        _quantity = 1;
        return CustomResultModel(status: true, message: response.data["message"]);
      } else if (response.data['status'] == "False") {
        return CustomResultModel(status: false, message: response.data["message"]);
      }
      return CustomResultModel(status: false, message: "An error occurred");
  }

  // clear cart - delete all cart items

  Future<CustomResultModel?> deleteAllCartItem() async {
    var response = await _cartRepository.deleteAllCartItem();
      if (response.data["status"] == true) {
        cartList.clear();
        clearCart();
        getCartItems();
        return CustomResultModel(status: true, message: response.data["message"]);
      } else if (response.data['status'] == "False") {
        return CustomResultModel(status: false, message: response.data["message"]);
      }
      return CustomResultModel(status: false, message: "An error occurred");
  }



  void updateTotalPrice() {
    _totalPrice = 0;
    for (var item in cartList) {
      _totalPrice += double.parse(item.totalPrice!);
    }
    notifyListeners();
  }

  void clearCart() {
    _counter = 0;
    _quantity = 1;
    _totalPrice = 0;
    cartList.clear();
    notifyListeners();
  }
}
