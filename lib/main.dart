import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_tende_doctor_app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'models/auth_state.dart';
import 'login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/first_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/attendance_list.dart';
import 'screens/profile_screen.dart';
import 'screens/attendance_classes_screen.dart';
import 'screens/notification_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'screens_student/second_screen.dart';
import 'screens_student/std_home_screen.dart';
import 'screens_student/std_attendance_classes_screen.dart';
import 'screens_student/std_notification_screen.dart';
import 'screens_student/std_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('_firebaseMessagingBackgroundHandler yaraa ${message.data}');
  final title = message.notification!.title.toString();
  final body = message.notification!.body.toString();
  final orderId = message.data['orderId'];
  final orderDate = message.data['orderDate'];
  print('my title is ...$title');
  print('my body is ..$body');
  await NotificationService.showNotification(
    title: title,
    body: body,
  );
}

Future<void> getRegistrationToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print('my regiteration token is .... $token');
  await tokenState.setRegisterationToken(token!);
}

final _firestore = FirebaseFirestore.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await getRegistrationToken();

  // if the app in the background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
        SecondScreen.id: (context) => const SecondScreen(),
        STDHomeScreen.id: (context) => const STDHomeScreen(),
        STDAttendanceClassesScreen.id: (context) =>
            const STDAttendanceClassesScreen(),
        STDNotificationScreen.id: (context) => const STDNotificationScreen(),
        STDProfileScreen.id: (context) => const STDProfileScreen()
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
  String? _authId;
  late bool _isLoaded;

  Future<void> saveToDatabase(String orderId, String orderDate) async {
    DateTime dateTime = DateFormat('yyyy-M-d').parse(orderDate);
    print('datetime is .....$dateTime');
    Timestamp timestamp = Timestamp.fromDate(dateTime);
    print('timestamp is .....$timestamp');
    await tokenState.getAuthType().then((value) {
      setState(() {
        _authType = value?.toLowerCase();
      });
    });
    await tokenState.getAuthId().then((value) {
      setState(() {
        _authId = value?.toString();
      });
    });
    await _firestore
        .collection('notifications_${_authType!.toLowerCase()}')
        .add({
      'orderId': orderId,
      'orderDate': timestamp,
    });
  }

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
        final title = message.notification!.title.toString();
        final body = message.notification!.body.toString();
        final orderId = message.data['orderId'];
        final orderDate = message.data['orderDate'];
        print('my title is ...$title');
        print('my body is ..$body');
        print('my orderId is ...$orderId');
        print('my orderDate is ..$orderDate');
        //await saveToDatabase(orderId, orderDate);
        await NotificationService.showNotification(
          title: title,
          body: body,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('on message open yaaara $message');
      print('on message open yaaara ${message.data}');
      if (message.notification != null) {
        final title = message.notification!.title.toString();
        final body = message.notification!.body.toString();
        final orderId = message.data['orderId'];
        final orderDate = message.data['orderDate'];
        print('my title is ...$title');
        print('my body is ..$body');
        print('my orderId is ...$orderId');
        print('my orderDate is ..$orderDate');
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
        .then((RemoteMessage? message) async {
      if (message != null) {
        print('on message open yaaara terminated  ${message.data}');
        if (message.notification != null) {
          final title = message.notification!.title.toString();
          final body = message.notification!.body.toString();
          print('my title is ...$title');
          print('my body is ..$body');
        }
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
      });
    });
    print('my token $_authToken');
    await tokenState.getAuthType().then((value) {
      setState(() {
        _authType = value?.toLowerCase();
      });
    });
    print('my user type $_authType');
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
        if (_authType == 'student') {
          return const SecondScreen();
        } else {
          return const FirstScreen();
        }
      }
    }
  }
}
