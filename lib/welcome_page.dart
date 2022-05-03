import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:senior_project/bld_pressure_graphs.dart';
import 'package:senior_project/heart_graphs.dart';
import 'package:senior_project/os_graphs.dart';
import 'package:senior_project/profile.dart';
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

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DateTime now = DateTime.now();
    String todayDate = DateFormat('yMd').format(now);

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
                      _navigateToProfile(context);
                    },
                    child: Icon(Icons.account_circle_outlined, color: Colors.grey,)
                ),
              ),
            ],
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 50,),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style:TextStyle(
                    fontSize: 25,
                    color: Color.fromRGBO(139, 193, 188, 1),
                  ),
                ),
                Text(
                  "Today's Data",
                  style:TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(97, 135, 131, 1),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
          ),
          Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('HeartRate').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView(
                              shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs.map((doc) {
                                int arrayLength = doc['Data'].length;
                                for (int i = 0; i < arrayLength; i++) {
                                  var checkDate1 = DateTime.parse(
                                      doc['Data'][i]['Time'].toDate().toString()).toUtc();
                                  String checkDate2 = DateFormat('yMd').format(
                                      checkDate1);
                                  if (checkDate2 == todayDate) {
                                    return Container(
                                      child:Card(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.favorite, color: Color.fromRGBO(240, 172, 159, 1.0), size: 60,),
                                              title: Text(doc['Data'][i]['BPM'].toString(), style: TextStyle(
                                                fontSize: 30,
                                              ),),
                                              subtitle: Text('bpm', style: TextStyle(
                                                fontSize: 20,
                                              ),),
                                              trailing: /*Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        "img/heartRateLine.png"
                                                    ),
                                                    //fit: BoxFit.scaleDown
                                                  ),
                                                ),
                                                width: 100,
                                                height: 100,
                                              ),*/
                                        Container(
                                        //width: 50,
                                        height: 100,
                                        child: Lottie.asset(
                                            'img/rate.json',
                                            repeat: true,
                                            fit: BoxFit.scaleDown
                                        ),
                                      ),
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => HeartGraphs()));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: 100,
                                      padding: EdgeInsets.only(left: 50, right: 50),
                                    );
                                  }
                                }
                                return Container(
                                  child:Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.favorite, color: Color.fromRGBO(240, 172, 159, 1.0), size: 60,),
                                          title: Text('--', style: TextStyle(
                                            fontSize: 30,
                                          ),),
                                          subtitle: Text('bpm', style: TextStyle(
                                            fontSize: 20,
                                          ),),
                                          trailing: /*Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "img/heartRateLine.png"
                                                ),
                                                //fit: BoxFit.scaleDown
                                              ),
                                            ),
                                            width: 100,
                                            height: 100,
                                          ),*/
                                    Container(
                                    //width: 50,
                                    height: 100,
                                    child: Lottie.asset(
                                        'img/rate.json',
                                        repeat: true,
                                        fit: BoxFit.scaleDown
                                    ),
                                  ),
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => HeartGraphs()));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  height: 100,
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
          Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('BloodPressure').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs.map((doc) {
                                int arrayLength = doc['Data'].length;
                                for (int i = 0; i < arrayLength; i++) {
                                  var checkDate1 = DateTime.parse(
                                      doc['Data'][i]['Time'].toDate().toString()).toUtc();
                                  String checkDate2 = DateFormat('yMd').format(
                                      checkDate1);
                                  if (checkDate2 == todayDate) {
                                    return Container(
                                      child:Card(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.bloodtype_outlined, color: Color.fromRGBO(240, 172, 159, 1.0), size: 60,),
                                              title: Text(doc['Data'][i]['SYS'].toString() + ' / ' + doc['Data'][i]['DIA'].toString(), style: TextStyle(
                                                fontSize: 20,
                                              ),),
                                              subtitle: Text('sys/dia', style: TextStyle(
                                                fontSize: 15,
                                              ),),
                                              trailing: Container(
                                                //width: 100,
                                                height: 200,
                                                child: Lottie.asset(
                                                    'img/pressure.json',
                                                    repeat: true,
                                                    fit: BoxFit.scaleDown
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => BloodPressureGraphs()));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: 100,
                                      padding: EdgeInsets.only(left: 50, right: 50),
                                    );
                                  }
                                }
                                return Container(
                                  child:Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.bloodtype_outlined, color: Color.fromRGBO(240, 172, 159, 1.0), size: 60,),
                                          title: Text('--/--', style: TextStyle(
                                            fontSize: 30,
                                          ),),
                                          subtitle: Text('sys/dia', style: TextStyle(
                                            fontSize: 25,
                                          ),),
                                          trailing: Container(
                                            //width: 100,
                                            height: 200,
                                            child: Lottie.asset(
                                                'img/pressure.json',
                                                repeat: true,
                                                fit: BoxFit.scaleDown
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => BloodPressureGraphs()));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  height: 100,
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
          Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('OxygenSaturation').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs.map((doc) {
                                int arrayLength = doc['Data'].length;
                                for (int i = 0; i < arrayLength; i++) {
                                  var checkDate1 = DateTime.parse(
                                      doc['Data'][i]['Time'].toDate().toString()).toUtc();
                                  String checkDate2 = DateFormat('yMd').format(
                                      checkDate1);
                                  if (checkDate2 == todayDate) {
                                    return Container(
                                      child:Card(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.bubble_chart_outlined, color: Color.fromRGBO(240, 172, 159, 1.0), size: 60,),
                                              title: Text(doc['Data'][i]['OS'].toString() + '%', style: TextStyle(
                                                fontSize: 30,
                                              ),),
                                              subtitle: Text('spo2', style: TextStyle(
                                                fontSize: 20,
                                              ),),
                                              trailing: Container(
                                                //width: 100,
                                                height: 200,
                                                child: Lottie.asset(
                                                    'img/bubbles.json',
                                                    repeat: true,
                                                    fit: BoxFit.scaleDown
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => OxygenSaturationGraphs()));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      height: 100,
                                      padding: EdgeInsets.only(left: 50, right: 50),
                                    );
                                  }
                                }
                                return Container(
                                  child:Card(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(Icons.favorite, color: Color.fromRGBO(240, 172, 159, 1.0), size: 60,),
                                          title: Text('--%', style: TextStyle(
                                            fontSize: 30,
                                          ),),
                                          subtitle: Text('spo2', style: TextStyle(
                                            fontSize: 20,
                                          ),),
                                          trailing: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "img/heartRateLine.png"
                                                ),
                                                //fit: BoxFit.scaleDown
                                              ),
                                            ),
                                            width: 100,
                                            height: 100,
                                          ),
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => OxygenSaturationGraphs()));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  height: 100,
                                  padding: EdgeInsets.only(left: 50, right: 50),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
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
          ],
        ),
      ),
    );
  }
}
