// To parse this JSON data, do
//
//     final attendanceSectionModel = attendanceSectionModelFromJson(jsonString);

import 'dart:convert';

import 'attend_list_element_model.dart';
// import '../screens/attendance_list.dart';

AttendanceSectionModel attendanceSectionModelFromJson(String str) =>
    AttendanceSectionModel.fromJson(json.decode(str));

String attendanceSectionModelToJson(AttendanceSectionModel data) =>
    json.encode(data.toJson());

class AttendanceSectionModel {
  String message;
  Section section;
  List<StudentListElement>? studentList;
  int total;
  int here;
  int absent;

  AttendanceSectionModel({
    required this.message,
    required this.section,
    this.studentList,
    required this.total,
    required this.here,
    required this.absent,
  });

  factory AttendanceSectionModel.fromJson(Map<String, dynamic> json) =>
      AttendanceSectionModel(
        message: json["message"],
        section: Section.fromJson(json["section"]),
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
        "section": section.toJson(),
        "studentList": List<dynamic>.from(studentList!.map((x) => x.toJson())),
        "total": total,
        "here": here,
        "absent": absent,
      };
}

class Section {
  String? id;
  SubjectId? subjectId;
  String? assistId;
  List<String>? attendanceImages;
  DateTime date;
  bool notified;
  List<StudentListElement>? attendanceList;
  int? v;

  Section({
    this.id,
    this.subjectId,
    this.assistId,
    this.attendanceImages,
    required this.date,
    required this.notified,
    this.attendanceList,
    this.v,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        subjectId: SubjectId.fromJson(json["subjectId"]),
        assistId: json["assistId"],
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
        "assistId": assistId,
        "attendanceImages": List<dynamic>.from(attendanceImages!.map((x) => x)),
        "date": date.toIso8601String(),
        "notified": notified,
        "attendanceList":
            List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
        "__v": v,
      };
}
