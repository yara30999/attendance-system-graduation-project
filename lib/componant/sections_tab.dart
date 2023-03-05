import 'package:flutter/material.dart';
import 'reusable_card.dart';


class SectionsTab extends StatelessWidget {
  const SectionsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      ReusableCard(lectureName: 'security lecture', lectureTime: '12:30'),
    ]);
  }
}
