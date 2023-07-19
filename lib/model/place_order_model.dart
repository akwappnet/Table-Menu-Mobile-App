class PlaceOrderModel {
  bool? status;
  String? message;
  PlaceorderData? placeorderData;

  PlaceOrderModel({this.status, this.message, this.placeorderData});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    placeorderData = json['data'] != null ? PlaceorderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.placeorderData != null) {
      data['data'] = this.placeorderData!.toJson();
    }
    return data;
  }
}

class PlaceorderData {
  int? orderId;
  double? totalPrice;

  PlaceorderData({this.orderId, this.totalPrice});

  PlaceorderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['total_price'] = this.totalPrice;
    return data;
  }
}