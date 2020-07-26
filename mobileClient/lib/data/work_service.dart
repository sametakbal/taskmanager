import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobileClient/models/work.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WorkService {
  static WorkService _singleton = WorkService._internal();
  static int id = 0;
  static String token = '';

  factory WorkService() {
    return _singleton;
  }

  WorkService._internal();

  static Future<void> saveWork(Work work) async {
    work.ownerId = id;
    final http.Response response =
        await http.post('https://www.netlabsoft.com/api/works/save',
            headers: {
              HttpHeaders.authorizationHeader: "Bearer $token",
              'Content-Type': 'application/json; charset=UTF-8'
            },
            body: jsonEncode(<String, dynamic>{
              'id': work.id,
              'title': work.title,
              'description': work.description,
              'goalTime': work.goalTime,
              'ownerId': work.ownerId
            }));
    debugPrint(response.body);
  }

  static Future<List<Work>> getWorks(String sort) async {
    if (id == 0) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      token = _prefs.getString('token');
      id = _prefs.getInt('id');
    }
    debugPrint(id.toString() + ' id');
    debugPrint('Work id + token' + token);
    final response = await http.get(
      'https://www.netlabsoft.com/api/works/$sort?id=$id',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    if (response.body.isNotEmpty) {
      final List responseJson = json.decode(response.body);
      debugPrint(responseJson.toString());
      return responseJson.map((m) => Work.fromJson(m)).toList();
    }
    return [];
  }

  static Future<void> deleteWork(int id) async {
    final http.Response response = await http.get(
        'https://www.netlabsoft.com/api/works/delete/$id',
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    debugPrint(response.body + '----$id');
  }
}
