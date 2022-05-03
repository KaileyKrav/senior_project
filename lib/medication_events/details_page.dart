import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../med_list.dart';
import '../test_calendar.dart';
import '../welcome_page.dart';
import 'edit_med.dart';

class DetailsScreen extends StatefulWidget {
  final docID;
  DetailsScreen(this.docID);

  @override
  State<StatefulWidget> createState() => _DetailsScreenState(docID);
}

class _DetailsScreenState extends State<DetailsScreen> {

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


  final docID;
  _DetailsScreenState(this.docID);

  String? uid = FirebaseAuth.instance.currentUser?.uid;

  AssetImage medPic(String type) {
    if (type == 'Pill') {
      return AssetImage('img/pills_graphic.png');
    }
    else if (type == 'Liquid') {
      return AssetImage('img/bottle_graphic.png');
    }
    else {
      return AssetImage('img/shot_graphic.png');
    }
  }

  Container picture(String type) {
    if (type == 'Pill') {
      return Container(
        //width: 50,
        height: 200,
        child: Lottie.asset(
            'img/pill.json',
            repeat: true,
            fit: BoxFit.scaleDown
        ),
      );
    }
    else if (type == 'Liquid') {
      return Container(
        //width: 50,
        height: 200,
        child: Lottie.asset(
            'img/liquid.json',
            repeat: true,
            fit: BoxFit.scaleDown
        ),
      );
    }
    else {
      return Container(
        //width: 50,
        height: 200,
        child: Lottie.asset(
            'img/vaccine.json',
            repeat: true,
            fit: BoxFit.scaleDown
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditMed(docID)));
                      },
                      child: Icon(Icons.edit, color: Colors.grey,)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                      onTap: () {
                        FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').doc(docID).delete();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MedList()));
                      },
                      child: Icon(Icons.delete, color: Colors.grey,),
                  ),
                ),
              ],
              backgroundColor: Colors.white,
            ),
            Container(
              alignment: Alignment.center,
              width: w,
                margin: const EdgeInsets.only(left:20, right:20, top: 60),
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').doc(docID).snapshots(),
                builder: (BuildContext context, AsyncSnapshot <DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<String> medDays = List.from(snapshot.data!['Days']);
                    String days(){
                      String daysList = ' ';
                      for (String day in medDays) {
                        daysList = daysList + day + ' ';
                      }
                      return daysList;}
                    return Column(
                      children: [
                        picture(snapshot.data!['MedType']),
                        Container(
                          child: Text(
                            snapshot.data!['MedName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Text(
                            snapshot.data!['MedType'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: Row(
                            children: [
                              Card(
                                child: SizedBox(
                                  width: 150,
                                  height: 75,
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!['Quantity'].toString() + ' ' + snapshot.data!['Units'],
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                              ),
                              ),
                              Spacer(),
                              Card(
                                child: SizedBox(
                                  width: 150,
                                  height: 75,
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!['Time'].toString() + ' a day',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          child: Row(
                            children: [
                              Card(
                                child: SizedBox(
                                  width: 150,
                                  height: 75,
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!['StartDate'],
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Card(
                                child: SizedBox(
                                  width: 150,
                                  height: 75,
                                  child: Column(
                                    children: [
                                      Text(days(),
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                }
            ),
            ),
        ],
      ),
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