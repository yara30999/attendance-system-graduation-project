import 'package:flutter/material.dart';
import 'reusable_card.dart';

class ClassesTab extends StatelessWidget {
  const ClassesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ReusableCard(lectureName: 'math lecture', lectureTime: '10:30'),
        ReusableCard(lectureName: 'control lecture', lectureTime: '2:30'),
        ReusableCard(lectureName: 'mobile lecture', lectureTime: '4:30'),
      ],
    );
  }
}
