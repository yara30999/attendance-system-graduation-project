import 'package:flutter/material.dart';
import '../componant/appbar_custom.dart';
import '../models/auth_state.dart';
import '../services/base_client.dart';
import 'first_screen.dart';
import '../componant/class_view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../models/filter_lec_model.dart';
import '../models/filter_pro_sec_model.dart' as model;

class AttendanceClassesScreen extends StatefulWidget {
  const AttendanceClassesScreen({super.key});

  static String id = 'attendance_classes_screen';

  @override
  State<AttendanceClassesScreen> createState() =>
      _AttendanceClassesScreenState();
}

class _AttendanceClassesScreenState extends State<AttendanceClassesScreen> {
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

  List<Map<String, String>> card = [
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
    if (_authType == 'assistant') {
      setState(() {
        _lecIsLoaded = true;
      });
      return;
    }
    var response = await BaseClient()
        .get(
            '/filterd-lectures/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load lecture data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;
    final data = filteredLectureModelFromJson(response);
    if (data.lectures != null) {
      for (int i = 0; i < data.lectures!.length; i++) {
        final lectureId = data.lectures?[i].id;
        final lectureName = 'Lecture ${data.lectures?[i].subjectId?.name}';
        final lectureStart = data.lectures == null
            ? null
            : DateFormat('H:mm a').format(data.lectures![i].date);
        final incrementedTime = data.lectures == null
            ? null
            : DateFormat('H:mm a')
                .parse(lectureStart!)
                .add(const Duration(hours: 2));
        final lectureEnd = data.lectures == null
            ? null
            : DateFormat('H:mm a').format(incrementedTime!);
        final List<AttendanceList>? attendlist =
            data.lectures?[i].attendanceList;
        final total = attendlist?.length.toString();
        final String? here;
        final String? absence;
        if (attendlist == null || attendlist == []) {
          here = '0';
          absence = '0';
        } else {
          int count1 = 0, count2 = 0;
          for (var item in attendlist) {
            if (item.status == true) {
              count1++;
            } else {
              count2++;
            }
          }
          here = count1.toString();
          absence = count2.toString();
        }
        print(attendlist);
        setState(() {
          //cardList.clear();
          if (data.lectures != null) {
            cardList.add(CardData(
              lecId: lectureId,
              lecName: lectureName,
              lecStart: lectureStart,
              lecEnd: lectureEnd,
              userName: 'Dr. $_authName',
              attendList: attendlist,
              total: total,
              here: here,
              absence: absence,
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
    final String endpoint;
    if (_authType == 'assistant') {
      endpoint = 'filtered-sections';
    } else {
      endpoint = 'professor-sections';
    }
    var response = await BaseClient()
        .get(
            '/$endpoint/$_selectedDate',
            _authToken!,
            errTxt: 'can\'t load sections data',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;
    final data = model.filteredProfissorSectionsModelFromJson(response);
    if (data.sections != null) {
      for (int i = 0; i < data.sections!.length; i++) {
        final sectionId = data.sections?[i].id;
        final sectionName = 'Section ${data.sections?[i].subjectId?.name}';
        final sectionStart = data.sections == null
            ? null
            : DateFormat('H:mm a').format(data.sections![i].date);
        final incrementedTime = data.sections == null
            ? null
            : DateFormat('H:mm a')
                .parse(sectionStart!)
                .add(const Duration(hours: 2));
        final sectionEnd = data.sections == null
            ? null
            : DateFormat('H:mm a').format(incrementedTime!);
        final List<model.AttendanceList>? attendlist =
            data.sections?[i].attendanceList;
        final total = attendlist?.length.toString();
        final String? here;
        final String? absence;
        if (attendlist == null || attendlist == []) {
          here = '0';
          absence = '0';
        } else {
          int count1 = 0, count2 = 0;
          for (var item in attendlist) {
            if (item.status == true) {
              count1++;
            } else {
              count2++;
            }
          }
          here = count1.toString();
          absence = count2.toString();
        }
        print(attendlist);
        setState(() {
          if (data.sections != null) {
            cardList.add(CardData(
              lecId: sectionId,
              lecName: sectionName,
              lecStart: sectionStart,
              lecEnd: sectionEnd,
              userName: _authType == 'assistant'
                  ? 'Eng. $_authName'
                  : 'Dr. $_authName',
              attendList: attendlist,
              total: total,
              here: here,
              absence: absence,
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
                  Navigator.pushNamed(context, FirstScreen.id);
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
                          //     itemCount: card.length,
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.vertical,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return ClassesView(
                          //         lectureName: card[index]['lecture'].toString(),
                          //         doctorName: card[index]['doctorName'].toString(),
                          //         startDate: card[index]['startDate'].toString(),
                          //         endDate: card[index]['endDate'].toString(),
                          //         total: card[index]['total'].toString(),
                          //         here: card[index]['here'].toString(),
                          //         absent: card[index]['absent'].toString(),
                          //       );
                          //     }),
                          ListView.builder(
                              itemCount: cardList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return ClassesView(
                                  lectureId: cardList[index].lecId,
                                  lectureName: cardList[index].lecName,
                                  doctorName: cardList[index].userName,
                                  startDate: cardList[index].lecStart,
                                  endDate: cardList[index].lecEnd,
                                  total: cardList[index].total,
                                  here: cardList[index].here,
                                  absent: cardList[index].absence,
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
