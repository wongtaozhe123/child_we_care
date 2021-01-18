import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:flutter/material.dart';
import 'package:child_we_care/register.dart';
import 'package:child_we_care/signUp.dart';
import 'package:child_we_care/login.dart';
import 'package:child_we_care/main.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register(),
    '/signup':(context) => SignUp(),
    '/login':(context) => Login(),
  },
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          'HOME'
        ),
      ),
    );
  }
}
