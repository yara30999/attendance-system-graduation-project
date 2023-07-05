// To parse this JSON data, do
//
//     final filteredProfissorSectionsModel = filteredProfissorSectionsModelFromJson(jsonString);

import 'dart:convert';

FilteredProfissorSectionsModel filteredProfissorSectionsModelFromJson(
        String str) =>
    FilteredProfissorSectionsModel.fromJson(json.decode(str));

String filteredProfissorSectionsModelToJson(
        FilteredProfissorSectionsModel data) =>
    json.encode(data.toJson());

class FilteredProfissorSectionsModel {
  String? message;
  List<Section>? sections;
  

  FilteredProfissorSectionsModel({
    this.message,
    this.sections,
    
  });

  factory FilteredProfissorSectionsModel.fromJson(Map<String, dynamic> json) =>
      FilteredProfissorSectionsModel(
        message: json["message"],
        sections: json["sections"] != null
            ? List<Section>.from(json["sections"].map((x) => Section.fromJson(x)))
            : null,
        
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sections": List<dynamic>.from(sections!.map((x) => x.toJson())),
        
      };
}

class Section {
  String? id;
  SubjectId? subjectId;
  String? assistId;
  List<String>? attendanceImages;
  List<AttendanceList>? attendanceList;
  DateTime date;
  int? v;
  String status;

  Section({
    this.id,
    this.subjectId,
    this.assistId,
    this.attendanceImages,
    this.attendanceList,
    required this.date,
    this.v,
    required this.status,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["_id"],
        subjectId: SubjectId.fromJson(json["subjectId"]),
        assistId: json["assistId"],
        attendanceImages:
            List<String>.from(json["attendanceImages"].map((x) => x)),
        attendanceList: List<AttendanceList>.from(
            json["attendanceList"].map((x) => AttendanceList.fromJson(x))),
        date: DateTime.parse(json["date"]),
        v: json["__v"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "subjectId": subjectId?.toJson(),
        "assistId": assistId,
        "attendanceImages": List<dynamic>.from(attendanceImages!.map((x) => x)),
        "attendanceList":
            List<dynamic>.from(attendanceList!.map((x) => x.toJson())),
        "date": date.toIso8601String(),
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
