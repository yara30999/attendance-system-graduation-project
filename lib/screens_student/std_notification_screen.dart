import 'package:fast_tende_doctor_app/screens_student/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../componant/appbar_custom.dart';
import '../models/auth_state.dart';

final _firestore = FirebaseFirestore.instance;
class STDNotificationScreen extends StatefulWidget {
  const STDNotificationScreen({super.key});
  static String id = 'std_notification_screen';

  @override
  State<STDNotificationScreen> createState() => _STDNotificationScreenState();
}

class _STDNotificationScreenState extends State<STDNotificationScreen> {
  List<Map<String, String>> notificationList = [
    {'label': 'your attendance have been checked', 'date': '08 May 2022'},
    {'label': 'you have ecommerce section', 'date': '08 May 2022'},
    {'label': 'you have 3 classes', 'date': '08 May 2022'},
    {'label': 'your attendance have not been checked', 'date': '08 May 2022'},
    {'label': 'your attendance have been checked', 'date': '08 May 2022'},
    {'label': 'you have ecommerce section', 'date': '08 May 2022'},
    {'label': 'you have 3 classes', 'date': '08 May 2022'},
    {'label': 'your attendance have not been checked', 'date': '08 May 2022'},
    {'label': 'your attendance have been checked', 'date': '08 May 2022'},
    {'label': 'you have ecommerce section', 'date': '08 May 2022'},
    {'label': 'you have 3 classes', 'date': '08 May 2022'},
    {'label': 'your attendance have not been checked', 'date': '08 May 2022'},
  ];

  String? _authType;
  String? _authId;
  late bool _isLoaded;
  @override
  void initState() {
    super.initState();
    loadUserType();
  }

  Future<void> loadUserType() async {
    setState(() {
      _isLoaded = false;
    });
    await tokenState.getAuthType().then((value) {
      setState(() {
        _authType = value!.toLowerCase();
      });
    });
    print('my user type $_authType');
    await tokenState.getAuthId().then((value) {
      setState(() {
        _authId = value!.toString();
      });
    });
    print('my user Id $_authId');
    setState(() {
      _isLoaded = true;
    });
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
                  myStream: _isLoaded
                      ? _firestore
                          .collection(
                              'notifications_${_authType!.toLowerCase().trim()}')
                          .orderBy("orderDate", descending: false)
                          .snapshots()
                      : null,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Today',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                    height: 210,
                    child: NotificationStreamBuilder(
                      myStream: _isLoaded
                          ? _firestore
                              .collection(
                                  'notifications_${_authType!.toLowerCase().trim()}')
                              .orderBy("orderDate", descending: false)
                              .snapshots()
                          : null,
                    )),
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
                          label: notificationList[index]['label'].toString(),
                          date: notificationList[index]['date'].toString(),
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
  const NotificationNumber({super.key, required this.myStream});
  final Stream<QuerySnapshot<Object?>>? myStream;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: myStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Row(
            children: const [
              Text('You have '),
              Text(
                '0 Notifications',
                style: TextStyle(color: Color(0xff66B4E3)),
              ),
              Text(' today.')
            ],
          );
        } else {
          // Get the number of documents in the collection
          int count = snapshot.data!.size;
          // Build your UI using the count
          return Row(
            children: [
              const Text('You have '),
              Text(
                '$count Notifications',
                style: const TextStyle(color: Color(0xff66B4E3)),
              ),
              const Text(' today.')
            ],
          );
        }
      },
    );
  }
}

class NotificationStreamBuilder extends StatelessWidget {
  const NotificationStreamBuilder({super.key, required this.myStream});
  final Stream<QuerySnapshot<Object?>>? myStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: myStream,
        builder: (context, snapshot) {
          List<NotificationsLine> notificationsWidget = [];
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'You don\'t have notifications...',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }
          final notifications = snapshot.data!.docs.reversed; //list of docs
          for (var notify in notifications) {
            final orderId = notify.get('orderId');
            final orderDate = notify.get('orderDate');

            notificationsWidget.add(NotificationsLine(
              label: orderId.toString(),
              date: orderDate.toDate().toLocal().toString(),
            ));
          }
          return ListView(
            scrollDirection: Axis.vertical,
            children: notificationsWidget,
          );
        });
  }
}

class NotificationsLine extends StatelessWidget {
  const NotificationsLine({
    super.key,
    required this.label,
    required this.date,
  });

  final String label;
  final String date;

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
