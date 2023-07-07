// To parse this JSON data, do
//
//     final assestantModel = assestantModelFromJson(jsonString);

import 'dart:convert';

AssestantModel assestantModelFromJson(String str) =>
    AssestantModel.fromJson(json.decode(str));

String assestantModelToJson(AssestantModel data) => json.encode(data.toJson());

class AssestantModel {
  String message;
  Assistant assistant;

  AssestantModel({
    required this.message,
    required this.assistant,
  });

  factory AssestantModel.fromJson(Map<String, dynamic> json) => AssestantModel(
        message: json["message"],
        assistant: Assistant.fromJson(json["assistant"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "assistant": assistant.toJson(),
      };
}

class Assistant {
  String id;
  String phoneNumber;
  String name;
  String email;
  String t;

  Assistant({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.t,
  });

  factory Assistant.fromJson(Map<String, dynamic> json) => Assistant(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        email: json["email"],
        t: json["__t"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "name": name,
        "email": email,
        "__t": t,
      };
}
