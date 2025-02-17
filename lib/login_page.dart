import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/auth_controller.dart';
import 'package:senior_project/google_sign_in.dart';
import 'package:senior_project/signup_page.dart';

import 'camera_bpm/calc_heart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
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
                    "Hello",
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(71, 96, 101, 1.0),
                    ),
                  ),
                  Text(
                      "Sign in to your account",
                      style: TextStyle(
                          fontSize: 20,
                          color:Colors.grey[500]
                      ),
                  ),
                  SizedBox(height: 40,),
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
                            prefixIcon: Icon(Icons.password, color:Color.fromRGBO(240, 172, 159, 1.0)),
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
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(240, 172, 159, 1.0),
                    shape: StadiumBorder(),
                ),
                onPressed: (){
                  AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
                },
              child: const Text('Sign In', style: TextStyle(
              fontSize: 40,),
            ),
            ),
            SizedBox(height: w * 0.1),
            RichText(text: TextSpan(
              text: "Don't have an account?",
              style: TextStyle(
                color:Colors.grey[500],
                fontSize: 20,
              ),
              children: [
                TextSpan(
                text: " Create",
                  //text: "Heart Rate Test",
                style: TextStyle(
                  color:Color.fromRGBO(71, 96, 101, 1.0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage())
                ),
              ]
            ),
            ),
          ],
        ),
    );
  }
}
