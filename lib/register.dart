import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:child_we_care/main.dart';
import 'package:child_we_care/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register(),
    '/signup':(context) => SignUp(),
  },
));

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final email=TextEditingController();
  String emailError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/childwecare.png'),
                fit: BoxFit.fitWidth,
              ),
              Container(
                child: Text(
                  'Let\'s get Started!',
                  style: TextStyle(
                    fontFamily: 'Redressed-Regular',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                  )
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: Divider(
                      height: 1.5,
                      color: Colors.black45,
                    ),
                  )),
                  Text(
                    'Sign Up with',
                    style: TextStyle(
                      fontFamily: 'ArchitectsDaughter',
                      fontSize: 15.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Divider(
                      height: 1.5,
                      color: Colors.black45,
                    ),
                  ))
                ],
              ),
              SizedBox(height:20),
              SignInButton(
                  Buttons.Google,
                  onPressed: (){},
              ),
              SizedBox(height:5),
              SignInButton(
                Buttons.FacebookNew,
                onPressed: (){},
              ),
              SizedBox(height:20),
              Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: Divider(
                      height: 1.5,
                      color: Colors.black45,
                    ),
                  )),
                  Text(
                    'or',
                    style: TextStyle(
                      fontFamily: 'ArchitectsDaughter',
                      fontSize: 15.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Divider(
                      height: 1.5,
                      color: Colors.black45,
                    ),
                  ))
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 15),
                child: TextFormField(
                  controller: email,
                  showCursor: true,
                  decoration: InputDecoration(
                    hintText: 'Your Email',
                      hintStyle: TextStyle(
                          color: Colors.grey[500]
                      ),
                    filled: true,
                    fillColor: Colors.white60.withOpacity(0.6),
                    suffixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red[600]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: emailError,
                  ),
                ),
              ),
              SignInButtonBuilder(
                icon: Icons.email,
                text: 'Continue with your Email',
                backgroundColor: Colors.grey[500],
                splashColor: Colors.grey[600],
                onPressed: (){
                  setState(() {
                    RegExp rgEmail=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
                    if(email.text.length<1){
                      emailError='Field cannot be empty';
                    }
                    else{
                      if(rgEmail.hasMatch(email.text)){
                        emailError=null;
                        Navigator.pushReplacementNamed(context, '/signup', arguments: {
                          'email':email.text
                        });
                      }
                      else{
                        emailError='Please enter a valid email';
                      }
                    }
                  });
                },
                height: 40,
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
