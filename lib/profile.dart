import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:senior_project/splash.dart';
import 'package:senior_project/test_calendar.dart';
import 'package:senior_project/welcome_page.dart';

import 'auth_controller.dart';
import 'med_list.dart';

class ProfilePage extends StatelessWidget {

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Splash()));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DateTime now = DateTime.now();

    return Scaffold(
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
      /*GestureDetector(
            onTap: () {
              AuthController.instance.logOut();
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
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                      )
                  ),
                ),
            ),
          ),*/
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(240, 172, 159, 1.0),
                ),
                onPressed: () {
                  AuthController.instance.logOut();
                },
                child: const Text('Log Out', style: TextStyle(
                  fontSize: 30,
                ),),
              ),
            )
    ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home_rounded, color: Colors.grey), onPressed: () {
              _navigateToHome(context);
            }),
            Spacer(),
            IconButton(icon: Icon(Icons.calendar_today, color: Colors.grey), onPressed: () {
              _navigateToCalendar(context);
            }),
            Spacer(),
            IconButton(icon: Icon(Icons.add_circle_outline, color: Colors.grey), onPressed: () {
              _navigateToList(context);
            }),
            Spacer(),
            IconButton(icon: Icon(Icons.sticky_note_2_outlined, color: Colors.grey), onPressed: () {
              //_navigateToHeart(context);
            }),
          ],
        ),
      ),
    );
  }
}