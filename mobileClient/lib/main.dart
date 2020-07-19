//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobileClient/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userid = prefs.getInt('id') ?? 0;
  debugPrint(userid.toString());

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userid !=0 ? Home() : LoginPage()));
}

