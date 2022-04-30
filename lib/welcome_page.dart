import 'package:flutter/material.dart';
import 'package:senior_project/splash.dart';
import 'package:senior_project/test_calendar.dart';
import 'auth_controller.dart';
import 'med_list.dart';

class WelcomePage extends StatelessWidget {
  /*String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);*/

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Splash()));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                    onTap: () {
                      //_navigateToBluetooth(context);
                    },
                    child: Icon(Icons.account_circle_outlined, color: Colors.grey,)
                ),
              ),
            ],
            backgroundColor: Colors.white,
          ),
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
                /*Text(
                  email,
                  style:TextStyle(
                    fontSize: 18,
                    color: Colors.grey[500],
                  ),
                ),*/
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
