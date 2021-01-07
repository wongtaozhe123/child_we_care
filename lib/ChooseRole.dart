import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';

void main() => runApp(MaterialApp(
    home: ChooseRole()
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
              )
            ],
          ),
        )
      ),
    );
  }
}
