import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// const String baseUrl = 'http://localhost:8081';
const String baseUrl = 'http://192.168.1.222:8081';
// HttpHeaders.contentTypeHeader: 'application/json'
class BaseClient {
  // var client = http.Client();

  //GET
  Future<dynamic> get(String api, String token) async {
    var url = Uri.parse(baseUrl + api);
    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    var response = await http.get(url, headers: headers);
    debugPrint('your get request with status code ${response.statusCode} yaraaaaaaaaa');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Failed to make get request ==> yara:-)');
    }
  }

  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);
    var headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await http.post(url, body: payload, headers: headers);
    debugPrint(
        'your post request with status code ${response.statusCode} yaraaaaaaaaa');
    if (response.statusCode == 201) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Failed to make post request ==> yara:-)');
    }
  }

  ///PUT Request
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var payload = json.encode(object);
    var headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await http.put(url, body: payload, headers: headers);
    debugPrint(
        'your put request with status code ${response.statusCode} yaraaaaaaaaa');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Failed to make put request ==> yara:-)');
    }
  }

  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await http.delete(url, headers: headers);
    debugPrint(
        'your delete request with status code ${response.statusCode} yaraaaaaaaaa');
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Failed to make delete request ==> yara:-)');
    }
  }
}
