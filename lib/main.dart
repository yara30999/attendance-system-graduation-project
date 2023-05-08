import 'package:flutter/material.dart';
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
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        FirstScreen.id: (context) => const FirstScreen(),
        CameraScreen.id: (context) => const CameraScreen(),
        AttendanceClassesScreen.id: (context) =>
            const AttendanceClassesScreen(),
        AttendanceListScreen.id: (context) => const AttendanceListScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        NotificationScreen.id: (context) => const NotificationScreen()
      },
    );
  }
}
