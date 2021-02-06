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
  List<String> tags=[];
  List<String> options=['vegetarian','autism','asperger','license','experienced'];

  @override
  Widget build(BuildContext context) {
    Map gTemp=ModalRoute.of(context).settings.arguments;
    String g=gTemp['email'];
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.purple[100],
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: SafeArea(
                          child: ClipOval(
                              child: Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                                child: InkWell(
                                  child: Image(
                                    // image: (_img == null)? AssetImage('assets/defaultUser.png'):FileImage(_img),
                                    image: AssetImage('assets/defaultUser.png'),
                                    width: 50,
                                    height: 50,
                                  ),
                                  onTap: (){},
                                ),
                              )
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          '$g'
                        ),
                      ),
                    ],
                  ),
                  Container(
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ChipsChoice<String>.multiple(
                  value: tags,
                  onChanged: (val)=>setState((){
                    tags=val;
                    for(int x=0;x<tags.length;x++){
                      print(tags[x]);
                    }
                  }),
                  choiceItems: C2Choice.listFrom(
                      source: options,
                      value: (i,v)=>v,
                      label: (i,v)=>v,
                  ),
                choiceActiveStyle: (
                  C2ChoiceStyle(
                    brightness: Brightness.dark,
                    color: Colors.purple
                  )
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.purple[200],
        child: Container(
          height: 60,
          color: Colors.purple[200].withOpacity(0.4),
          child: Row(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.home_filled,

                  ),
                  onPressed: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
