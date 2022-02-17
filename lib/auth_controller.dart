import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:senior_project/camera_bpm/calc_heart.dart';
import 'package:senior_project/google_welcome_page.dart';
import 'package:senior_project/welcome_page.dart';

import 'login_page.dart';

class AuthController extends GetxController {
  bool pass = false;
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    /*for (UserInfo user in FirebaseAuth.instance.currentUser!.providerData) {
      if (user.providerId == "password") {
        pass = true;
      }
    }*/
    if(user == null) {
      print("login page");
      Get.offAll(()=>LoginPage());
    }
    //else if (pass == false){
      //Get.offAll(()=>GoogleWelcomePage());
    //}
    else {
      Get.offAll(()=>WelcomePage(email:user.email!));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    }
    catch(e) {
      Get.snackbar("About User", "User message",
      backgroundColor: Colors.redAccent,
      snackPosition: SnackPosition.BOTTOM,
      titleText: Text(
        "Account creation failed",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }
  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }
    catch(e) {
      Get.snackbar("About Login", "Login message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Logint failed",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }
  void logOut()async{
    await auth.signOut();
  }
}