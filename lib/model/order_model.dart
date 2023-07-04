class OrderModel {
  bool? status;
  String? message;
  List<OrderData>? orderData;

  OrderModel({this.status, this.message, this.orderData});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      orderData = <OrderData>[];
      json['data'].forEach((v) {
        orderData!.add(OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (orderData != null) {
      data['data'] = orderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  int? id;
  int? user;
  String? customerName;
  int? tableNo;
  List<CartItems>? cartItems;
  String? orderStatus;
  String? paymentStatus;
  String? createdAt;
  String? totalPrice;

  OrderData(
      {this.id,
      this.user,
      this.customerName,
      this.tableNo,
      this.cartItems,
      this.orderStatus,
      this.paymentStatus,
      this.createdAt,
      this.totalPrice});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    customerName = json['customer_name'];
    tableNo = json['table_no'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['customer_name'] = customerName;
    data['table_no'] = tableNo;
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['order_status'] = orderStatus;
    data['payment_status'] = paymentStatus;
    data['created_at'] = createdAt;
    data['total_price'] = totalPrice;
    return data;
  }
}

class CartItems {
  String? itemName;
  double? itemPrice;
  int? quantity;
  String? itemImage;
  double? total;

  CartItems(
      {this.itemName,
      this.itemPrice,
      this.quantity,
      this.itemImage,
      this.total});

  CartItems.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    itemPrice = json['item_price'];
    quantity = json['quantity'];
    itemImage = json['item_image'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['item_price'] = itemPrice;
    data['quantity'] = quantity;
    data['item_image'] = itemImage;
    data['total'] = total;
    return data;
  }
}
