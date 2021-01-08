import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:child_we_care/main.dart';
import 'package:child_we_care/register.dart';

void main() => runApp(MaterialApp(
    routes: {
      '/':(context) => SplashScreen(),
      '/chooseRole':(context) =>ChooseRole(),
      '/register':(context) => Register()
    },
));

class ChooseRole extends StatefulWidget {
  @override
  _ChooseRoleState createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.purple[100]
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,50,0,50),
                child: Image(
                  image: AssetImage('assets/childwecare.png'),
                ),
              ),
              Container(
                child:Text(
                  'Sign in as:',
                  style: TextStyle(
                    fontFamily: 'ArchitectsDaughter',
                    fontSize: 20
                  ),
                )
              ),
              SizedBox(height: 25,),
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
                                  image: AssetImage('assets/parent.png'),
                                  width: 100,
                                  height: 100,
                                ),
                                onTap: (){
                                  setState(() {

                                  });
                                },
                              )
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Text(
                          'PARENT',
                          style: TextStyle(
                            letterSpacing: 4
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
                                image: AssetImage('assets/babysitter.png'),
                                width: 100,
                                height: 100,
                              ),
                              onTap: (){
                                setState(() {
                                  // Navigator.pushNamed(context, '')
                                });
                              },
                            ),
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Text(
                          'BABYSITTER',
                          style: TextStyle(
                              letterSpacing: 4
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.purple[200].withOpacity(0.4)
              ),
              height: 50,
              // alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'DON\'T HAVE AN ACCOUNT YET?  ',
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'CREATE ONE',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                      ),
                    ),
                  )
                ],
              ),

          )
      ),
    );
  }
}
