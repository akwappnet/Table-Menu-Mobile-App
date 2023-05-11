import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:table_menu_customer/model/cart_model.dart';
import 'package:table_menu_customer/repository/cart_repository.dart';

class CartProvider extends ChangeNotifier {

  final CartRepository _cartRepository = CartRepository();

  int _counter = 0;
  int _quantity = 1;

  int get counter => _counter;
  int get quantity => _quantity;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  List<CartData> cartList = [];

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> addCart(BuildContext context, dynamic data) async {
    setLoading(true);
    var result = await _cartRepository.addToCart(data);
    print(result.data);
    if(result.data['status'] == true) {
    }else if (result.data['status'] == "False"){
    setLoading(false);
    // TODO show error message to user
    print("status : ${result.data['status']}");
    }
  }

  // get cart item

  Future<List<CartData>> getCartItems() async {
    var response = await _cartRepository.getCartItems();
    if (response != null) {
      if (response.statusCode == 200) {
        print("true");
         var getCartItem = CartModel.fromJson(response.data);
        print("true2");
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
          print('###$cartList');
          return cartList;
      } else {}
    }
    // Return an empty list if there was an error
    return [];
  }

  Future<void> updateCart(BuildContext context, dynamic data, int id) async {
    setLoading(true);
    var result = await _cartRepository.updateCartItem(data, id);
    print(result.data);
    if(result.data['status'] == true) {
      //TODO update ui accordingly
      Navigator.of(context).pop();
    }else if (result.data['status'] == "False"){
      setLoading(false);
      // TODO show error message to user
      print("status : ${result.data['status']}");
    }
  }

  Future<void> deleteCartItem(BuildContext context, int id) async{
    var response = await _cartRepository.deleteCartItem(id);
    if(response != null){
      if(response.statusCode == 204){
        // TODO update ui accodingly
      }else if(response.data['status'] == "False"){
        // TODO show error message to user
      }
    }
  }
}