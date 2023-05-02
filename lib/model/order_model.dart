
class OrderModel {

  final int? tableNo;

  final String? userId;

  final String? orderStatus;
  final String? paymentStatus;
  final String? orderId;
  final List<Map<String,dynamic>>? cartItemList;
  final String? createdAt;

  OrderModel({
    this.tableNo,
    this.userId,
    this.orderStatus,
    this.paymentStatus,
    this.orderId,
    this.cartItemList,
    this.createdAt});


  OrderModel.fromMap(Map<dynamic, dynamic> data)
      : tableNo = data['tableNo'],
        userId = data['userId'],
        orderStatus = data['orderStatus'],
        paymentStatus = data['paymentStatus'],
        orderId = data['orderId'],
        cartItemList = (data['cartItemList'] as List?)
            ?.map((item) => item as Map<String, dynamic>)
            ?.toList(),
        createdAt = data['createdAt'];


  Map<String, dynamic> toMap() {
    return {
      'tableNo': tableNo,
      'userId': userId,
      'orderStatus': orderStatus,
      'paymentStatus': paymentStatus,
      'orderId': orderId,
      'cartItemList' : cartItemList,
      'createdAt': createdAt,
    };
  }

}