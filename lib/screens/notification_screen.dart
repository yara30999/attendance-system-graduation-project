import 'package:flutter/material.dart';

import 'first_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import '../componant/appbar_custom.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static String id = 'notification_screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                    notiNumber: notificationList.length.toString()),
                const SizedBox(height: 10.0),
                const Text(
                  'Today',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 210,
                  child: ListView.builder(
                      itemCount: notificationList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationsView(
                          label: notificationList[index]['label'].toString(),
                          date: notificationList[index]['date'].toString(),
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
                        return NotificationsView(
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

class NotificationsView extends StatelessWidget {
  const NotificationsView({
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

class NotificationNumber extends StatelessWidget {
  const NotificationNumber({super.key, required this.notiNumber});
  final String notiNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('You have '),
        Text(
          '$notiNumber Notifications',
          style: const TextStyle(color: Color(0xff66B4E3)),
        ),
        const Text(' today.')
      ],
    );
  }
}

