import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/google_welcome_page.dart';
import 'package:senior_project/signup_page.dart';
import 'package:senior_project/welcome_page.dart';

/*class LoadLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder:(context, snapshot) {
        final user = FirebaseAuth.instance.currentUser!;

        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasData) {
          return GoogleWelcomePage();
        }else if (snapshot.hasError) {
          return Center(child: Text('Something Went Wrong!'));
        }
        else {
          return SignUpPage();
        }
      },
    ),
  );
}*/