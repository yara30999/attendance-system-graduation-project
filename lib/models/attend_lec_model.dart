// To parse this JSON data, do
//
//     final attendanceLectureModel = attendanceLectureModelFromJson(jsonString);

import 'dart:convert';

import 'attend_list_element_model.dart';
// import '../screens/attendance_list.dart';

AttendanceLectureModel attendanceLectureModelFromJson(String str) =>
    AttendanceLectureModel.fromJson(json.decode(str));

String attendanceLectureModelToJson(AttendanceLectureModel data) =>
    json.encode(data.toJson());

class AttendanceLectureModel {
  String message;
  Lecture lecture;
  List<StudentListElement>? studentList;
  int total;
  int here;
  int absent;

  AttendanceLectureModel({
    required this.message,
    required this.lecture,
    this.studentList,
    required this.total,
    required this.here,
    required this.absent,
  });

  factory AttendanceLectureModel.fromJson(Map<String, dynamic> json) =>
      AttendanceLectureModel(
        message: json["message"],
        lecture: Lecture.fromJson(json["lecture"]),
        studentList: json["studentList"] != null
            ? List<StudentListElement>.from(
                json["studentList"].map((x) => StudentListElement.fromJson(x)))
            : null,
        total: json["total"],
        here: json["here"],
        absent: json["absent"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "lecture": lecture.toJson(),
        "studentList": List<dynamic>.from(studentList!.map((x) => x.toJson())),
        "total": total,
        "here": here,
        "absent": absent,
      };
}

class Lecture {
  String? id;
  SubjectId? subjectId;
  String? profId;
  List<String>? attendanceImages;
  DateTime date;
  bool notified;
  List<StudentListElement>? attendanceList;
  int? v;

  Lecture({
    this.id,
    this.subjectId,
    this.profId,
    this.attendanceImages,
    required this.date,
    required this.notified,
    this.attendanceList,
    this.v,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) => Lecture(
        id: json["_id"],
        subjectId: SubjectId.fromJson(json["subjectId"]),
        profId: json["profId"],
        attendanceImages: json["attendanceImages"] != null
            ? List<String>.from(json["attendanceImages"].map((x) => x))
            : null,
        date: DateTime.parse(json["date"]),
        notified: json["notified"],
        attendanceList: json["attendanceList"] != null
            ? List<StudentListElement>.from(json["attendanceList"]
                .map((x) => StudentListElement.fromJson(x)))
            : null,
        v: json["__v"],
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
      };
}
