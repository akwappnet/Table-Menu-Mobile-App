import 'package:flutter/material.dart';
import 'package:table_menu_customer/model/custom_result_model.dart';
import 'package:table_menu_customer/repository/order_repository.dart';

import '../model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();

  bool _loading = false;
  bool get loading => _loading;

  List<OrderData> _orderList = [];

  List<OrderData> get orderList => _orderList;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<CustomResultModel?> placeOrder(dynamic data) async {
    var result = await _orderRepository.placeOrder(data);


      if (result.data['status'] == true) {
        getOrders();
        return CustomResultModel(status: true, message: result.data['message']);
      } else if (result.data['status'] == "False") {
        return CustomResultModel(status: false, message: result.data['message']);
      }
      return CustomResultModel(status: false, message: "An error occurred");

  }

  // get all orders placed by user
  Future<List<OrderData>> getOrders() async {
    var response = await _orderRepository.getOrders();
      if (response.statusCode == 200) {
        var getOrders = OrderModel.fromJson(response.data);

        if (getOrders.orderData!.isNotEmpty) {
          var addedIds = Set<int>();
          _orderList.clear();
          _orderList.addAll(getOrders.orderData!);
          for (var data in getOrders.orderData!) {
            // Check if category already exists
            if (!addedIds.contains(data.id)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.id!); // Add categoryId to Set
            }
          }

          return _orderList;
        }
      } else {}

    // Return an empty list if there was an error
    return [];
  }

  // cancel order

  Future<CustomResultModel?> cancelOrder( int id) async {
    var data = {};
    var result = await _orderRepository.cancelOrder(id, data);

      if (result.data['status'] == true) {
        orderList.removeWhere((item) => item.id == id);
        getOrders();
        notifyListeners();
        return CustomResultModel(status: true, message: result.data["message"]);
      } else if (result.data['status'] == false) {
        return CustomResultModel(status: false, message: result.data["message"]);
      }
      return CustomResultModel(status: false, message: "An error occurred");
  }

}
