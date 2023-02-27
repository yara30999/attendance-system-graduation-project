import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
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
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id : (context) => const LoginScreen(), 
          HomeScreen.id : (context)=> const HomeScreen(),
        },
    );
  }
}