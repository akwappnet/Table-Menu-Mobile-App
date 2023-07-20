import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/repository/order_repository.dart';
import 'package:table_menu_customer/view_model/cart_provider.dart';

import '../model/order_model.dart';
import '../model/order_tracking_model.dart';
import '../model/place_order_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/widgets/custom_flushbar_widget.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();

  bool _loading = false;
  bool get loading => _loading;

  List<OrderData> _orderList = [];

  List<OrderData> get orderList => _orderList;

  OrderTrackingData? orderTrackingData;
  PlaceorderData? placeorderData;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  final formKey_cards = GlobalKey<FormState>();

  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();


  final TextEditingController feedbackController = TextEditingController();

  bool card = false;

  visibleCard(){
    card = !card;
    notifyListeners();
  }

  double foodRating = 0.0;
  double serviceRating = 0.0;

  updateFoodRating(double value) {
    foodRating=value;
    notifyListeners();
  }

  updateServiceRating(double value) {
    serviceRating=value;
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
          var order = PlaceOrderModel.fromJson(response.data);
          placeorderData = order.placeorderData;
          log(placeorderData!.orderId.toString());
          notifyListeners();
          Navigator.pushNamed(context, RoutesName.ORDER_SUCCESSFUL_SCREEN_ROUTE,arguments: placeorderData?.orderId);
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

  // api call for track single order by id


  getSingleOrder(int id,BuildContext context) {
    _orderRepository.trackOrderByID(id).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          OrderTrackingModel orderTrackingModel = OrderTrackingModel.fromJson(response.data);
          orderTrackingData = orderTrackingModel.orderTrackingData?.first;
          print(orderTrackingData?.customerName);
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


  feedback({required int order_id,String? review,required BuildContext context}) {
    var data = {
      "rating": foodRating,
      "service_rating": serviceRating,
      "review": feedbackController.text
    };
    _orderRepository.feedback(data,order_id).then((response) {
      log(response.toString());
      if(response != null) {
        if (response.statusCode == 200) {
          log(response.toString());
          CustomFlushbar.showSuccess(
              context, response.data['message']);
          notifyListeners();
          Navigator.popAndPushNamed(context, RoutesName.HOME_SCREEN_ROUTE);
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


}
