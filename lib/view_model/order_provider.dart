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

    // await fireStoreService.saveOrderItem(
    //   OrderModel(
    //       orderId: orderId,
    //       orderStatus: orderStatus,
    //       userId: userId,
    //       tableNo: tableNo,
    //       createdAt: createdAt,
    //       paymentStatus: paymentStatus,
    //     cartItemList: cartItemList
    //   )
    // );
    notifyListeners();
  }

}