//import 'dart:js';

import 'package:fast_tende_doctor_app/services/notification_service.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'models/auth_state.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/first_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/attendance_list.dart';
import 'screens/profile_screen.dart';
import 'screens/attendance_classes_screen.dart';
import 'screens/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'services/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens/empty_page.dart';
import 'screens/home_page.dart';
import 'dart:convert';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel',      //id
//     'high importance notification', //title
//     'this is used channel',         //discription
//     importance: Importance.high,
//     playSound: true);
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('_firebaseMessagingBackgroundHandler yaraa ${message.data}');
}

Future<void> getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print('my regiteration token is .... $token');
  // return token ?? '';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // FirebaseMessagingService messagingService = FirebaseMessagingService();
  // await messagingService.init();
  // await messagingService.getToken();

  // //if the app in background this will work ...
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   print('on message open yaaara $message');
  //   Navigator.pushNamed(navigatorKey.currentState!.context, HomePage.id,
  //       arguments: {"message": json.encode(message.data)});
  // });

  // if the app closed or terminated
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null) {
  //     print('on message open yaaara terminated  $message');
  //     Navigator.pushNamed(navigatorKey.currentState!.context, HomePage.id,
  //         arguments: {"message": json.encode(message.data)});
  //   }
  // });

  //////////////////////////////////////////////////////////////////////////////
  // final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await _messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // print('User granted permission: ${settings.authorizationStatus}');
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print('Message data: ${message.data}');
  //   if (message.notification != null) {
  //     print('Message also contained a notification: ${message.notification}');
  //   }
  // });

  await NotificationService.initializeNotification();

  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData.light(),
      //home: const LoginScreen(),
      // initialRoute: FirstScreen.id,
      initialRoute: LoginCheck.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        FirstScreen.id: (context) => const FirstScreen(),
        CameraScreen.id: (context) => const CameraScreen(),
        AttendanceClassesScreen.id: (context) =>
            const AttendanceClassesScreen(),
        AttendanceListScreen.id: (context) => const AttendanceListScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        NotificationScreen.id: (context) => const NotificationScreen(),
        LoginCheck.id: (context) => const LoginCheck(),
        EmptyPage.id: (context) => const EmptyPage(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}

class LoginCheck extends StatefulWidget {
  const LoginCheck({super.key});
  static String id = 'login_ckeck_screen';
  @override
  State<LoginCheck> createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  String? _authToken;
  String? _authType;
  late bool _isLoaded;
  @override
  void initState() {
    super.initState();
    ///////////////////////////////////////////////////////////////
    // if the app in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        final title = message.data['title']; //message.notification!.title ??
        final body = message.data['body']; //message.notification!.body ??
        print(title);
        print(body);
        await NotificationService.showNotification(
          title: title,
          body: body,
        );
        // flutterLocalNotificationsPlugin.show(
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
        //     //icon:
        //   )),
        // );

        Navigator.pushNamed(navigatorKey.currentState!.context, NotificationScreen.id);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('on message open yaaara $message');
      print('on message open yaaara ${message.data}');
      // Navigator.pushNamed(navigatorKey.currentState!.context, HomePage.id,
      //     arguments: {"message": json.encode(message.data)});
      if (message.notification != null) {
        final title = message.data['title'];
        final body = message.data['body'];
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

    // if the app closed or terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('on message open yaaara terminated  ${message.data}');
        Navigator.pushNamed(navigatorKey.currentState!.context, NotificationScreen.id);
      }
    });
    //////////////////////////////////////////////////////////////
    loadToken();
  }

  Future<void> loadToken() async {
    setState(() {
      _isLoaded = false;
    });
    // load the authToken from shared preferences
    await tokenState.getAuthToken().then((value) {
      setState(() {
        _authToken = value;
        // _isLoaded = true;
      });
    });
    print('my token $_authToken');
    await tokenState.getAuthType().then((value) {
      setState(() {
        _authType = value;
        // _isLoaded = true;
      });
    });
    print('my token $_authType');
    setState(() {
      _isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded == false) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      if (_authToken == 'empty' || _authToken == '' || _authToken == null) {
        return const LoginScreen();
      } else {
        return const FirstScreen();
      }
    }
  }
}
