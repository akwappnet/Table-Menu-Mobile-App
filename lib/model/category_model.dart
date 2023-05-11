
class CategoryModel {
  bool? status;
  String? message;
  List<Data>? data;

  CategoryModel({this.status, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? categoryId;
  String? categoryName;
  String? description;
  String? categoryImg;

  Data(
      {this.categoryId, this.categoryName, this.description, this.categoryImg});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    categoryImg = json['category_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['category_img'] = this.categoryImg;
    return data;
  }
}