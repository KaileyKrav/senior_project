import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: /*Column(
        children: [
          Container(
              width: w,
              height: h * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "img/svg.png"
                      ),
                      fit: BoxFit.cover
                  ),
              ),
            child: Column(
              children: [
                SizedBox(height: h * 0.14,),
                CircleAvatar(
                  backgroundColor: Colors.white70,
                  radius: 60,
                  backgroundImage: AssetImage(
                    "img/ProfilePictureMaker.png"
                  ),
                ),
              ],
            ),
          ),*/
      Column(
        children: [
          Container(
            width: w,
            height: h * 0.3,
            child: Lottie.asset(
                'img/lf30_editor_beeaz8xs.json',
                repeat: true,
                fit: BoxFit.cover
            ),
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(left:20, right:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(71, 96, 101, 1.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(left:20, right:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60,),
                Container(
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color:Colors.grey.withOpacity(0.2)
                        )
                      ]
                  ),
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                          prefixIcon: Icon(Icons.email, color:Color.fromRGBO(240, 172, 159, 1.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color:Colors.white,
                                width: 1.0
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color:Colors.white,
                                width: 1.0
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      )
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 1),
                            color:Colors.grey.withOpacity(0.2)
                        )
                      ]
                  ),
                  child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password_outlined, color:Color.fromRGBO(240, 172, 159, 1.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color:Colors.white,
                                width: 1.0
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color:Colors.white,
                                width: 1.0
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      )
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 70,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(240, 172, 159, 1.0),
              shape: StadiumBorder(),
            ),
            onPressed: (){
              auth.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()).then((value) {
                FirebaseFirestore.instance.collection("UserData").doc(value.user?.uid).set({
                  "email": value.user?.email
                });
              }
              );
            },
            child: Icon(Icons.arrow_forward, size: 50, color: Colors.white,)
          ),
          /*GestureDetector(
            onTap: () {
              auth.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim()).then((value) {
                    FirebaseFirestore.instance.collection("UserData").doc(value.user?.uid).set({
                      "email": value.user?.email
                    });
              }
              );
              //AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
            },
            child: Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage(
                          "img/mesh.png"
                      ),
                      fit: BoxFit.cover
                  ),
                ),
                child: Center(
                  child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                      )
                  ),
                )
            ),
          ),*/
          SizedBox(height: 10,),
          RichText(
            text:TextSpan(
              recognizer:TapGestureRecognizer()..onTap=()=>Get.back(),
              text:"Have an account?",
              style: TextStyle(
                fontSize: 20,
                color:Colors.grey[500]
              ),
            ),
          ),
          SizedBox(height: w * 0.1),
      ],
      ),
    );
  }
}
