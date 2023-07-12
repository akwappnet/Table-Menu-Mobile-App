import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/model/cart_model.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/repository/cart_repository.dart';

import '../utils/routes/routes_name.dart';
import '../utils/widgets/custom_flushbar_widget.dart';

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

  addCart(dynamic data, int id,BuildContext context) {
    _cartRepository.addToCart(data).then((response) {
      if(response != null) {

        if (response.data['status'] == true) {
          getCartItems();
          CustomFlushbar.showSuccess(context, response.data["message"]);
          notifyListeners();
          Navigator.pushNamed(context, RoutesName.CART_SCREEN_ROUTE);
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred");
        notifyListeners();
      }
    });
  }

  // get cart item

  Future<List<CartData>> getCartItems() async {

    await _cartRepository.getCartItems().then((response) {
      if(response != null) {
        if (response.statusCode == 200) {
          var getCartItem = CartModel.fromJson(response.data);
          var addedIds = <int>{};
          cartList.clear();
          cartList.addAll(getCartItem.cartData!);
          log("cart list:${cartList.length}");
          for (var data in getCartItem.cartData!) {
            // Check if category already exists
            if (!addedIds.contains(data.id)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.id!); // Add categoryId to Set
            }
          }
          updateTotalPrice();
          notifyListeners();
          return cartList;
        } else {
          notifyListeners();
        }
      }else {
        notifyListeners();
      }
    });
    notifyListeners();
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

  updateItemQuantity(dynamic data, int id) {
    _cartRepository.updateCartItem(data, id).then((response) {
      if(response != null) {
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
          notifyListeners();
        } else {
          // TODO: Handle error
          notifyListeners();
        }
      }else {
        notifyListeners();
      }
    });

  }

  deleteCartItem(int id,BuildContext context) {
    _cartRepository.deleteCartItem(id).then((response) {
      if(response != null){
        if (response.data["status"] == true) {
          cartList.removeWhere((item) => item.id == id);
          getCartItems();
          // Recalculate the total price
          updateTotalPrice();
          _quantity = 1;
          CustomFlushbar.showSuccess(context, response.data["message"]);
          notifyListeners();
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred");
        notifyListeners();
      }
    });
  }

  // clear cart - delete all cart items

  deleteAllCartItem(BuildContext context) {
    _cartRepository.deleteAllCartItem().then((response) {
      if(response != null) {
        if (response.data["status"] == true) {
          cartList.clear();
          clearCart();
          getCartItems();
          CustomFlushbar.showSuccess(context, response.data["message"]);
          notifyListeners();
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(context, response.data["message"]);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(context, "An error occurred");
        notifyListeners();
      }
    });
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
