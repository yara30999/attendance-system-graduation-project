class StudentListElement {
  String snapshot;
  StudentId studentId;
  bool status;
  String id;

  StudentListElement({
    required this.snapshot,
    required this.studentId,
    required this.status,
    required this.id,
  });

  factory StudentListElement.fromJson(Map<String, dynamic> json) =>
      StudentListElement(
        snapshot: json["snapshot"],
        studentId: StudentId.fromJson(json["studentId"]),
        status: json["status"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "snapshot": snapshot,
        "studentId": studentId.toJson(),
        "status": status,
        "_id": id,
      };
}

class StudentId {
  String id;
  String name;
  T t;

  StudentId({
    required this.id,
    required this.name,
    required this.t,
  });

  factory StudentId.fromJson(Map<String, dynamic> json) => StudentId(
        id: json["_id"],
        name: json["name"],
        t: tValues.map[json["__t"]]!,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__t": tValues.reverse[t],
      };
}

enum T { STUDENT }

final tValues = EnumValues({"Student": T.STUDENT});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
