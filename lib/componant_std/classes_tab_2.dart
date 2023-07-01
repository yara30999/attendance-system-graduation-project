import 'package:flutter/material.dart';
import 'reusable_card_2.dart';

class LectureDataSTD {
  late final String? lecName;
  late final String? lecId;
  late final String? userName;
  late final String? lecTime;

  LectureDataSTD({
    required this.lecName,
    required this.lecId,
    required this.userName,
    required this.lecTime,
  });
}


class ClassesTabSTD extends StatelessWidget {
  const ClassesTabSTD({
    super.key,
    required this.lecture,
  });
  final List<LectureDataSTD>? lecture;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: lecture!.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ReusableCardSTD(
            lectureName: lecture![index].lecName,
            lectureTime: lecture![index].lecTime,
            lectureId: lecture![index].lecId,
            userName: lecture![index].userName,
          );
        });
  }
}
