import 'package:flutter/material.dart';
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

  Future<void> placeOrder(BuildContext context, dynamic data) async {
    setLoading(true);
    var result = await _orderRepository.placeOrder(data,context);
    print(result.data);
    if (result.data['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order Done'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (result.data['status'] == "False") {
      setLoading(false);
      // TODO show error message to user
      print("status : ${result.data['status']}");
    }
  }

  // get all orders placed by user
  Future<List<OrderData>> getOrders(BuildContext context) async {
    var response = await _orderRepository.getOrders(context);
    if (response != null) {
      if (response.statusCode == 200) {
        var result = response.data;
        //print(result);

        var getOrders = OrderModel.fromJson(response.data);

        if (getOrders.orderData!.isNotEmpty) {
          var addedIds = Set<int>();
          _orderList.clear();
          _orderList.addAll(getOrders.orderData!);
          getOrders.orderData!.forEach((data) {
            // Check if category already exists
            if (!addedIds.contains(data.id)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.id!); // Add categoryId to Set
            }
          });

          print('###$_orderList');
          return _orderList;
        }
      } else {}
    }
    // Return an empty list if there was an error
    return [];
  }

  // cancel order

  Future<void> cancelOrder(BuildContext context, int id) async {
    var data = {};
    var result = await _orderRepository.cancelOrder(id, data, context);
    print(result.data);
    if (result.data['status'] == true) {
      orderList.removeWhere((item) => item.id == id);
      getOrders(context);
    } else if (result.data['status'] == false) {
      // TODO show error message to user
      print("status : ${result.data['status']}");
    }
  }
}
