import 'package:flutter/material.dart';
import 'reusable_card.dart';

class SectionData {
  late final String? secName;
  late final String? secId;
  late final String? userName;
  late final String? secTime;
  late final bool visible;

  SectionData({
    required this.secName,
    required this.secId,
    required this.userName,
    required this.secTime,
    required this.visible,
  });
}

class SectionsTab extends StatelessWidget {
  const SectionsTab({
    super.key,
    required this.sections,
  });
  final List<SectionData>? sections;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: sections!.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ReusableCard(
            visible: sections![index].visible,
            lectureName: sections![index].secName,
            lectureTime: sections![index].secTime,
            lectureId: sections![index].secId,
            userName: sections![index].userName,
          );
        });
  }
}
