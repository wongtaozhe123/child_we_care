import 'dart:io';
import 'dart:ui';
import 'package:child_we_care/ChooseRole.dart';
import 'package:child_we_care/main.dart';
import 'package:child_we_care/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_we_care/register.dart';
import 'package:child_we_care/login.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context) => SplashScreen(),
    '/chooseRole':(context) =>ChooseRole(),
    '/register':(context) => Register(),
    '/signup':(context) => SignUp(),
    '/login':(context) => Login(),
    '/home':(context) => Home(),
  },
  // home: SignUp(),
));

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _SignUpState extends State<SignUp> {
  bool parent=false;
  bool babysitter=false;
  final username=TextEditingController();
  String usernameError;
  final phone=TextEditingController();
  String phoneError;
  final address=TextEditingController();
  String addressError;
  String state="Kuala Lumpur";
  final city=TextEditingController();
  String cityError;
  final postcode=TextEditingController();
  String postcodeError;
  final address1=TextEditingController();
  String address1Error;
  int custChoice=3;
  bool chkboxval=false;
  File _img;
  bool progress=false;

  @override
  Widget build(BuildContext context) {
    Future cameraImage() async{
      // ignore: deprecated_member_use
      final img=await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _img=File(img.path);
      });
    }
    Future galleryImage() async{
      // ignore: deprecated_member_use
      final img=await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _img=File(img.path);
      });
    }
    Future uploadPic2Firebase(BuildContext context) async{
      String filename=basename(_img.path);
      Reference firebaseStorageRef=FirebaseStorage.instance.ref().child('profilePic/$filename');
      UploadTask uploadTask = firebaseStorageRef.putFile(_img);
      TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then((value)=>print('Done $value'));
    }

    Map gTemp=ModalRoute.of(context).settings.arguments;
    String g=gTemp['email'];
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/childwecare.png'),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                child: Text(
                  'Setup your account!!',
                  style: TextStyle(
                    fontFamily: 'Prompt-Thin',
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo_rounded),
                      color: Colors.black87,
                      splashColor: Colors.grey,
                      onPressed: () {
                        cameraImage();
                      },
                    ),
                  ),
                  Container(
                    child: ClipOval(
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                          child: InkWell(
                            child: Image(
                              image: (_img == null)? AssetImage('assets/defaultUser.png'):FileImage(_img),
                              width: 140,
                              height: 140,
                            ),
                            onTap: (){

                            },
                          ),
                        )
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.photo),
                      color: Colors.black87,
                      splashColor: Colors.grey,
                      onPressed: (){
                        galleryImage();
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Container(
                child: Text(
                    '$g'
                ),
              ),
              SizedBox(height: 25,),
              Container(
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

              progress?CircularProgressIndicator():Container(),

              // USERNAME
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.fromLTRB(30,20,30,10),
                child: TextFormField(
                  controller: username,
                  showCursor: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
              //  PHONE
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 10),
                child: TextFormField(
                  controller: phone,
                  showCursor: true,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
              // DROP DOWN LIST STATE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(25, 0, 0, 10),
                    child: FindDropdown(
                      items: ['Johor','Kedah','Kelantan','Kuala Lumpur','Labuan','Malacca','Negeri Sembilan','Pahang','Penang',
                      'Perak','Perlis','Putrajaya','Sabah','Sarawak','Terengganu'],
                      label: "State",
                      onChanged: (item){
                        print(state);
                        state=item;
                        print(state);
                      },
                      selectedItem: 'Kuala Lumpur',
                      labelStyle: TextStyle(
                        fontSize: 13
                      ),
                    ),
                  ),
                  Container(
                    height: 65,
                    width: 140,
                    margin: EdgeInsets.fromLTRB(0, 40, 25, 10),
                    child: TextFormField(
                      controller: postcode,
                      showCursor: true,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Post code',
                        hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14
                        ),
                        filled: true,
                        fillColor: Colors.white60.withOpacity(0.6),
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
                        errorText: postcodeError,
                      ),
                    ),
                  )
                ],
              ),
              // FILL IN CITY
              Container(
                margin: EdgeInsets.fromLTRB(30,20,30,10),
                child: TextFormField(
                  controller: city,
                  showCursor: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    hintText: 'City',
                    hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14
                    ),
                    filled: true,
                    fillColor: Colors.white60.withOpacity(0.6),
                    suffixIcon: Icon(Icons.location_on_outlined),
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
                    errorText: cityError,
                  ),
                ),
              ),
              // FILL IN ADDRESS
              Container(
                margin: EdgeInsets.fromLTRB(30,20,30,10),
                child: TextFormField(
                  controller: address1,
                  showCursor: true,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    hintText: 'Address',
                    hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14
                    ),
                    filled: true,
                    fillColor: Colors.white60.withOpacity(0.6),
                    suffixIcon: Icon(Icons.home),
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
                    errorText: address1Error,
                  ),
                ),
              ),
              // REGISTER BUTTON
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
                    'CREATE ACCOUNT',
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
                      RegExp rg=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      RegExp rgContact=RegExp(r'(^(?:[+01])?[0-9]{10,11}$)');
                      // RegExp rgEmail=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
                      RegExp rgNum=RegExp(r'^([0-9]){5}$');
                      if(custChoice==3){
                        Fluttertoast.showToast(
                            msg: "Please select role as Parent or Babysitter",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 13.0
                        );
                      }else{
                        if(username.text.length<1){
                          usernameError='This field cannot be left empty';
                        }
                        else{
                          if(phone.text.length<1){
                            phoneError='This field cannot be left empty';
                          }
                          else{
                            if(!rgContact.hasMatch(phone.text)){
                              phoneError='Please enter a valid phone number';
                            }
                            else{
                              if(postcode.text.length<1){
                                postcodeError='Post Code must be 5 digits';
                              }
                              else{
                                if(!rgNum.hasMatch(postcode.text)){
                                  postcodeError='Please enter a valid post code';
                                }
                                else{
                                  if(city.text.length<1){
                                    cityError='This field cannot be left empty';
                                  }
                                  else{
                                    if(address1.text.length<1){
                                      address1Error='This field cannot be left empty';
                                    }
                                    else{
                                      setState(() async{
                                        try{
                                          final CollectionReference user=FirebaseFirestore.instance.collection('users');
                                          setState(() {
                                            progress=true;
                                          });
                                          FirebaseFirestore.instance.collection('users').where('email', isEqualTo:g).get().then((querySnapshot) async{
                                            if(querySnapshot.docs.isNotEmpty){
                                              Fluttertoast.showToast(
                                                  msg: 'Account has been created',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 13.0
                                              );
                                              setState(() {
                                                progress=false;
                                              });
                                              Navigator.pushReplacementNamed(context, '/home', arguments: {'email':g});
                                            }
                                            else{
                                              if(_img!=null){
                                                uploadPic2Firebase(context);
                                              }
                                              user.add({
                                                'email':g,
                                                'role':custChoice==0?'parent':'babysitter',
                                                'username':username.text,
                                                'phone':phone.text,
                                                'postcode':postcode.text,
                                                'city':city.text,
                                                'address':address1.text,
                                                'image':_img==null?'null':_img.path.toString()
                                              });
                                              Fluttertoast.showToast(
                                                  msg: 'Thank your for creating an account with us',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                  fontSize: 13.0
                                              );
                                              setState(() {
                                                progress=false;
                                              });
                                              Navigator.pushReplacementNamed(context, '/home', arguments: {'email':g});
                                            }
                                          });
                                        }catch(e){
                                          setState(() {
                                            progress=false;
                                          });
                                          Fluttertoast.showToast(
                                              msg: "$e",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 13.0
                                          );
                                        }
                                      });
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    });
                    setState(() {
                      progress=false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}