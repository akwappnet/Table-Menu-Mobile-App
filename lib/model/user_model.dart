import 'package:dio/dio.dart';

class UserModel {
  bool? status;
  String? message;
  UserData? userData;

  UserModel({this.status, this.message, this.userData});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userData != null) {
      data['data'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? phoneNumber;
  MultipartFile? profilePhoto;
  String? profilePhotoUrl;
  String? accountCreatedDate;
  double? customerRating;
  String? customerReview;
  String? email;
  bool? status;
  int? totalOrders;

  UserData(
      {this.id,
        this.name,
        this.phoneNumber,
        this.profilePhoto,
        this.profilePhotoUrl,
        this.accountCreatedDate,
        this.customerRating,
        this.customerReview,
        this.email,
        this.status,
        this.totalOrders});


  FormData toFormData() {
    FormData formData = FormData();
    formData.fields
        .add(MapEntry<String, String>('name', this.name!));
    formData.fields
        .add(MapEntry<String, String>('phone_number', this.phoneNumber!));
    formData.files.add(MapEntry<String, MultipartFile>(
        'image', this.profilePhoto != null ? this.profilePhoto! : this.profilePhoto!));
    return formData;
  }


  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    profilePhotoUrl = json['profile_photo'];
    accountCreatedDate = json['account_created_date'];
    customerRating = json['customer_rating'];
    customerReview = json['customer_review'] ?? 0;
    email = json['email'];
    status = json['status'];
    totalOrders = json['total_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['profile_photo'] = this.profilePhoto;
    data['account_created_date'] = this.accountCreatedDate;
    data['customer_rating'] = this.customerRating;
    data['customer_review'] = this.customerReview;
    data['email'] = this.email;
    data['status'] = this.status;
    data['total_orders'] = this.totalOrders;
    return data;
  }
}