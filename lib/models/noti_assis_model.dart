// To parse this JSON data, do
//
//     final assistantNotificationModel = assistantNotificationModelFromJson(jsonString);

import 'dart:convert';

AssistantNotificationModel assistantNotificationModelFromJson(String str) =>
    AssistantNotificationModel.fromJson(json.decode(str));

String assistantNotificationModelToJson(AssistantNotificationModel data) =>
    json.encode(data.toJson());

class AssistantNotificationModel {
  List<Notification>? notification;

  AssistantNotificationModel({
    this.notification,
  });

  factory AssistantNotificationModel.fromJson(Map<String, dynamic> json) =>
      AssistantNotificationModel(
        notification: json["notification"] != null
            ? List<Notification>.from(
                json["notification"].map((x) => Notification.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "notification":
            List<dynamic>.from(notification!.map((x) => x.toJson())),
      };
}

class Notification {
  String id;
  String? title;
  String? body;
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

// enum Body { NOTIFICATION_MESSAGE }

// final bodyValues =
//     EnumValues({"Notification message": Body.NOTIFICATION_MESSAGE});

class Data {
  String? sectionName;
  String? sectionDate;

  Data({
    this.sectionName,
    this.sectionDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sectionName: json["sectionName"],
        sectionDate: json["sectionDate"],
      );

  Map<String, dynamic> toJson() => {
        "sectionName": sectionName,
        "sectionDate": sectionDate,
      };
}

// enum SectionName { FUZZY_CONTROL }

// final sectionNameValues =
//     EnumValues({"Fuzzy Control": SectionName.FUZZY_CONTROL});

// enum Title { SECTION_DATE_PASSED, ATTENDENCE_MODIFIED_SUCCESSFULLY }

// final titleValues = EnumValues({
//   "Attendence modified successfully": Title.ATTENDENCE_MODIFIED_SUCCESSFULLY,
//   "Section date passed": Title.SECTION_DATE_PASSED
// });

// enum UserId { THE_64_A71120869_AEBB9_B2_AC8_D6_F }

// final userIdValues = EnumValues(
//     {"64a71120869aebb9b2ac8d6f": UserId.THE_64_A71120869_AEBB9_B2_AC8_D6_F});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
