// To parse this JSON data, do
//
//     final studentSectionModel = studentSectionModelFromJson(jsonString);

import 'dart:convert';

StudentSectionModel studentSectionModelFromJson(String str) =>
    StudentSectionModel.fromJson(json.decode(str));

String studentSectionModelToJson(StudentSectionModel data) =>
    json.encode(data.toJson());

class StudentSectionModel {
  String? message;
  List<Section>? section;

  StudentSectionModel({
    this.message,
    this.section,
  });

  factory StudentSectionModel.fromJson(Map<String, dynamic> json) =>
      StudentSectionModel(
        message: json["message"],
        section:
            List<Section>.from(json["section"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "section": List<dynamic>.from(section!.map((x) => x.toJson())),
      };
}

class Section {
  String? id;
  SubjectId? subjectId;
  AssistId? assistId;
  List<String>? attendanceImages;
  List<AttendanceList>? attendanceList;
  DateTime date;
  int? v;
  String? studentStatus;

  Section({
    this.id,
    this.subjectId,
    this.assistId,
    this.attendanceImages,
    this.attendanceList,
    required this.date,
    this.v,
    this.studentStatus,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        subjectId: SubjectId.fromJson(json["subjectId"]),
        assistId: AssistId.fromJson(json["assistId"]),
        attendanceImages:
            List<String>.from(json["attendanceImages"].map((x) => x)),
        attendanceList: List<AttendanceList>.from(
            json["attendanceList"].map((x) => AttendanceList.fromJson(x))),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
        studentStatus: json["studentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subjectId": subjectId?.toJson(),
        "assistId": assistId?.toJson(),
        "attendanceImages": List<dynamic>.from(attendanceImages!.map((x) => x)),
        "attendanceList":
            List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
        "date": date.toIso8601String(),
        "__v": v,
        "studentStatus": studentStatus,
      };
}

class AssistId {
  String id;
  String name;
  String t;

  AssistId({
    required this.id,
    required this.name,
    required this.t,
  });

  factory AssistId.fromJson(Map<String, dynamic> json) => AssistId(
        id: json["_id"],
        name: json["name"],
        t: json["__t"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__t": t,
      };
}

class AttendanceList {
  String? snapshot;
  String? studentId;
  bool? status;
  String? id;

  AttendanceList({
    this.snapshot,
    this.studentId,
    this.status,
    this.id,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
        snapshot: json["snapshot"],
        studentId: json["studentId"],
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "snapshot": snapshot,
        "studentId": studentId,
        "status": status,
        "_id": id,
      };
}

class SubjectId {
  String? id;
  String? name;

  SubjectId({
    this.id,
    this.name,
  });

  factory SubjectId.fromJson(Map<String, dynamic> json) => SubjectId(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
