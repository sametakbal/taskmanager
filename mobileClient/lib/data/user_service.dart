import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobileClient/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static User _user = User();

  UserService._internal();
  static UserService _singleton = UserService._internal();

  factory UserService() {
    return _singleton;
  }

  static Future<User> get getCurrentUser async {
    debugPrint(_user.id.toString() + 'user service');
    if (_user.id == 0) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      int id = _prefs.getInt('id') ?? 0;
      debugPrint(id.toString() + "------inside if");
      if (id == 0) {
        return null;
      }
      _user.id = id;
      _user.token = _prefs.getString('token');
      _user.name = _prefs.getString('name');
      _user.surname = _prefs.getString('surname');
    }
    return _user;
  }

  static Future<User> setCurrentUser(String username, String password) async {
    final http.Response res = await http.post(
      'https://www.netlabsoft.com/api/user/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
    Map<String, dynamic> tokenjson = jsonDecode(res.body);
    String token = tokenjson['token'];
    if (token == null) {
      return null;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      prefs.setInt('id', int.parse(decodedToken['nameid']));
      prefs.setString('name', decodedToken['unique_name']);
      prefs.setString('surname', decodedToken['family_name']);
      prefs.setString('token', token);
      debugPrint(token);
      _user.id = int.parse(decodedToken['nameid']);
      _user.token = token;
      _user.name = decodedToken['unique_name'];
      _user.surname = decodedToken['family_name'];
    }
    return _user;
  }

  static Future<bool> removeCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
