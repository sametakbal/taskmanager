import 'package:flutter/material.dart';
import 'package:mobileClient/data/user_service.dart';
import 'package:mobileClient/screens/user/register_screen.dart';
import 'package:mobileClient/screens/work/work_list_screen.dart';
import 'package:toast/toast.dart';

import '../../models/user.dart';

Future<void> login(
    String username, String password, BuildContext context) async {
  UserService.setCurrentUser(username, password).then((value) {
    if (value != null) {
      User user = value;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WorkListScreen(user: user)),
      );
    } else {
      Toast.show("Incorrect login", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  });
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: usernameController,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter username or email';
        }
        return null;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          focusColor: Colors.blue,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(1.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          debugPrint(MediaQuery.of(context).size.width.toString());
          if (_formKey.currentState.validate()) {
            debugPrint(passwordController.text);
            setState(() {
              showSpinner = true;
            });
            login(usernameController.text, passwordController.text, context)
                .then((value) => {
                      setState(() {
                        showSpinner = false;
                      })
                    });
          }
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    showSpinner
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                          )
                        : SizedBox(
                            height: 155.0,
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    SizedBox(
                      height: 35.0,
                    ),
                    InkWell(
                      child: Text(
                        "Dont't have an account?",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
