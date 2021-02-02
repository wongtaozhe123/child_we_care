import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_we_care/register.dart';
import 'package:child_we_care/signUp.dart';
import 'package:child_we_care/login.dart';
import 'package:child_we_care/main.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:chips_choice/chips_choice.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register(),
    '/signup':(context) => SignUp(),
    '/login':(context) => Login(),
    '/home':(context) => Home(),
  },
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final search=TextEditingController();
  List<String> options=['vegetarian','autism','asperger','license','experienced'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.grey[300],
              shadowColor: Colors.white10,
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                    height: 80,
                    width: 80,
                    child: Image(
                      image: AssetImage('assets/cwc logo.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Text(
                        'Child We Care',
                        style: TextStyle(
                            fontFamily: 'Prompt-Thin',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1
                        )
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: AnimSearchBar(
                rtl: false,
                width: 500,
                // suffixIcon: Icons.add,
                // prefixIcon: Icons.clear,
                textController: search,
                helpText: 'babysitter...',
                onSuffixTap: (){
                  setState(() {
                    print('$search xxxxx');
                    search.clear();
                  });
                },
              ),
            ),
            Container(
              child: Text(
                'Taozhe'
              )
            )
          ],
        ),
      ),
    );
  }
}
