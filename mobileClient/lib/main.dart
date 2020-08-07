import 'package:flutter/material.dart';
import 'package:mobileClient/data/user_service.dart';
import 'package:mobileClient/screens/work/work_list_screen.dart';
import 'package:splashscreen/splashscreen.dart';
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
        home: Splash(
          user: user,
        )));
  });
}

class Splash extends StatefulWidget {
  final User user;

  const Splash({Key key, this.user}) : super(key: key);
  @override
  _SplashState createState() => _SplashState(this.user);
}

class _SplashState extends State<Splash> {
  User user;
  _SplashState(this.user);
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      backgroundColor: Colors.white,
      image: Image.asset('assets/images/logo.png'),
      loaderColor: Colors.blue,
      photoSize: 150,
      navigateAfterSeconds:
          user != null ? WorkListScreen(user: user) : LoginPage(),
    );
  }
}
