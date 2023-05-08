// To parse this JSON data, do
//
//     final proffessorModel = proffessorModelFromJson(jsonString);

import 'dart:convert';

ProffessorModel proffessorModelFromJson(String str) =>
    ProffessorModel.fromJson(json.decode(str));

String proffessorModelToJson(ProffessorModel data) =>
    json.encode(data.toJson());

class ProffessorModel {
  String message;
  Professor professor;

  ProffessorModel({
    required this.message,
    required this.professor,
  });

  factory ProffessorModel.fromJson(Map<String, dynamic> json) =>
      ProffessorModel(
        message: json["message"],
        professor: Professor.fromJson(json["professor"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "professor": professor.toJson(),
      };
}

class Professor {
  String id;
  String phoneNumber;
  String name;
  String email;
  String t;

  Professor({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.t,
  });

  factory Professor.fromJson(Map<String, dynamic> json) => Professor(
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
