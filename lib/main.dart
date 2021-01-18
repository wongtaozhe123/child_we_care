import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:flutter/material.dart';
import 'package:child_we_care/register.dart';
import 'package:child_we_care/signUp.dart';
import 'package:child_we_care/login.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register(),
    '/signup':(context) => SignUp(),
    '/login':(context) => Login(),
  },
));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 1),(){
        Navigator.pushReplacementNamed(context, '/login');
    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purple[100]
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image(
                    image: AssetImage('assets/cwc logo.png')
                ),
              ),
              Container(
                child: Text(
                  'Child We Care',
                  style: TextStyle(
                    fontFamily: 'Prompt-Thin',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5
                  )
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
