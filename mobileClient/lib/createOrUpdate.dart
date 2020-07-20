import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobileClient/homepage.dart';
import 'package:mobileClient/models/work.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveWork(Work work) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int id = prefs.getInt('id');
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
  debugPrint(work.id.toString()+'-----------------'+ work.ownerId.toString());
  debugPrint(response.body);
}

Future<void> deleteWork(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  final http.Response response = await http.get(
      'https://www.netlabsoft.com/api/works/delete/$id',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
  debugPrint(response.body + '----$id');
}

class WorkPage extends StatefulWidget {
  final Work work;
  WorkPage({this.work});
  @override
  _WorkPageState createState() => _WorkPageState(work: this.work);
}

class _WorkPageState extends State<WorkPage> {
  Work work;
  _WorkPageState({this.work});
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final goaltimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = work.title;
    descController.text = work.description;
    goaltimeController.text = work.goalTime;
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleField = TextFormField(
      controller: titleController,
      maxLength: 55,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter title';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Title",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    final descriptionField = TextFormField(
      controller: descController,
      maxLines: 5,
      maxLength: 55,
      keyboardType: TextInputType.multiline,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter description';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Description",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );

    final goaltimeField = TextFormField(
      controller: goaltimeController,
      keyboardType: TextInputType.datetime,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter goaltime';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "yyyy-mm-dd",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(work.id == 0 ? 'Create Work' : work.title),
        centerTitle: true,
        actions: <Widget>[
          work.id != 0 ?
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                deleteWork(work.id).then((value) => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())));
              }) : Center(),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: titleField,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: descriptionField,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: goaltimeField,
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    saveWork(Work(
                            id: work.id,
                            title: titleController.text,
                            description: descController.text,
                            goalTime: goaltimeController.text))
                        .then((value) => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())));
                  }
                },
                color: Colors.blueAccent,
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
