import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/auth_state.dart';
import '../models/noti_prof_model.dart';
import '../services/base_client.dart';
import 'first_screen.dart';
import '../componant/appbar_custom.dart';

//final _firestore = FirebaseFirestore.instance;

class NotiDataSTD {
  late final String? title;
  late final String? date;
  late final String? data_1;
  late final String? data_2;

  NotiDataSTD({
    required this.title,
    required this.date,
    required this.data_1,
    required this.data_2,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static String id = 'notification_screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotiDataSTD> notificationList = [
    // {'label': 'your attendance have been checked', 'date': '08 May 2022'},
    // {'label': 'you have ecommerce section', 'date': '08 May 2022'},
    // {'label': 'you have 3 classes', 'date': '08 May 2022'},
    // {'label': 'your attendance have not been checked', 'date': '08 May 2022'},
    // {'label': 'your attendance have been checked', 'date': '08 May 2022'},
    // {'label': 'you have ecommerce section', 'date': '08 May 2022'},
    // {'label': 'you have 3 classes', 'date': '08 May 2022'},
    // {'label': 'your attendance have not been checked', 'date': '08 May 2022'},
    // {'label': 'your attendance have been checked', 'date': '08 May 2022'},
    // {'label': 'you have ecommerce section', 'date': '08 May 2022'},
    // {'label': 'you have 3 classes', 'date': '08 May 2022'},
    // {'label': 'your attendance have not been checked', 'date': '08 May 2022'},
  ];

  String? _authToken;
  String? _authType;
  String? _authId;
  late bool _isLoaded;

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
    //////////////////////////////////////////////////then get id.
    await tokenState.getAuthId().then((value) {
      setState(() {
        _authId = value;
      });
    });
    print('my type $_authId');
    checkLoadedData();
  }

  void checkLoadedData() async {
    await fetchNotificationData();
    setState(() {
      _isLoaded = true;
    });
  }

  Future<void> fetchNotificationData() async {
    setState(() {
      notificationList.clear();
    });

    if (_authType == 'professor') {
      var response = await BaseClient()
          .get(
              '/professor-notification',
              _authToken!,
              errTxt: 'can\'t load professor notifications ...',
              showError)
          .catchError((err) {
        print('yaraaaaaaaaaa error $err');
      });
      if (response == null) return;

      final data = professorNotificationModelFromJson(response);
      if (data.notification != null) {
        for (int i = 0; i < data.notification!.length; i++) {
          final notiTitle = data.notification?[i].title;
          final notiDate = DateFormat('dd-MMMM-yyyy, HH:mm')
              .format(data.notification![i].date);
          if (notiTitle?.toLowerCase() == 'lecture date passed') {
            final data_1 = data.notification?[i].data?.lectureName;
            final dateString = data.notification?[i].data?.lectureDate;
            List<String> words = dateString!.split(' ');
            List<String> firstFourWords = words.sublist(0, 4);
            String data_2 = firstFourWords.join(' ');
            setState(() {
              notificationList.add(NotiDataSTD(
                title: notiTitle,
                date: notiDate,
                data_1: data_1,
                data_2: data_2,
              ));
            });
          } else {
            final data_1 = data.notification?[i].data?.profName;
            final data_2 = data.notification?[i].data?.userType;
            setState(() {
              notificationList.add(NotiDataSTD(
                title: notiTitle,
                date: notiDate,
                data_1: data_1,
                data_2: data_2,
              ));
            });
          }
        }
      }
    } else if (_authType == 'assistant') {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppbarCustom(
            label: 'Notification',
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
                NotificationNumber(
                  notiNumbers: notificationList.length,
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: notificationList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationsLine(
                          label: notificationList[index].title.toString(),
                          date: notificationList[index].date.toString(),
                          firstData: notificationList[index].data_1,
                          secondData: notificationList[index].data_2,
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class NotificationNumber extends StatelessWidget {
  const NotificationNumber({super.key, required this.notiNumbers});

  final int notiNumbers;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('You have '),
        Text(
          '$notiNumbers Notifications .',
          style: const TextStyle(color: Color(0xff66B4E3)),
        ),
      ],
    );
  }
}

class NotificationsLine extends StatelessWidget {
  const NotificationsLine({
    super.key,
    required this.label,
    required this.date,
    this.firstData,
    this.secondData,
  });

  final String label;
  final String date;
  final String? firstData;
  final String? secondData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 247, 247, 246),
            //because A borderRadius can only be given for a uniform Border.
            //so we comment the next line...& using (ClipRRect)
            //borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border:
                Border(left: BorderSide(width: 2.0, color: Color(0xff0D8AD5)))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff03304F)),
              ),
              const SizedBox(height: 2.0),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Visibility(
                  visible: firstData != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //width:0.0,
                          height: 33.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xaae0e0e0),
                              width: 1.5,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10.0),
                              Text(
                                firstData ?? ' ',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                            ],
                          ),
                        ),
                        Container(
                          // width: 0.0,
                          height: 33.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xaae0e0e0),
                              width: 1.5,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 2.5),
                              Text(
                                secondData ?? ' ',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 2.5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
