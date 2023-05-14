import 'package:fast_tende_doctor_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseMessagingService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;

//   Future<void> getToken() async {
//     String? token = await _messaging.getToken();
//     print('my regiteration token is .... $token');
//     // return token ?? '';
//   }

//   Future<void> init() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );

//     print('User granted permission: ${settings.authorizationStatus}');

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       print('Message data: ${message.data}');
//       if (message.notification != null) {
//         print('Message also contained a notification: ${message.notification}');
//       }
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       print('on message open yaaara $message');
//       print('on message open yaaara ${message.data}');
//       // Navigator.pushNamed(navigatorKey.currentState!.context, HomePage.id,
//       //     arguments: {"message": json.encode(message.data)});
//     });

//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         print('on message open yaaara terminated  $message');
//         print('on message open yaaara terminated  ${message.data}');
//         // Navigator.pushNamed(navigatorKey.currentState!.context, HomePage.id,
//         //     arguments: {"message": json.encode(message.data)});
//       }
//     });
//   }
// }

class FirebaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin _localNotifications =
  //     FlutterLocalNotificationsPlugin();
  
  Future<void> getToken() async {
    String? token = await _messaging.getToken();
    print('my regiteration token is .... $token');
    // return token ?? '';
  }

  Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // await _localNotifications
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        final title = message.notification!.title ?? message.data['title'];
        final body = message.notification!.body ?? message.data['body'];
        // final title = 'yara';
        // final body = '111111111111111111111111111111 yara';
        // final SnackBar =SnackBar(content: Text('title:$title '));
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar);
        //await _showNotification(title, body);
        // _localNotifications.show(
        //   message.hashCode,
        //   title,
        //   body,
        //   NotificationDetails(
        //       android: AndroidNotificationDetails(
        //     channel.id,
        //     channel.name,
        //     channel.description,
        //     color: Colors.blue,
        //     playSound: true,
        //     importance: Importance.max,
        //     priority: Priority.high,
        //     //showWhen: false,
        //   )),
        // );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('on message open yaaara $message');
      print('on message open yaaara ${message.data}');
      // Navigator.pushNamed(navigatorKey.currentState!.context, HomePage.id,
      //     arguments: {"message": json.encode(message.data)});
      if (message.notification != null) {
        final title = message.notification!.title ?? message.data['title'];
        final body = message.notification!.body ?? message.data['body'];

        showDialog(
            context: navigatorKey.currentState!.context,
            builder: (_) {
              return AlertDialog(
                title: Text(title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(body),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  // Future<void> init2(BuildContext context) async {
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //     print('on message open yaaara $message');
  //     print('on message open yaaara ${message.data}');
  //     // Navigator.pushNamed(navigatorKey.currentState!.context, HomePage.id,
  //     //     arguments: {"message": json.encode(message.data)});
  //     if (message.notification != null) {
  //       final title = message.notification!.title ?? message.data['title'];
  //       final body = message.notification!.body ?? message.data['body'];

  //       showDialog(
  //           context: context,
  // builder: (_) {
  //   return AlertDialog(
  //     title: Text(title),
  //     content: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(body),
  //         ],
  //       ),
  //     ),
  //   );
  // });
  //     }
  //   });
  // }

  // Future<void> _showNotification(String title, String body) async {
  //   const AndroidNotificationDetails androidDetails =
  //       AndroidNotificationDetails(
  //     'channel_id',
  //     'channel_name',
  //     'channel_description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showWhen: false,
  //   );
  //   const IOSNotificationDetails iosDetails = IOSNotificationDetails();
  //   const NotificationDetails platformDetails =
  //       NotificationDetails(android: androidDetails, iOS: iosDetails);

  //   await _localNotifications.show(
  //     0,
  //     title,
  //     body,
  //     platformDetails,
  //     payload: 'test',
  //   );
  // }
}
