class NotificationModel {
  bool? status;
  String? message;
  List<NotificationData>? notificationData;

  NotificationModel({this.status, this.message, this.notificationData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      notificationData = <NotificationData>[];
      json['data'].forEach((v) {
        notificationData!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (notificationData != null) {
      data['data'] = notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  int? id;
  int? user;
  String? userName;
  String? title;
  String? body;
  String? createdAt;
  bool? readStatus;

  NotificationData(
      {this.id,
        this.user,
        this.userName,
        this.title,
        this.body,
        this.createdAt,
        this.readStatus});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    userName = json['user_name'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
    readStatus = json['read_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['user_name'] = userName;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['read_status'] = readStatus;
    return data;
  }
}