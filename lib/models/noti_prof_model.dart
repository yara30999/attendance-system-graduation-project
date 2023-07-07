// To parse this JSON data, do
//
//     final studentNotificationModel = studentNotificationModelFromJson(jsonString);

import 'dart:convert';

ProfessorNotificationModel professorNotificationModelFromJson(String str) =>
    ProfessorNotificationModel.fromJson(json.decode(str));

String studentNotificationModelToJson(ProfessorNotificationModel data) =>
    json.encode(data.toJson());

class ProfessorNotificationModel {
  List<Notification>? notification;

  ProfessorNotificationModel({
    this.notification,
  });

  factory ProfessorNotificationModel.fromJson(Map<String, dynamic> json) =>
      ProfessorNotificationModel(
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
        userId:json["userId"],
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

// enum Body { NOTIFICATION_MESSAGE }

// final bodyValues =
//     EnumValues({"Notification message": Body.NOTIFICATION_MESSAGE});

class Data {
  String? profName;
  String? userType;
  String? lectureName;
  String? lectureDate;

  Data({
    this.profName,
    this.userType,
    this.lectureName,
    this.lectureDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profName: json["profName"],
        userType: json["userType"],
        lectureName: json["lectureName"],
        lectureDate: json["lectureDate"],
      );

  Map<String, dynamic> toJson() => {
        "profName": profName,
        "userType": userType,
        "lectureName": lectureName,
        "lectureDate": lectureDate,
      };
}

// enum Title {
//   ATTENDENCE_TAKEN_SUCCESSFULLY,
//   ATTENDENCE_MODIFIED_SUCCESSFULLY,
//   LECTURE_DATE_PASSED
// }

// final titleValues = EnumValues({
//   "Attendence modified successfully": Title.ATTENDENCE_MODIFIED_SUCCESSFULLY,
//   "Attendence taken successfully": Title.ATTENDENCE_TAKEN_SUCCESSFULLY,
//   "Lecture date passed": Title.LECTURE_DATE_PASSED
// });

// enum UserId { THE_644_D5_AB6_B36_EB64_ADC52_E9_E8 }

// final userIdValues = EnumValues(
//     {"644d5ab6b36eb64adc52e9e8": UserId.THE_644_D5_AB6_B36_EB64_ADC52_E9_E8});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
