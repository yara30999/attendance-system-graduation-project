// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  String message;
  Student? student;

  StudentModel({
    required this.message,
    required this.student,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        message: json["message"],
        student:
            json["student"] != null ? Student.fromJson(json["student"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "student": student?.toJson(),
      };
}

class Student {
  String id;
  String name;
  String email;
  String phoneNumber;
  String t;

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.t,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        t: json["__t"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "__t": t,
      };
}
