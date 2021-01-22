import 'dart:convert';
import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:child_we_care/main.dart';
import 'package:child_we_care/signUp.dart';
import 'package:child_we_care/login.dart';
import 'package:child_we_care/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

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

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final FacebookLogin fbLogin=FacebookLogin();
final GoogleSignIn _googleSignIn=GoogleSignIn();
Map facebookProfile;

class _RegisterState extends State<Register> {
  final email=TextEditingController();
  String emailError;
  final password=TextEditingController();
  String passwordError;
  bool seePassword=true;
  final confirmpassword=TextEditingController();
  String confirmpasswordError;
  bool seeConfirmPassword=true;

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
                // fit: BoxFit.fitWidth,
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
                  onPressed:() async{
                    setState(() async{
                      try{
                        await Firebase.initializeApp();
                        final CollectionReference tuser=FirebaseFirestore.instance.collection('email');
                        final user=await _googleSignIn.signIn();
                        final googleAuth = await user.authentication;
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth.accessToken,
                          idToken: googleAuth.idToken
                        );
                        FirebaseFirestore.instance.collection('email').where('gmail', isEqualTo:user.email).get().then((querySnapshot) async{
                          if(querySnapshot.docs.isNotEmpty){
                            Fluttertoast.showToast(
                              msg: "The email has been registered before, please try again with other email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 13.0);
                          }
                          else if(querySnapshot.docs.isEmpty){
                            await FirebaseAuth.instance.signInWithCredential(credential);
                            await tuser.add({'gmail':user.email});
                            Navigator.pushReplacementNamed(context, '/signup',arguments: {'email':user.email});
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
                onPressed: () async{
                  setState(() {
                  });
                  final FacebookLoginResult result=await fbLogin.logInWithReadPermissions(['email']);
                  // final FacebookLoginResult result=await fbLogin.logIn(['email']);
                  print("result as $result");
                  switch(result.status){
                    case FacebookLoginStatus.loggedIn:
                      final token=result.accessToken.token;
                      // final FacebookAccessToken accessToken=result.accessToken;
                      // print(accessToken.userId);
                      final graphResponse=await http.get('https://graph.facebook.com/v2.12/me?fields=name,email&access_token=$token');
                      final profile=json.decode(graphResponse.body);
                      setState(() {
                        facebookProfile=profile;
                      });
                      print(facebookProfile);
                      Navigator.pushReplacementNamed(context, '/signup', arguments: {
                        'email': facebookProfile['email']
                      });
                      break;
                    case FacebookLoginStatus.error:
                      setState(() {
                        Fluttertoast.showToast(msg: ErrorDescription(result.errorMessage.toString()).toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                        );
                      });
                  }
                },
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
                margin: EdgeInsets.fromLTRB(30, 15, 30, 10),
                child: TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  showCursor: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    hintText: 'Your Email',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14
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
              // PASSWORD
              Container(
                margin: EdgeInsets.fromLTRB(30,15,30,10),
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
              // CONFIRM PASSWORD
              Container(
                margin: EdgeInsets.fromLTRB(30, 15, 30, 25),
                child: TextFormField(
                  controller: confirmpassword,
                  showCursor: true,
                  obscureText: seeConfirmPassword,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
              SignInButtonBuilder(
                icon: Icons.email,
                text: 'Continue with your Email',
                backgroundColor: Colors.grey[500],
                splashColor: Colors.grey[600],
                onPressed: () async{
                    RegExp rgEmail=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
                    RegExp rg=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if(email.text.length<1){
                      emailError='Field cannot be empty';
                    }
                    else{
                      if(rgEmail.hasMatch(email.text)){
                        emailError=null;
                        if(password.text.length<8||password.text.length>20){
                          passwordError='Password must be between 8 to 20 characters';
                        }
                        else{
                          if(!rg.hasMatch(password.text)){
                            passwordError='Need an uppercase, lowercase, number, and special character';
                          }
                          else{
                            if(confirmpassword.text!=password.text){
                              confirmpasswordError='This does not match your password';
                            }
                            else{
                              setState(() async {
                                try{
                                  await Firebase.initializeApp();
                                  final CollectionReference tuser=FirebaseFirestore.instance.collection('email');
                                  User user=FirebaseAuth.instance.currentUser;
                                  UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: (email.text), password: password.text);
                                  if(!user.emailVerified){
                                    await user.sendEmailVerification();
                                    tuser.add({'gmail':email.text});
                                  }
                                  Navigator.pushReplacementNamed(context, '/signup',arguments: {'email',email.text});
                                }catch(e){
                                  if(e.code=='email-already-in-use'){
                                      Fluttertoast.showToast(
                                        msg: "This email has been used, please try with other email",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 13.0
                                      );
                                    }else{
                                    print(e);
                                  }
                                }
                              });
                            }
                          }
                        }
                      }
                      else{
                        emailError='Please enter a valid email';
                      }
                    }
                },
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
// try{
// await Firebase.initializeApp();
// UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: g, password: password.toString());
// final CollectionReference user=FirebaseFirestore.instance.collection('users');
// user.add({
// 'email':g,
// 'role':custChoice==0?'parent':'babysitter',
// 'username':username.text,
// 'phone':phone.text
// });
// print('xxxxx');
// Fluttertoast.showToast(
// msg: "Account created",
// toastLength: Toast.LENGTH_SHORT,
// gravity: ToastGravity.BOTTOM,
// backgroundColor: Colors.black,
// textColor: Colors.white,
// fontSize: 13.0
// );
// }on FirebaseAuthException catch(e){
// if(e.code=='email-already-in-use'){
// Fluttertoast.showToast(
// msg: "This email has been used, please try with other email",
// toastLength: Toast.LENGTH_SHORT,
// gravity: ToastGravity.BOTTOM,
// backgroundColor: Colors.black,
// textColor: Colors.white,
// fontSize: 13.0
// );
// }else{
// print(e);
// }