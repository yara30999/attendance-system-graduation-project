// To parse this JSON data, do
//
//     final studentLectureModel = studentLectureModelFromJson(jsonString);

import 'dart:convert';

StudentLectureModel studentLectureModelFromJson(String str) =>
    StudentLectureModel.fromJson(json.decode(str));

String studentLectureModelToJson(StudentLectureModel data) =>
    json.encode(data.toJson());

class StudentLectureModel {
  String? message;
  List<Lecture>? lectures;

  StudentLectureModel({
    this.message,
    this.lectures,
  });

  factory StudentLectureModel.fromJson(Map<String, dynamic> json) =>
      StudentLectureModel(
        message: json["message"],
        lectures: List<Lecture>.from(
            json["lectures"].map((x) => Lecture.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "lectures": List<dynamic>.from(lectures!.map((x) => x.toJson())),
      };
}

class Lecture {
  bool? completed;
  String? id;
  SubjectId? subjectId;
  ProfId? profId;
  List<String>? attendanceImages;
  DateTime date;
  List<AttendanceList>? attendanceList;
  int? v;
  String? studentStatus;

  Lecture({
    this.completed,
    this.id,
    this.subjectId,
    this.profId,
    this.attendanceImages,
    required this.date,
    this.attendanceList,
    this.v,
    this.studentStatus,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        completed: json["completed"],
        id: json["_id"],
        subjectId: SubjectId.fromJson(json["subjectId"]),
        profId: json["profId"] != null ? ProfId.fromJson(json["profId"]) : null,
        attendanceImages: json["attendanceImages"] != null
            ? List<String>.from(json["attendanceImages"].map((x) => x))
            : null,
        date: DateTime.parse(json["date"]),
        attendanceList: json["attendanceList"] != null
            ? List<AttendanceList>.from(
                json["attendanceList"].map((x) => AttendanceList.fromJson(x)))
            : null,
        v: json["__v"],
        studentStatus: json["studentStatus"],
      );

  Map<String, dynamic> toJson() => {
        "completed": completed,
        "_id": id,
        "subjectId": subjectId?.toJson(),
        "profId": profId?.toJson(),
        "attendanceImages": List<dynamic>.from(attendanceImages!.map((x) => x)),
        "date": date.toIso8601String(),
        "attendanceList":
            List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
        "__v": v,
        "studentStatus": studentStatus,
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

class ProfId {
  String? id;
  String? name;
  String? t;

  ProfId({
    this.id,
    this.name,
    this.t,
  });

  factory ProfId.fromJson(Map<String, dynamic> json) => ProfId(
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
