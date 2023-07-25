import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_menu_customer/repository/order_repository.dart';
import 'package:table_menu_customer/view_model/cart_provider.dart';

import '../model/order_model.dart';
import '../model/order_tracking_model.dart';
import '../model/place_order_model.dart';
import '../utils/helpers.dart';
import '../utils/routes/routes_name.dart';
import '../utils/widgets/custom_flushbar_widget.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _orderRepository = OrderRepository();

  bool _loading = false;
  bool get loading => _loading;

  List<OrderData> _orderList = [];

  List<OrderData> get orderList => _orderList;

  List<OrderData> _orderHistoryList = [];

  List<OrderData> get orderHistoryList => _orderHistoryList;

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

  final TextEditingController instructionController = TextEditingController();

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
          getOrders(context);
          Provider.of<CartProvider>(context,listen: false).clearCart();
          CustomFlushbar.showSuccess(
              context, response.data['message']);
          var order = PlaceOrderModel.fromJson(response.data);
          placeorderData = order.placeorderData;
          log(placeorderData!.orderId.toString());
          notifyListeners();
          Navigator.pushReplacementNamed(context, RoutesName.ORDER_SUCCESSFUL_SCREEN_ROUTE,arguments: placeorderData?.orderId);
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
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // get all orders placed by user
  getOrders(BuildContext context) {
    _orderRepository.getOrders().then((response) {
      setLoading(true);
      if(response != null) {
        if (response.statusCode == 200) {
          setLoading(false);
          var getOrders = OrderModel.fromJson(response.data);
          _orderList = getOrders.orderData!;
          log(_orderList.length.toString());

          // Filter the orders with status "pending" or "preparing"
          _orderList = _orderList
              .where((order) =>
          order.orderStatus == "pending" || order.orderStatus == "Preparing")
              .toList();
          log(_orderList.length.toString());
          notifyListeners();
        } else {
          setLoading(false);
          notifyListeners();
        }
      }else {
        setLoading(false);
        notifyListeners();
      }
    }).catchError((error) {
      setLoading(false);
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // cancel order

  cancelOrder(int id,BuildContext context) {
    var data = {};
    _orderRepository.cancelOrder(id, data).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          CustomFlushbar.showSuccess(
              context, response.data['message']);
          orderList.removeWhere((item) => item.id == id);
          getOrders(context);
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
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // api call for track single order by id

  getSingleOrder(int id,BuildContext context) {
    _orderRepository.trackOrderByID(id).then((response) {
      if(response != null) {
        if (response.data['status'] == true) {
          OrderTrackingModel orderTrackingModel = OrderTrackingModel.fromJson(response.data);
          orderTrackingData = orderTrackingModel.orderTrackingData?.first;
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
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  feedback(int order_id,BuildContext context) {
    var data = {
      "rating": foodRating,
      "service_rating": serviceRating,
      "review": feedbackController.text
    };
    _orderRepository.feedback(data,order_id).then((response) {
      if(response != null) {
        if (response.statusCode == 200) {
          log(response.toString());
          notifyListeners();
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
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }


  changePaymentStatus({required int order_id,required BuildContext context}) {
    _orderRepository.changePaymentStatus(order_id).then((response) {
      log(response.toString());
      if(response != null) {
        if (response.statusCode == 200) {
          notifyListeners();
        } else if (response.data['status'] == "False") {
          notifyListeners();
        }
      }else {
        notifyListeners();
      }
    }).catchError((error) {
      handleDioException(context, error);
      notifyListeners();
    });
  }

  // get order history api call

  getOrdersHistory(BuildContext context) {
    _orderRepository.getOrderHistory().then((response) {
      setLoading(true);
      if(response != null) {
        if (response.statusCode == 200) {
          setLoading(false);
          var getOrders = OrderModel.fromJson(response.data);
          _orderHistoryList = getOrders.orderData!;
          log(_orderList.length.toString());
          notifyListeners();
        } else {
          setLoading(false);
          notifyListeners();
        }
      }else {
        setLoading(false);
        notifyListeners();
      }
    }).catchError((error) {
      setLoading(false);
      handleDioException(context, error);
      notifyListeners();
    });
  }
}
