import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:child_we_care/main.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register()
  },
));

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/childwecare.png'),
                alignment: Alignment.center,
              ),
              Container(
                child: Text(
                  'Let\'s get Started!',
                  style: TextStyle(
                    fontFamily: 'Redressed-Regular',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
