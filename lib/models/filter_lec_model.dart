// To parse this JSON data, do
//
//     final filteredLectureModel = filteredLectureModelFromJson(jsonString);

import 'dart:convert';

FilteredLectureModel filteredLectureModelFromJson(String str) =>
    FilteredLectureModel.fromJson(json.decode(str));

String filteredLectureModelToJson(FilteredLectureModel data) =>
    json.encode(data.toJson());

class FilteredLectureModel {
  String? message;
  Lectures? lectures;
  String? status;

  FilteredLectureModel({
    this.message,
    this.lectures,
    this.status,
  });

  factory FilteredLectureModel.fromJson(Map<String, dynamic> json) =>
      FilteredLectureModel(
        message: json["message"],
        //lectures: Lectures.fromJson(json["lectures"]),
        lectures: json["lectures"] != null
            ? Lectures.fromJson(json["lectures"])
            : null,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "lectures": lectures?.toJson(),
        "status": status,
      };
}

class Lectures {
  String? id;
  SubjectId? subjectId;
  String? profId;
  List<String>? attendanceImages;
  DateTime date;
  int? v;
  List<AttendanceList>? attendanceList;

  Lectures({
    this.id,
    this.subjectId,
    this.profId,
    this.attendanceImages,
    required this.date,
    this.v,
    this.attendanceList,
  });

  factory Lectures.fromJson(Map<String, dynamic> json) => Lectures(
        id: json["_id"],
        subjectId: SubjectId.fromJson(json["subjectId"]),
        profId: json["profId"],
        attendanceImages:
            List<String>.from(json["attendanceImages"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
        attendanceList: List<AttendanceList>.from(
            json["attendanceList"].map((x) => AttendanceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subjectId": subjectId?.toJson(),
        "profId": profId,
        "attendanceImages": List<dynamic>.from(attendanceImages!.map((x) => x)),
        "date": date.toIso8601String(),
        "__v": v,
        "attendanceList":
            List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
      };
}

class AttendanceList {
  String? snapshot;
  String studentId;
  bool status;
  String id;

  AttendanceList({
    this.snapshot,
    required this.studentId,
    required this.status,
    required this.id,
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
  String id;
  String name;

  SubjectId({
    required this.id,
    required this.name,
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
