import 'package:flutter/material.dart';
import '../componant/appbar_custom.dart';
import 'first_screen.dart';
import '../componant/class_view.dart';

class AttendanceClassesScreen extends StatefulWidget {
  const AttendanceClassesScreen({super.key});

  static String id = 'attendance_classes_screen';

  @override
  State<AttendanceClassesScreen> createState() =>
      _AttendanceClassesScreenState();
}

class _AttendanceClassesScreenState extends State<AttendanceClassesScreen> {
  List<Map<String, String>> cardData = [
    {
      'lecture': 'lecture software engineering',
      'doctorName': 'Dr. Mohammed Ahmed',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'total': '250',
      'here': '112',
      'absent': '138'
    },
    {
      'lecture': 'lecture math engineering',
      'doctorName': 'Dr. Mohammed Ahmed',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'total': '250',
      'here': '112',
      'absent': '138'
    },
    {
      'lecture': 'lecture computer engineering',
      'doctorName': 'Dr. Mohammed Ahmed',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'total': '250',
      'here': '112',
      'absent': '138'
    },
    {
      'lecture': 'lecture information system engineering',
      'doctorName': 'Dr. Mohammed Ahmed',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'total': '250',
      'here': '112',
      'absent': '138'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarCustom(
              label: 'Attendance',
              onpress: () {
                Navigator.pushNamed(context, FirstScreen.id);
              },
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Date',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )),
                  SizedBox(
                    height: 370,
                    child: ListView.builder(
                        itemCount: cardData.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return ClassesView(
                            lectureName: cardData[index]['lecture'].toString(),
                            doctorName:
                                cardData[index]['doctorName'].toString(),
                            startDate: cardData[index]['startDate'].toString(),
                            endDate: cardData[index]['endDate'].toString(),
                            total: cardData[index]['total'].toString(),
                            here: cardData[index]['here'].toString(),
                            absent: cardData[index]['absent'].toString(),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
