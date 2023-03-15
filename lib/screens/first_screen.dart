import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'attendance_classes_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    super.key,
  });
  static String id = 'first_screen';

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _currentIndex = 0;

  final List<Widget> _mainScreens = <Widget>[
    const HomeScreen(),
    const AttendanceClassesScreen(),
    const NotificationScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _mainScreens.elementAt(_currentIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books_outlined),
                    label: 'attendance'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_active_outlined),
                    label: 'notification'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: 'profile'),
              ],
              currentIndex: _currentIndex,
              selectedItemColor: const Color(0xff074E79),
              unselectedItemColor: const Color(0xff8A96BC),
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
