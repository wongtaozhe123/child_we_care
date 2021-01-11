import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:child_we_care/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_we_care/register.dart';
import 'package:find_dropdown/find_dropdown.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register(),
    '/signup':(context) => SignUp(),
  },
  // home: SignUp(),
));

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool parent=false;
  bool babysitter=false;
  final username=TextEditingController();
  String usernameError;
  final password=TextEditingController();
  String passwordError;
  bool seePassword=true;
  final confirmpassword=TextEditingController();
  String confirmpasswordError;
  bool seeConfirmPassword=true;
  final phone=TextEditingController();
  String phoneError;
  final address=TextEditingController();
  String addressError;
  int custChoice=3;

  @override
  Widget build(BuildContext context) {
    Map gTemp=ModalRoute.of(context).settings.arguments;
    String g=gTemp['email'];
    // print('$g');
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
                    '$g'
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'I am a:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'YuseiMagic'
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ClipOval(
                          child: Material(
                              color: Colors.white,
                              child: InkWell(
                                child: Image(
                                  image: custChoice==0?AssetImage('assets/tick.png'):AssetImage('assets/parent.png'),
                                  width: 60,
                                  height: 60,
                                ),
                                onTap: (){
                                  setState(() => custChoice=0);
                                },
                              )
                          )
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child: Text(
                          'PARENT',
                          style: TextStyle(
                            letterSpacing: 4,
                            fontSize: 13,
                            fontFamily: 'YuseiMagic'
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipOval(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              child: Image(
                                image: custChoice==1?AssetImage('assets/tick.png'):AssetImage('assets/babysitter.png'),
                                width: 60,
                                height: 60,
                              ),
                              onTap: (){
                                setState(() => custChoice=1);
                              },
                            ),
                          )
                      ),
                      SizedBox(height: 8,),
                      Container(
                        child: Text(
                          'BABYSITTER',
                          style: TextStyle(
                              letterSpacing: 4,
                              fontSize: 13,
                              fontFamily: 'YuseiMagic'
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // USERNAME
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.fromLTRB(30,20,30,10),
                height: 50,
                child: TextFormField(
                  controller: username,
                  showCursor: true,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14
                    ),
                    filled: true,
                    fillColor: Colors.white60.withOpacity(0.6),
                    suffixIcon: Icon(Icons.account_circle_rounded),
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
                    errorText: usernameError,
                  ),
                ),
              ),
              // PASSWORD
              Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(30,20,30,10),
                child: TextFormField(
                  controller: password,
                  showCursor: true,
                  obscureText: seePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14
                    ),
                    filled: true,
                    fillColor: Colors.white60.withOpacity(0.6),
                    suffixIcon: IconButton(
                      icon: Icon(seePassword?Icons.remove_red_eye:Icons.security),
                      onPressed: (){
                        setState(() {
                          seePassword=!seePassword;
                        });
                      },
                    ),
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
                    errorText: passwordError,
                  ),
                ),
              ),
              // CONFIRM PASSWORD
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
                height: 50,
                child: TextFormField(
                  controller: confirmpassword,
                  showCursor: true,
                  obscureText: seePassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14
                    ),
                    filled: true,
                    fillColor: Colors.white60.withOpacity(0.6),
                    suffixIcon: IconButton(
                      icon: Icon(seeConfirmPassword?Icons.remove_red_eye:Icons.security),
                      onPressed: (){
                        setState(() {
                          seeConfirmPassword=!seeConfirmPassword;
                        });
                      },
                    ),
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
                    errorText: confirmpasswordError,
                  ),
                ),
              ),
            //  PHONE
              Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: TextFormField(
                  controller: phone,
                  showCursor: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Contact Number',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14
                    ),
                    filled: true,
                    fillColor: Colors.white60.withOpacity(0.6),
                    suffixIcon: IconButton(icon: Icon(Icons.phone)),
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
                    errorText: phoneError,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
