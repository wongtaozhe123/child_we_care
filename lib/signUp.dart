import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:child_we_care/main.dart';
import 'package:flutter/material.dart';
import 'package:child_we_care/register.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register(),
    '/signup':(context) => SignUp(),
  },
));

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    Map gTemp=ModalRoute.of(context).settings.arguments;
    String g=gTemp['email'];
    print('$g');
    return Scaffold(

    );
  }
}
