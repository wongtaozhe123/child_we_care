// import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: SplashScreen()
));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purple[50]
        ),
        child: Center(
          child: Column(

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
                    fontWeight: FontWeight.bold
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
