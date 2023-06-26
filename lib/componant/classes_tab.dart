import 'package:flutter/material.dart';
import 'reusable_card.dart';

class LectureData {
  late final String? lecName;
  late final String? lecId;
  late final String? userName;
  late final String? lecTime;

  LectureData({
    required this.lecName,
    required this.lecId,
    required this.userName,
    required this.lecTime,
  });
}

class ClassesTab extends StatelessWidget {
  const ClassesTab({
    super.key,
    required this.lecture,
  });
  final List<LectureData>? lecture;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lecture!.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ReusableCard(
            lectureName: lecture![index].lecName,
            lectureTime: lecture![index].lecTime,
            lectureId: lecture![index].lecId,
            userName: lecture![index].userName,
          );
        });
  }
}
