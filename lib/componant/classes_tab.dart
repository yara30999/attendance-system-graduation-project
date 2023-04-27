import 'package:flutter/material.dart';
import 'reusable_card.dart';

class LectureData {
  late final String name;
  late final String time;

  LectureData({required this.name, required this.time});
}

// List<LectureData>? lectureList = [
//   LectureData(name: 'info lecture', time: '12:30'),
//   LectureData(name: 'ecommerce 1 section', time: '12:30'),
//   LectureData(name: 'math lecture', time: '12:30'),
//   LectureData(name: 'ecommerce 2 section', time: '12:30'),
//   LectureData(name: 'ecommerce 3 section', time: '12:30'),
//   LectureData(name: 'mobile lecture', time: '12:30'),
//   LectureData(name: 'security lecture', time: '12:30'),
// ];
// List<Map<String, String>> classesList = [
//   {'lectureName': 'info lecture', 'time': '12:30'},
//   {'lectureName': 'math lecture', 'time': '12:30'},
//   {'lectureName': 'mobile lecture', 'time': '12:30'},
//   {'lectureName': 'control lecture', 'time': '12:30'},
//   {'lectureName': 'security lecture', 'time': '12:30'},
//   {'lectureName': 'ecommerce lecture', 'time': '12:30'},
// ];

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
            lectureName: lecture![index].name,
            lectureTime: lecture![index].time,
          );
        });
  }
}
