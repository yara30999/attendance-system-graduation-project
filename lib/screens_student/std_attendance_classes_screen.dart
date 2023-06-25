import 'package:fast_tende_doctor_app/screens_student/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../componant/appbar_custom.dart';
import '../componant_std/classes_view_2.dart';

class STDAttendanceClassesScreen extends StatefulWidget {
  const STDAttendanceClassesScreen({super.key});
  static String id = 'std_attendance_classes_screen';

  @override
  State<STDAttendanceClassesScreen> createState() => _STDAttendanceClassesScreenState();
}

class _STDAttendanceClassesScreenState extends State<STDAttendanceClassesScreen> {

  final kFirstDay = DateTime(2022);
  final kLastDay = DateTime(2024);
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Map<String, String>> cardData = [
    {
      'lecture': 'lecture software engineering',
      'doctorDay': 'sunday , 12 may 2022',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'status': 'waiting',
    },
    {
      'lecture': 'lecture math engineering',
      'doctorDay': 'sunday , 12 may 2022',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'status': 'checked',
    
    },
    {
      'lecture': 'lecture computer engineering',
      'doctorDay': 'sunday , 12 may 2022',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'status': 'un-checked',
    },
    {
      'lecture': 'lecture information system engineering',
      'doctorDay': 'sunday , 12 may 2022',
      'startDate': '9 AM',
      'endDate': '12 PM',
      'status': 'checked',
    
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarCustom(
                label: 'Attendance',
                onpress: () {
                  Navigator.pushNamed(context, SecondScreen.id);
                },
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text('Date',
                    //     style: TextStyle(
                    //       fontSize: 20.0,
                    //       fontWeight: FontWeight.w400,
                    //     )),
                    TableCalendar(
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        // Use `selectedDayPredicate` to determine which day is currently selected.
                        // If this returns true, then `day` will be marked as selected.

                        // Using `isSameDay` is recommended to disregard
                        // the time-part of compared DateTime objects.
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          // Call `setState()` when updating the selected day
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        }
                        print(
                            'selected day is ${_selectedDay!.day.toString()}');
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          // Call `setState()` when updating calendar format
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        // No need to call `setState()` here
                        _focusedDay = focusedDay;
                      },
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          itemCount: cardData.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return ClassesViewSTD(
                              lectureName:
                                  cardData[index]['lecture'].toString(),
                              doctorDay:
                                  cardData[index]['doctorDay'].toString(),
                              startDate:
                                  cardData[index]['startDate'].toString(),
                              endDate: cardData[index]['endDate'].toString(),
                              status: cardData[index]['status'].toString(),
                              
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
