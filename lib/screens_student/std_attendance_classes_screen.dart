import 'package:fast_tende_doctor_app/screens_student/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../componant/appbar_custom.dart';
import '../componant_std/classes_view_2.dart';
import '../models/auth_state.dart';
import '../models/std_lec_model.dart';
import '../models/std_sec_model.dart';
import '../services/base_client.dart';

class STDAttendanceClassesScreen extends StatefulWidget {
  const STDAttendanceClassesScreen({super.key});
  static String id = 'std_attendance_classes_screen';

  @override
  State<STDAttendanceClassesScreen> createState() =>
      _STDAttendanceClassesScreenState();
}

class _STDAttendanceClassesScreenState
    extends State<STDAttendanceClassesScreen> {
  final kFirstDay = DateTime(2022);
  final kLastDay = DateTime(2024);
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  late String _selectedDate;

  List<CardData> cardList = [];
  String? _authToken;
  String? _authType;
  String? _authName;
  late bool _isLoaded;
  bool _lecIsLoaded = false;
  bool _secIsLoaded = false;

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

  showError(String data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error...'),
        content: Text(data),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateFormat("yyyy-MM-dd").format(_selectedDay);
    loadToken();
  }

  Future<void> loadToken() async {
    // load the authToken from shared preferences
    // final tokenState = TokenSaved();
    setState(() {
      _isLoaded = false;
    });
    //////////////////////////////////////////////////get token first.
    await tokenState.getAuthToken().then((value) {
      setState(() {
        _authToken = value;
      });
    });
    print('my token $_authToken');
    //////////////////////////////////////////////////then get type.
    await tokenState.getAuthType().then((value) {
      setState(() {
        _authType = value;
      });
    });
    print('my type $_authType');
    //////////////////////////////////////////////////then get name.
    await tokenState.getAuthName().then((value) {
      setState(() {
        _authName = value;
      });
    });
    print('my name $_authName');
    checkLoadedData();
  }

  void checkLoadedData() async {
    setState(() {
      cardList.clear();
    });
    await fetchLectureData();
    await fetchSectionsData();
    if (_lecIsLoaded && _secIsLoaded) {
      setState(() {
        _isLoaded = true;
      });
    }
  }

  Future<void> fetchLectureData() async {
    var response = await BaseClient()
        .get(
            '/student-lectures/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load lecture data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;
    final data = studentLectureModelFromJson(response);
    if (data.lectures != null) {
      for (int i = 0; i < data.lectures!.length; i++) {
        final lectureId = data.lectures?[i].id;
        final lectureName = 'Lecture ${data.lectures?[i].subjectId?.name}';
        final lectureOwner = 'Dr. ${data.lectures?[i].profId?.name}';
        final lectureDay = _selectedDate;
        final lectureStart = data.lectures == null
            ? null
            : DateFormat('H:mm').format(data.lectures![i].date);
        final incrementedTime = data.lectures == null
            ? null
            : DateFormat('H:mm')
                .parse(lectureStart!)
                .add(const Duration(hours: 2));
        final lectureEnd = data.lectures == null
            ? null
            : DateFormat('H:mm').format(incrementedTime!);
        final studentStatus = data.lectures?[i].studentStatus;

        setState(() {
          if (data.lectures != null) {
            cardList.add(CardData(
              lecId: lectureId,
              lecName: lectureName,
              lecStart: lectureStart,
              lecEnd: lectureEnd,
              userName: lectureOwner,
              studentStatus: studentStatus,
            ));
          }
        });
      }
    }
    setState(() {
      _lecIsLoaded = true;
    });
  }

  Future<void> fetchSectionsData() async {
    var response = await BaseClient()
        .get(
            '/student-sections/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load sections data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });

    if (response == null) return;

    final data = studentSectionModelFromJson(response);
    if (data.section != null) {
      for (int i = 0; i < data.section!.length; i++) {
        final sectionId = data.section?[i].id;
        final sectionName = 'Section ${data.section?[i].subjectId?.name}';
        final sectionOwner = 'Eng. ${data.section?[i].assistId?.name}';
        final sectionDay = _selectedDate;
        final sectionStart = data.section == null
            ? null
            : DateFormat('H:mm').format(data.section![i].date);
        final incrementedTime = data.section == null
            ? null
            : DateFormat('H:mm')
                .parse(sectionStart!)
                .add(const Duration(hours: 2));
        final sectionEnd = data.section == null
            ? null
            : DateFormat('H:mm').format(incrementedTime!);
        final studentStatus = data.section?[i].studentStatus;

        setState(() {
          if (data.section != null) {
            cardList.add(CardData(
              lecId: sectionId,
              lecName: sectionName,
              lecStart: sectionStart,
              lecEnd: sectionEnd,
              userName: sectionOwner,
              studentStatus: studentStatus,
            ));
          }
        });
      }
    }
    setState(() {
      _secIsLoaded = true;
    });
  }

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
                            _selectedDate =
                                DateFormat("yyyy-MM-dd").format(_selectedDay);
                            checkLoadedData();
                          });
                        }
                        print('selected day is ${_selectedDay.day.toString()}');
                        print('selected date is ${_selectedDate}');
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
                      child:
                          // ListView.builder(
                          //     itemCount: cardData.length,
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.vertical,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return ClassesViewSTD(
                          //         lectureName:
                          //             cardData[index]['lecture'].toString(),
                          //         userName: cardData[index]['doctorDay'].toString(),
                          //         startDate:
                          //             cardData[index]['startDate'].toString(),
                          //         endDate: cardData[index]['endDate'].toString(),
                          //         status: cardData[index]['status'].toString(),
                          //       );
                          //     }),
                          ListView.builder(
                              itemCount: cardList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return ClassesViewSTD(
                                  lectureName: cardList[index].lecName,
                                  userName: cardList[index].userName,
                                  startDate: cardList[index].lecStart,
                                  endDate: cardList[index].lecEnd,
                                  status: cardList[index].studentStatus,
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
