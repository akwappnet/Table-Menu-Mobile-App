class OrderTrackingModel {
  bool? status;
  String? message;
  List<OrderTrackingData>? orderTrackingData;

  OrderTrackingModel({this.status, this.message, this.orderTrackingData});

  OrderTrackingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      orderTrackingData = <OrderTrackingData>[];
      json['data'].forEach((v) {
        orderTrackingData!.add(OrderTrackingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderTrackingData != null) {
      data['data'] = orderTrackingData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderTrackingData {
  int? id;
  int? user;
  String? customerName;
  int? tableNo;
  List<OrderTrackingCartItems>? orderTrackingCartItems;
  String? orderStatus;
  String? paymentStatus;
  String? createdAt;
  String? totalPrice;
  dynamic remainingDuration;
  String? orderInstructions;

  OrderTrackingData(
      {this.id,
        this.user,
        this.customerName,
        this.tableNo,
        this.orderTrackingCartItems,
        this.orderStatus,
        this.paymentStatus,
        this.createdAt,
        this.totalPrice,
        this.remainingDuration,
        this.orderInstructions});

  OrderTrackingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    customerName = json['customer_name'];
    tableNo = json['table_no'];
    if (json['cart_items'] != null) {
      orderTrackingCartItems = <OrderTrackingCartItems>[];
      json['cart_items'].forEach((v) {
        orderTrackingCartItems!.add(OrderTrackingCartItems.fromJson(v));
      });
    }
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    totalPrice = json['total_price'];
    remainingDuration = json['remaining_duration'];
    orderInstructions = json['order_instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['customer_name'] = customerName;
    data['table_no'] = tableNo;
    if (orderTrackingCartItems != null) {
      data['cart_items'] = orderTrackingCartItems!.map((v) => v.toJson()).toList();
    }
    data['order_status'] = orderStatus;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['total_price'] = totalPrice;
    data['remaining_duration'] = remainingDuration;
    data['order_instructions'] = orderInstructions;
    return data;
  }
}

class OrderTrackingCartItems {
  double? total;
  int? itemId;
  int? quantity;
  String? itemName;
  String? itemImage;
  double? itemPrice;

  OrderTrackingCartItems(
      {this.total,
        this.itemId,
        this.quantity,
        this.itemName,
        this.itemImage,
        this.itemPrice});

  OrderTrackingCartItems.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    itemId = json['item_id'];
    quantity = json['quantity'];
    itemName = json['item_name'];
    itemImage = json['item_image'];
    itemPrice = json['item_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['item_id'] = itemId;
    data['quantity'] = quantity;
    data['item_name'] = itemName;
    data['item_image'] = itemImage;
    data['item_price'] = itemPrice;
    return data;
  }
}

