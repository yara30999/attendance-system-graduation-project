import 'package:flutter/material.dart';
import 'std_home_screen.dart';
import 'std_attendance_classes_screen.dart';
import 'std_notification_screen.dart';
import 'std_profile_screen.dart';


class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});
  static String id = 'second_screen';

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  int _currentIndex = 0;

  final List<Widget> _mainScreens = <Widget>[
    const STDHomeScreen(),
    const STDAttendanceClassesScreen(),
    const STDNotificationScreen(),
    const STDProfileScreen()
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