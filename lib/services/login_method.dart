import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/auth_state.dart';
import '../screens/first_screen.dart';

// class SignInOrOut {
//   void login(BuildContext context, String email, String password) async {
//     try {
//       final response = await http.post(
//           Uri.parse('http://192.168.1.222:8081/login'),
//           body: jsonEncode({'email': email, 'password': password}),
//           headers: {HttpHeaders.contentTypeHeader: 'application/json'});

//       print('status code = ${response.statusCode} yaraaaaaaaaaaaaaa');

//       if (response.statusCode == 200) {
//         print('correct response 200');
//         final data = json.decode(response.body);
//         final authToken = data['user']['token'];

//         // save the authToken to shared preferences
//         final authState = AuthState();
//         await authState.setAuthToken(authToken);

//         // navigate to the first screen
//         try {
//           Navigator.pushNamed(context, FirstScreen.id);
//         } catch (e) {
//           print('can not navigate yaraaaaaaaaaaaaaaaaa');
//         }
//       } else {
//         // show an error message
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Login Failed'),
//             content: const Text('Invalid username or password'),
//             actions: [
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (error) {
//       // show an error message
//       print('$error yarrrrrraaa');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Login Failed'),
//           content: const Text('An error occurred while logging in'),
//           actions: [
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }

class SignInOrOut {
  void login(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.1.222:8081/login'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {HttpHeaders.contentTypeHeader: 'application/json'});

      print('status code = ${response.statusCode} yaraaaaaaaaaaaaaa');

      if (response.statusCode == 200) {
        print('correct response 200');
        final data = authStateFromJson(response.body);
        print(data);
        final authToken = data.user.token;

        // save the authToken to shared preferences
        final tokenState = TokenSaved();
        await tokenState.setAuthToken(authToken);

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
}
