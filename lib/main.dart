import 'package:flutter/material.dart';
import 'models/auth_state.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/first_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/attendance_list.dart';
import 'screens/profile_screen.dart';
import 'screens/attendance_classes_screen.dart';
import 'screens/notification_screen.dart';

void main() {
  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      if (_authToken != null) {
        return const FirstScreen();
      } else {
        return const LoginScreen();
      }
    }
  }
}
