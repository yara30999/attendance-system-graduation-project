import 'package:flutter/material.dart';
import 'reusable_card.dart';

class SectionData {
  late final String? secName;
  late final String? secId;
  late final String? userName;
  late final String? secTime;

  SectionData(
      {required this.secName,
      required this.secId,
      required this.userName,
      required this.secTime});
}
// List<SectionData>sectionlist=[
//   SectionData(name: 'security section', time: '12:30'),
//   SectionData(name: 'ecommerce section', time: '12:30'),
//   SectionData(name: 'ecommerce section', time: '12:30'),
//   SectionData(name: 'ecommerce section', time: '12:30'),
// ];
// List<Map<String, String>> sectionsList = [
//   {'lectureName': 'security section', 'time': '12:30'},
//   {'lectureName': 'ecommerce section', 'time': '12:30'},
//   {'lectureName': 'info section', 'time': '12:30'},
//   {'lectureName': 'math section', 'time': '12:30'},
//   {'lectureName': 'mobile section', 'time': '12:30'},
//   {'lectureName': 'control section', 'time': '12:30'},
// ];

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
            lectureName: sections![index].secName,
            lectureTime: sections![index].secTime,
            lectureId: sections![index].secId,
            userName: sections![index].userName,
          );
        });
  }
}
