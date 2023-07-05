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
  List<Lecture>? lectures;
  

  FilteredLectureModel({
    this.message,
    this.lectures,
    
  });

  factory FilteredLectureModel.fromJson(Map<String, dynamic> json) =>
      FilteredLectureModel(
        message: json["message"],
        //lectures: Lectures.fromJson(json["lectures"]),
        lectures: json["lectures"] != null
            ? List<Lecture>.from(json["lectures"].map((x) => Lecture.fromJson(x)))
            : null,
        
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "lectures": List<dynamic>.from(lectures!.map((x) => x.toJson())),
        
      };
}

class Lecture {
  String? id;
  SubjectId? subjectId;
  String? profId;
  List<String>? attendanceImages;
  DateTime date;
  bool notified;
  List<AttendanceList>? attendanceList;
  int? v;
  String status;
  

  Lecture({
    this.id,
    this.subjectId,
    this.profId,
    this.attendanceImages,
    required this.date,
    required this.notified,
    this.attendanceList,
    this.v,
    required this.status
    
  });

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        id: json["_id"],
        subjectId: SubjectId.fromJson(json["subjectId"]),
        profId: json["profId"],
        attendanceImages:
            List<String>.from(json["attendanceImages"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        notified: json["notified"],
        attendanceList: List<AttendanceList>.from(
            json["attendanceList"].map((x) => AttendanceList.fromJson(x))),
        v: json["__v"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subjectId": subjectId?.toJson(),
        "profId": profId,
        "attendanceImages": List<dynamic>.from(attendanceImages!.map((x) => x)),
        "date": date.toIso8601String(),
        "notified": notified,
        "attendanceList":
            List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
        "__v": v,
        "status": status,
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
