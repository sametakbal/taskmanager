//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(TaskManager());
}

class TaskManager extends StatefulWidget {
  @override
  _TaskManagerState createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {

  Future<http.Response> fetchAlbum() async {
  return http.get('https://jsonplaceholder.typicode.com/albums/1');
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Task Manager"),),
        body: RaisedButton(onPressed: () {
          debugPrint(fetchAlbum().toString());
        }),
      ),
    );
  }
}

