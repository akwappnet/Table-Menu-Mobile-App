import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/repository/order_repository.dart';
import 'package:table_menu_customer/view_model/cart_provider.dart';

import '../model/order_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/widgets/custom_flushbar_widget.dart';

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

  placeOrder(dynamic data,BuildContext context) {
    _orderRepository.placeOrder(data).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          getOrders();
          Provider.of<CartProvider>(context,listen: false).clearCart();
          CustomFlushbar.showSuccess(
              context, response.data['message']);
          notifyListeners();
          Navigator.pushNamed(context, RoutesName.ORDER_SUCCESSFUL_SCREEN_ROUTE);
        } else if (response.data['status'] == "False") {
          CustomFlushbar.showError(
              context, response.data['message']);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(
            context, "An error occurred");
        notifyListeners();
      }
    });
  }

  // get all orders placed by user
  Future<List<OrderData>> getOrders() async {
    await _orderRepository.getOrders().then((response) {
      if (response.statusCode == 200) {
        var getOrders = OrderModel.fromJson(response.data);
        if (getOrders.orderData!.isNotEmpty) {
          var addedIds = <int>{};
          _orderList.clear();
          _orderList.addAll(getOrders.orderData!);
          for (var data in getOrders.orderData!) {
            // Check if category already exists
            if (!addedIds.contains(data.id)) {
              // categoryList.add(GetCategory(data: [data]));
              addedIds.add(data.id!); // Add categoryId to Set
            }
          }
          notifyListeners();
          return _orderList;
        }else {
          notifyListeners();
        }
      } else {
        notifyListeners();
      }
    });
    notifyListeners();
    // Return an empty list if there was an error
    return [];
  }

  // cancel order

  cancelOrder(int id,BuildContext context) {
    var data = {};
    _orderRepository.cancelOrder(id, data).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          orderList.removeWhere((item) => item.id == id);
          getOrders();
          CustomFlushbar.showSuccess(
              context, response.data['message']);
          notifyListeners();
        } else if (response.data['status'] == false) {
          CustomFlushbar.showError(
              context, response.data['message']);
          notifyListeners();
        }
      }else {
        CustomFlushbar.showError(
            context, "An error occurred");
        notifyListeners();
      }
    });
  }
}
