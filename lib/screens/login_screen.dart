import 'package:flutter/material.dart';
import 'package:fast_tende_doctor_app/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('images/logo.png'),
                  width: 100.0,
                  height: 100.0,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'FAST TENDE',
                    style: TextStyle(
                      //fontFamily: 'sfPRO',
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text('TAKE YOUR ATTENDANCE'),
                Text('EASILY'),
                SizedBox(height: 30.0),
                Text(
                  'Login',
                  style: TextStyle(
                    //fontFamily: 'sfPRO',
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Welcome back ,',
                  style: TextStyle(
                    //fontFamily: 'sfPRO',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Sign in to continue.',
                  style: TextStyle(
                    //fontFamily: 'sfPRO',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'email')),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                      textAlign: TextAlign.start,
                      obscureText: true,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'password')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Material(
                    elevation: 10.0,
                    color: Color(0xff0D8AD5),
                    borderRadius: BorderRadius.circular(10.0),
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 350.0,
                      height: 32.0,
                      child: Text(
                        'sign in',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
