import 'package:flutter/material.dart';
import 'package:fast_tende_doctor_app/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';
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
                  width: double.infinity,
                  height: 70.0,
                ),
                const Text(
                  'FAST TENDE',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'TAKE YOUR ATTENDANCE',
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 8.0,
                    fontWeight: FontWeight.normal
                  ),
                ),
                const Text(
                  'EASILY',
                  style: TextStyle(fontSize: 8.0, letterSpacing: 1.0,),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Welcome back ,',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  'Sign in to continue.',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Email')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                      textAlign: TextAlign.start,
                      obscureText: true,
                      decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Password')),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 8.0),
                  child: Material(
                    elevation: 10.0,
                    color: const Color(0xff0D8AD5),
                    borderRadius: BorderRadius.circular(10.0),
                    child: RawMaterialButton(
                      onPressed: () {},
                      constraints: const BoxConstraints.tightFor(
                        width: 398.0,
                        height: 56.0,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
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
