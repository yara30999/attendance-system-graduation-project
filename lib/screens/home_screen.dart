import 'package:flutter/material.dart';
import '../constants.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
                top: 20.0, left: 30.0, right: 30.0, bottom: 20.0),
            decoration: const BoxDecoration(
              color: Color(0xff0d8ad5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(33.0),
                bottomRight: Radius.circular(33.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1) digital clock
                    kDigitalClockStyle,
                    // 2) profile photo
                    const ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      child: Image(
                        image: AssetImage('images/user1.png'),
                        fit: BoxFit.cover,
                        height: 56.3,
                        width: 57.6,
                      ),
                    ),
                  ],
                ),
                //const SizedBox(height: 10.0),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Let\'s find',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Your next class!',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10.0),
                // 3) search field 
                ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    TextField(
                      decoration: kSearchField,
                      onChanged: (value) {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}