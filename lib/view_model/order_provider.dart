import 'package:flutter/cupertino.dart';


class OrderProvider extends ChangeNotifier {

  //FireStoreService fireStoreService = FireStoreService();

  Future<void> addOrder(
      {int? tableNo,
      String? userId,
      String? orderStatus,
      String? paymentStatus,
      String? orderId,
        List<Map<String,dynamic>>? cartItemList,
      String? createdAt
      }) async{
    notifyListeners();
  }

}