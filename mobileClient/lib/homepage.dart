import 'package:flutter/material.dart';
import 'package:mobileClient/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
              onTap: (){},
            ),
            ListTile(
              title: Text('This Month'),
              onTap: (){},
            ),
            ListTile(
              title: Text('This Year'),
              onTap: (){},
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: (){
                logOut(context);
              },
            ),
          ],
        )),
      );
  }
}

Future<void> logOut(BuildContext context) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.clear();
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
}