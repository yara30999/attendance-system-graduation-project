// To parse this JSON data, do
//
//     final studentNotificationModel = studentNotificationModelFromJson(jsonString);

import 'dart:convert';

StudentNotificationModel studentNotificationModelFromJson(String str) =>
    StudentNotificationModel.fromJson(json.decode(str));

String studentNotificationModelToJson(StudentNotificationModel data) =>
    json.encode(data.toJson());

class StudentNotificationModel {
  List<Notification>? notification;

  StudentNotificationModel({
    this.notification,
  });

  factory StudentNotificationModel.fromJson(Map<String, dynamic> json) =>
      StudentNotificationModel(
        notification: List<Notification>.from(
            json["notification"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notification": List<dynamic>.from(notification!.map((x) => x.toJson())),
      };
}

class Notification {
  String id;
  String title;
  String body;
  Data? data;
  String? userId;
  DateTime date;
  int? v;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    this.data,
    this.userId,
    required this.date,
    this.v,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        title: json["title"],
        body: json["body"],
        data: Data.fromJson(json["data"]),
        userId: json["userId"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "body": body,
        "data": data?.toJson(),
        "userId": userId,
        "date": date.toIso8601String(),
        "__v": v,
      };
}

class Data {
  String? studentName;
  String? studentStatus;
  String? userType;

  Data({
    this.studentName,
    this.studentStatus,
    this.userType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        studentName: json["studentName"],
        studentStatus: json["studentStatus"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "studentName": studentName,
        "studentStatus": studentStatus,
        "userType": userType,
      };
}
