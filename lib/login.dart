import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:child_we_care/main.dart';
import 'package:child_we_care/signUp.dart';
import 'package:child_we_care/register.dart';
import 'package:child_we_care/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final FirebaseAuth _auth=FirebaseAuth.instance;
final GoogleSignIn googleSignIn=GoogleSignIn();

class _LoginState extends State<Login> {
  final email=TextEditingController();
  String emailError;
  final password=TextEditingController();
  String passwordError;
  bool seePassword=true;

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
              ),
              Container(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      fontFamily: 'ArchitectsDaughter',
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                ),
              ),
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
                    'Log In with',
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
                margin: EdgeInsets.fromLTRB(30,20,30,10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  showCursor: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    hintText: 'Email',
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
                    errorText: emailError,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30,20,30,10),
                child: TextFormField(
                  controller: password,
                  showCursor: true,
                  obscureText: seePassword,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
              // LOGIN BUTTON
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
                width: 250,
                child: RaisedButton(
                  // highlightColor: Colors.purple[400],
                  // focusColor: Colors.purple[600],
                  color: Colors.purple[400],
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                        fontFamily: 'YuseiMagic',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 5,
                        color: Colors.white
                    ),
                  ),
                  onPressed: () async{
                    setState(() {
                      if(email.text.length<1){
                        emailError='This field cannot be left empty';
                      }
                      else{
                        if(password.text.length<1){
                          passwordError='This field cannot be left empty';
                        }
                        else{
                          setState(() async{
                            try{
                              await Firebase.initializeApp();
                              final UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
                              Navigator.pushReplacementNamed(context,'/signup',arguments: {'email':email.text});
                            }on FirebaseAuthException catch(e){
                              if (e.code=='user-not-found'){
                                Fluttertoast.showToast(
                                    msg: "This email is not found, please sign up if you've not yet register",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 13.0
                                );
                              }else if(e.code=='wrong-password'){
                                Fluttertoast.showToast(
                                    msg: "The password is incorrect, please try again",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 13.0
                                );
                              }
                            }
                          });
                        }
                      }
                    });
                  },
                ),
              ),
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
              //SIGN IN BUTTON GOOGLE, & FACEBOOK
              SizedBox(height:20),
              SignInButton(
                Buttons.Google,
                onPressed: ()async{
                  setState(() async{
                    try{
                      await Firebase.initializeApp();
                      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
                      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
                      final AuthCredential credential=GoogleAuthProvider.credential(
                        accessToken: googleSignInAuthentication.accessToken,
                        idToken: googleSignInAuthentication.idToken,
                      );
                      FirebaseFirestore.instance.collection('email').where('gmail', isEqualTo:googleSignInAccount.email).get().then((querySnapshot) async{
                        if(querySnapshot.docs.isNotEmpty){
                          final UserCredential authResult=await _auth.signInWithCredential(credential);
                          final User user=authResult.user;
                          if(user!=null){
                            assert(!user.isAnonymous);
                            assert(await user.getIdToken() != null);
                            final User currentUser = _auth.currentUser;
                            assert(user.uid==currentUser.uid);
                          }
                          Navigator.pushReplacementNamed(context, '/signup',arguments: {'email':user.email});
                        }
                        else if(querySnapshot.docs.isEmpty){
                          Fluttertoast.showToast(
                              msg: "This email hasn\'t been register before, please login with other email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 13.0);
                        }
                      });
                    }on FirebaseAuthException catch(e){
                      Fluttertoast.showToast(
                        msg: "$e",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 13.0);
                    }
                  });
                },
              ),
              SizedBox(height:5),
              SignInButton(
                Buttons.FacebookNew,
                onPressed: (){},
              ),
              SignInButton(
                Buttons.GoogleDark,
                onPressed: ()async{
                  await googleSignIn.signOut();
                }
              ),
              SizedBox(height:20),

            ],
          ),
        ),
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
