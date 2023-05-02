
class CartModel {
  final String? cartId;
  final String? itemId;
  final String? itemName;
  final int? table_no;
  final String? itemIngredients;
  final String? itemDescription;
  final String? itemImage;
  final int? initialPrice;
  final int? itemPrice;
  final int? itemQuantity;


  CartModel(
      {  this.cartId,
         this.table_no,
         this.itemId,
         this.itemName,
         this.initialPrice,
         this.itemPrice,
         this.itemQuantity,
         this.itemImage,
         this.itemDescription,
         this.itemIngredients,
      });

  CartModel.fromMap(Map<dynamic, dynamic> data)
      : cartId = data['cartId'],
        table_no = data['table_no'],
        itemId = data['itemId'],
        itemName = data['itemName'],
        initialPrice = data['initialPrice'],
        itemPrice = data['itemPrice'],
        itemQuantity = data['itemQuantity'],
        itemImage = data['itemImage'],
        itemIngredients = data['itemIngredients'],
        itemDescription = data['itemDescription'];

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'table_no' : table_no,
      'itemId': itemId,
      'itemName': itemName,
      'initialPrice': initialPrice,
      'itemPrice': itemPrice,
      'itemQuantity': itemQuantity,
      'itemImage': itemImage,
      'itemIngredients': itemIngredients,
      'itemDescription': itemDescription,
    };
  }

  Map<String, dynamic> quantityMap() {
    return {
      'itemId': itemId,
      'itemQuantity': itemQuantity,
    };
  }
}