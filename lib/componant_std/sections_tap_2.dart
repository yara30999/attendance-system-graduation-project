import 'package:flutter/material.dart';
import 'reusable_card_2.dart';

class SectionDataSTD {
  late final String? secName;
  late final String? secId;
  late final String? userName;
  late final String? secTime;

  SectionDataSTD(
      {required this.secName,
      required this.secId,
      required this.userName,
      required this.secTime});
}

class SectionsTabSTD extends StatelessWidget {
  const SectionsTabSTD({
    super.key,
    required this.sections,
  });
  final List<SectionDataSTD>? sections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sections!.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ReusableCardSTD(
            lectureName: sections![index].secName,
            lectureTime: sections![index].secTime,
            lectureId: sections![index].secId,
            userName: sections![index].userName,
          );
        });
  }
}
