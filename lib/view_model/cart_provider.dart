import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  //FireStoreService fireStoreService = FireStoreService();

  int _counter = 0;
  int _quantity = 1;

  int get counter => _counter;
  int get quantity => _quantity;

  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  Future<void> addCartData(
  {
    String? cartId,
    String? itemId,
    String? itemName,
    int? table_no,
    String? itemIngredients,
    String? itemDescription,
    String? itemImage,
    int? initialPrice,
    int? itemPrice,
    int? itemQuantity
}
      ) async {
    // await fireStoreService.saveCartItem(CartModel(
    //     cartId: cartId,
    //     table_no: table_no,
    //     itemId: itemId,
    //     itemName: itemName,
    //     initialPrice: initialPrice,
    //     itemPrice: initialPrice,
    //     itemQuantity: itemQuantity,
    //     itemImage: itemImage,
    //     itemDescription: itemDescription,
    //     itemIngredients: itemIngredients));
    notifyListeners();
  }

  Future<void> getCartCount() async {
    //_counter =  await fireStoreService.getCartCount();
  }

  Future<void> addQuantity(
      {String? cartId,
      String? itemId,
      String? itemName,
      int? table_no,
      String? itemIngredients,
      String? itemDescription,
      String? itemImage,
      int? initialPrice,
      int? itemPrice,
      int? itemQuantity}) async {
    if (quantity >= 1) {
      _quantity = _quantity + 1;
      _totalPrice = _totalPrice + itemPrice!;
      // await fireStoreService.updateCart(CartModel(
      //     cartId: cartId,
      //     table_no: table_no,
      //     itemId: itemId,
      //     itemName: itemName,
      //     initialPrice: initialPrice,
      //     itemPrice: totalPrice.toInt(),
      //     itemQuantity: quantity,
      //     itemImage: itemImage,
      //     itemDescription: itemDescription,
      //     itemIngredients: itemIngredients));
    }
    notifyListeners();
  }

  Future<void> deleteQuantity(
      {String? cartId,
      String? itemId,
      String? itemName,
      int? table_no,
      String? itemIngredients,
      String? itemDescription,
      String? itemImage,
      int? initialPrice,
      int? itemPrice,
      int? itemQuantity}) async {
    if (quantity <= 1) {
      _quantity = 1;
    } else {
      _quantity = _quantity - 1;
      _totalPrice = _totalPrice - itemPrice!;
      // await fireStoreService.updateCart(CartModel(
      //     cartId: cartId,
      //     table_no: table_no,
      //     itemId: itemId,
      //     itemName: itemName,
      //     initialPrice: initialPrice,
      //     itemPrice: totalPrice.toInt(),
      //     itemQuantity: quantity,
      //     itemImage: itemImage,
      //     itemDescription: itemDescription,
      //     itemIngredients: itemIngredients));
    }
    notifyListeners();
  }

  void removeItem(String cartId, String itemId) {
    //fireStoreService.removeCart(cartId, itemId);
    _totalPrice = 0;
    notifyListeners();
  }

}
