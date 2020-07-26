import 'package:flutter/material.dart';
import 'package:mobileClient/data/user_service.dart';
import 'package:mobileClient/models/user.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = new TextEditingController();
  final surnameController = new TextEditingController();
  final emailController = new TextEditingController();
  final usernameController = new TextEditingController();
  final passwordController = new TextEditingController();
  final passwordConfirmController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: buildForm(),
          ),
        ),
      ),
    );
  }

  buildForm() {
    final nameField = TextFormField(
      controller: nameController,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter your name!';
        }
        return null;
      },
      decoration: InputDecoration(
          icon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))),
    );
    final surnameField = TextFormField(
      controller: surnameController,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter surname!';
        }
        return null;
      },
      decoration: InputDecoration(
          icon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Surname",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))),
    );
    final emailField = TextFormField(
      controller: emailController,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter email';
        }
        return null;
      },
      decoration: InputDecoration(
          icon: Icon(Icons.email),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))),
    );
    final usernameField = TextFormField(
      controller: usernameController,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
      decoration: InputDecoration(
          icon: Icon(Icons.person_pin),
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
          icon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))),
    );
    final passwordConfirmField = TextFormField(
      controller: passwordConfirmController,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter password';
        } else if (val != passwordController.text) {
          return 'Passwords are not equal!';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
          icon: Icon(Icons.lock_outline),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(1.0))),
    );
    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(1.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            UserService.createUser(User(
                    name: nameController.text,
                    surname: surnameController.text,
                    email: emailController.text,
                    userName: usernameController.text,
                    password: passwordController.text))
                .then((value) {
              debugPrint(value.length.toString());
              if (value.length == 23) {
                Toast.show(value, context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                Navigator.pop(context);
              } else {
                Toast.show(value, context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            });
          }
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          nameField,
          SizedBox(
            height: 10,
          ),
          surnameField,
          SizedBox(
            height: 10,
          ),
          emailField,
          SizedBox(
            height: 10,
          ),
          usernameField,
          SizedBox(
            height: 10,
          ),
          passwordField,
          SizedBox(
            height: 10,
          ),
          passwordConfirmField,
          SizedBox(
            height: 10,
          ),
          registerButton
        ],
      ),
    );
  }
}
