import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:senior_project/login_page.dart';

class Splash extends StatelessWidget {

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Lottie.asset(
                'img/lf30_editor_ky0deoft.json',
                repeat: true
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            //padding: EdgeInsets.only(top: 20,),
            child: const Image(
              image: AssetImage('img/Logo.png'),
              height: 190,
              width: 300,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(240, 172, 159, 1.0)
              ),
              onPressed: () {
                _navigateToLogin(context);
              },
              child: const Text('Get Started', style: TextStyle(
                fontSize: 30,
              ),),
            ),
          )
        ],
        ),
      ),
    );
  }
}