import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobileClient/loginpage.dart';
import 'package:mobileClient/models/work.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<Work>> fetchWorks(String sort) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token');
  int id = prefs.getInt('id');
  final response = await http.get(
    'https://www.netlabsoft.com/api/works/$sort?id=$id',
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
  );
  final List responseJson = json.decode(response.body);
  return responseJson.map((m) => new Work.fromJson(m)).toList();
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Work>> works;
  @override
  void initState() {
    super.initState();
    works = fetchWorks('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('This week'),
              onTap: () {
                setState(() {
                  works = fetchWorks('');
                });
              },
            ),
            ListTile(
              title: Text('This Month'),
              onTap: () {
                setState(() {
                  works = fetchWorks('getMonth');
                });
              },
            ),
            ListTile(
              title: Text('This Year'),
              onTap: () {
                setState(() {
                  works = fetchWorks('getYear');
                });
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                logOut(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: works,
        builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(itemCount: snapshot.data.length, itemBuilder: (context,index) {
            Work work = snapshot.data[index];
            return Card(
              child: ListTile(title: Text(work.title),),
            );
          },);
        }else{
          return CircularProgressIndicator();
        }
      }),
    );
  }
}

Future<void> logOut(BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
