import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/auth_controller.dart';
import 'package:senior_project/google_sign_in.dart';
import 'package:senior_project/signup_page.dart';
import 'package:senior_project/test_calendar.dart';

import 'camera_bpm/calc_heart.dart';
import 'med_list.dart';

//Using sample UI from a tutorial, Will change later
class AddMed extends StatefulWidget {
  const AddMed({Key? key}) : super(key: key);

  @override
  _AddMedState createState() => _AddMedState();
}

class _AddMedState extends State<AddMed> {

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHeart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalcHeartPage()));
  }

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
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    //"img/loginimg.png"
                      "img/svg.png"
                  ),
                  fit: BoxFit.cover
              ),
            ),
          ),
          Container(
            width: w,
            margin: const EdgeInsets.only(left:20, right:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          hintText: "Medication Name",
                          //prefixIcon: Icon(Icons., color:Color.fromRGBO(252, 198, 205, 100)),
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
                          hintText: "Medication Type",
                          //prefixIcon: Icon(Icons.password, color:Color.fromRGBO(252, 198, 205, 100)),
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
                Row(
                    children: [
                      Expanded(child: Container(),),
                    ],
                ),
              ],
            ),
          ),
          SizedBox(height: 50,),
          GestureDetector(
            onTap: (){
              //AuthController.instance.login(emailController.text.trim(), passwordController.text.trim());
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
                      "Add",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                      )
                  ),
                )
            ),
          ),
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

