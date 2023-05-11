import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/auth_state.dart';
import '../screens/first_screen.dart';
import '../screens/login_screen.dart';

class SignInOrOut {
  void login(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.1.222:8081/login'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});

      debugPrint('status code = ${response.statusCode} yaraaaaaaaaaaaaaa');

      if (response.statusCode == 200) {
        debugPrint('correct response 200');
        auth = authStateFromJson(response.body);

        final authToken = auth.user!.token.toString();
        final authType = auth.user!.userType.toString();
        print(authToken.toString());
        // save the authToken to shared preferences
        // final tokenState = TokenSaved(); because it is already creaded in auth state file.
        await tokenState.setAuthToken(authToken);
        await tokenState.setAuthtype(authType);
        print(authType);
        print(authToken);
        // navigate to the first screen
        try {
          Navigator.pushNamed(context, FirstScreen.id);
        } catch (e) {
          print('can not navigate yaraaaaaaaaaaaaaaaaa');
        }
      } else {
        // show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid username or password'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // show an error message
      print('$error yarrrrrraaa');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('An error occurred while logging in'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  void logout(BuildContext context) async {
    // set the token and auth type with empty string ...
    try {
      await tokenState.setAuthToken('empty');
      await tokenState.setAuthtype('empty');
      Navigator.pushNamed(context, LoginScreen.id);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout Failed'),
          content: const Text('An error occurred while logging out'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}
