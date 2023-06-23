import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final tokenState = TokenSaved();

AuthState auth = AuthState();

class TokenSaved {
  late String? _authToken;
  late String? _authType;

  String? get authToken => _authToken;
  String? get authType => _authType;

  set authToken(String? value) {
    _authToken = value;
  }

  set authType(String? value) {
    _authType = value;
  }

  Future<void> setAuthToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', value);
    authToken = value;
  }

  Future<void> setAuthtype(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authType', value);
    authType = value;
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('authToken');
    return authToken;
  }

  Future<String?> getAuthType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authType = prefs.getString('authType');
    return authType;
  }
}

// To parse this JSON data, do
//
//     final authState = authStateFromJson(jsonString);


AuthState authStateFromJson(String str) => AuthState.fromJson(json.decode(str));

String authStateToJson(AuthState data) => json.encode(data.toJson());

class AuthState {
    String? message;
    User? user;

    AuthState({
        this.message,
        this.user,
    });

    factory AuthState.fromJson(Map<String, dynamic> json) => AuthState(
        message: json["message"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
    };
}

class User {
    String token;
    String name;
    String phoneNumber;
    String email;
    String userId;
    String userType;

    User({
        required this.token,
        required this.name,
        required this.phoneNumber,
        required this.email,
        required this.userId,
        required this.userType,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        userId: json["userId"],
        userType: json["userType"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "userId": userId,
        "userType": userType,
    };
}

