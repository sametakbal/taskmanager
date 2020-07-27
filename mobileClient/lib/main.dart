import 'package:flutter/material.dart';
import 'package:mobileClient/data/user_service.dart';
import 'package:mobileClient/screens/work/work_list_screen.dart';
import 'screens/user/loginpage.dart';
import 'models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserService.getCurrentUser.then((value) {
    // ignore: unused_local_variable
    User user = value;
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user != null ? WorkListScreen(user: user) : LoginPage(),
    ));
  });
}
