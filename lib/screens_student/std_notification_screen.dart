import 'package:fast_tende_doctor_app/screens_student/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../componant/appbar_custom.dart';
import '../models/auth_state.dart';
import '../models/std_noti_model.dart';
import '../services/base_client.dart';

//final _firestore = FirebaseFirestore.instance;

class NotiDataSTD {
  late final String? title;
  late final String? date;
  late final String? name;
  late final String? status;

  NotiDataSTD({
    required this.title,
    required this.date,
    required this.name,
    required this.status,
  });
}

class STDNotificationScreen extends StatefulWidget {
  const STDNotificationScreen({super.key});
  static String id = 'std_notification_screen';

  @override
  State<STDNotificationScreen> createState() => _STDNotificationScreenState();
}

class _STDNotificationScreenState extends State<STDNotificationScreen> {
  List<NotiDataSTD> notificationList = [];

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
    var response = await BaseClient()
        .get(
            '/student-notification',
            _authToken!,
            errTxt: 'can\'t load notifications ...',
            showError)
        .catchError((err) {
      print('yaraaaaaaaaaa error $err');
    });
    if (response == null) return;

    final data = studentNotificationModelFromJson(response);
    if (data.notification != null) {
      for (int i = 0; i < data.notification!.length; i++) {
        final notiTitle = data.notification?[i].title;
        final notiDate = DateFormat('dd-MMMM-yyyy, HH:mm')
            .format(data.notification![i].date);
        final studentName = data.notification?[i].data?.studentName;
        final studentStatus = data.notification?[i].data?.studentStatus;
        setState(() {
          notificationList.add(NotiDataSTD(
            title: notiTitle,
            date: notiDate,
            name: studentName,
            status: studentStatus,
          ));
        });
      }
    }
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
              Navigator.pushNamed(context, SecondScreen.id);
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
                const Text(
                  'Today',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 210,
                  child:
                      // NotificationStreamBuilder(
                      //   myStream: _isLoaded
                      //       ? _firestore
                      //           .collection(
                      //               'notifications_${_authType!.toLowerCase().trim()}')
                      //           .orderBy("orderDate", descending: false)
                      //           .snapshots()
                      //       : null,
                      // )),
                      ListView.builder(
                          itemCount: notificationList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return NotificationsLine(
                              label: notificationList[index].title.toString(),
                              date: notificationList[index].date.toString(),
                              stdName: notificationList[index].name,
                              stdStatus: notificationList[index].status,
                            );
                          }),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'This Week',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 132,
                  child: ListView.builder(
                      itemCount: notificationList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationsLine(
                          label: notificationList[index].title.toString(),
                          date: notificationList[index].date.toString(),
                          stdName: notificationList[index].name,
                          stdStatus: notificationList[index].status,
                        );
                      }),
                )
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
          '$notiNumbers Notifications',
          style: const TextStyle(color: Color(0xff66B4E3)),
        ),
        const Text(' today.')
      ],
    );
  }
}

// class NotificationStreamBuilder extends StatelessWidget {
//   const NotificationStreamBuilder({super.key, required this.myStream});
//   final Stream<QuerySnapshot<Object?>>? myStream;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: myStream,
//         builder: (context, snapshot) {
//           List<NotificationsLine> notificationsWidget = [];
//           if (!snapshot.hasData) {
//             return const Center(
//               child: Text(
//                 'You don\'t have notifications...',
//                 style: TextStyle(
//                   color: Colors.blueAccent,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             );
//           }
//           final notifications = snapshot.data!.docs.reversed; //list of docs
//           for (var notify in notifications) {
//             final orderId = notify.get('orderId');
//             final orderDate = notify.get('orderDate');

//             notificationsWidget.add(NotificationsLine(
//               label: orderId.toString(),
//               date: orderDate.toDate().toLocal().toString(),
//             ));
//           }
//           return ListView(
//             scrollDirection: Axis.vertical,
//             children: notificationsWidget,
//           );
//         });
//   }
// }

class NotificationsLine extends StatelessWidget {
  const NotificationsLine({
    super.key,
    required this.label,
    required this.date,
    this.stdName,
    this.stdStatus,
  });

  final String label;
  final String date;
  final String? stdName;
  final String? stdStatus;

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
                  visible: stdName != null,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Student : ${stdName ?? ' '}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Status : ${stdStatus ?? ' '}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
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
