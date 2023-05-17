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
        orderData!.add(new OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orderData != null) {
      data['data'] = this.orderData!.map((v) => v.toJson()).toList();
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
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    orderStatus = json['order_status'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['customer_name'] = this.customerName;
    data['table_no'] = this.tableNo;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['order_status'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['total_price'] = this.totalPrice;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['item_price'] = this.itemPrice;
    data['quantity'] = this.quantity;
    data['item_image'] = this.itemImage;
    data['total'] = this.total;
    return data;
  }
}
