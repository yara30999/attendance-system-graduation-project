import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TokenSaved {
  late String _authToken;

  String get authToken => _authToken;

  set authToken(String value) {
    _authToken = value;
  }

  Future<void> setAuthToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', value);
    authToken = value;
  }

  Future<String> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('authToken')!;
    return authToken;
  }
}

// To parse this JSON data, do
//
//     final authState = authStateFromJson(jsonString);

AuthState authStateFromJson(String str) => AuthState.fromJson(json.decode(str));

String authStateToJson(AuthState data) => json.encode(data.toJson());

class AuthState {
  String message;
  User user;

  AuthState({
    required this.message,
    required this.user,
  });

  factory AuthState.fromJson(Map<String, dynamic> json) => AuthState(
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  String token;
  String userId;
  String userType;

  User({
    required this.token,
    required this.userId,
    required this.userType,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        userId: json["userId"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userId": userId,
        "userType": userType,
      };
}
