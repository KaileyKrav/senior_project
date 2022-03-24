import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/calendar.dart';
import 'package:senior_project/camera_bpm/calc_heart.dart';
import 'package:senior_project/test_calendar.dart';
import 'auth_controller.dart';
import 'google_sign_in.dart';
import 'med_list.dart';

//Using sample UI from a tutorial, Will change later
class WelcomePage extends StatelessWidget {
  String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHeart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalcHeartPage()));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                  //backgroundColor: Colors.white70,
                  radius: 60,
                  backgroundImage: AssetImage(
                      "img/ProfilePictureMaker.png"
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 70,),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style:TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  email,
                  style:TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100,),
          GestureDetector(
            onTap: () {
              //final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              //provider.googleLogOut();
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
          ),
          SizedBox(height: 50,),
          /*GestureDetector(
            onTap: () {
              _navigateToNextScreen(context);
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
                    "Next Page",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color:Colors.white,
                    )
                ),
              ),
            ),
          ),*/
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () {
              _navigateToList(context);
            }),
            Spacer(),
            IconButton(icon: Icon(Icons.calendar_today), onPressed: () {
              _navigateToCalendar(context);
            }),
            IconButton(icon: Icon(Icons.favorite), onPressed: () {
              _navigateToHeart(context);
            }),
          ],
        ),
      ),
    );
  }
}
