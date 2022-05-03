import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:senior_project/test_calendar.dart';
import 'package:senior_project/welcome_page.dart';

import 'add_med.dart';
import 'camera_bpm/calc_heart.dart';
import 'medication_events/details_page.dart';

class MedList extends StatelessWidget {

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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMed()));
  }

  Icon medIcon(String s) {
    if (s == ('p')) {
      return Icon(Icons.remove_circle_outline);
    }
    else {
      return Icon(Icons.medication);
    }
  }

  AssetImage medImage() {
      return AssetImage('img/outline_vaccines_black_24dp.png');
  }

  final db = FirebaseFirestore.instance;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                    onTap: () {
                      _navigateToNextScreen(context);
                    },
                    child: Icon(Icons.add, color: Colors.grey,)
                ),
              ),
            ],
            backgroundColor: Colors.white,
          ),
      Container(
        child: Text('Your Medications', style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(240, 172, 159, 1.0),
        ),),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 20, left: 10),
      ),
      Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                List<String> medDays = List.from(doc['Days']);
                String days(){
                  String daysList = ' ';
                 for (String day in medDays) {
                  daysList = daysList + day + ' ';
                }
                return daysList;}
                if (doc['MedType'] == ('Pill')) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.remove_circle_outline, color: Colors.black, size: 40,),
                      title: Text(doc['MedName']),
                      subtitle: Row(
                        children: [ Container(
                          child: Text(days(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(139, 193, 188, 1),
                              borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        ),
                          Spacer(),
                          Container(
                            child: Text(doc['Quantity'].toString() + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(139, 193, 188, 1),
                                borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                          Spacer(),
                          Container(
                            child: Text(doc['Time'].toString() + ' a Day', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(139, 193, 188, 1),
                                borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          )
                        ],
                      ),
                      onTap: () {
                        var docID = doc.id;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(docID)));
                      },
                      ),
                    );
                }
                else if (doc['MedType'] == ('Liquid')) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.medication, color: Colors.black, size: 40,),
                      title: Text(doc['MedName']),
                      subtitle: Row(
                        children: [ Container(
                        child: Text(days(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(139, 193, 188, 1),
                            borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      ),
                          Spacer(),
                          Container(
                            child: Text(doc['Quantity'].toString() + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(139, 193, 188, 1),
                                  borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                          Spacer(),
                          Container(
                            child: Text(doc['Time'].toString() + ' a Day', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(139, 193, 188, 1),
                                borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                        ],
                      ),
                      onTap: () {
                        var docID = doc.id;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(docID)));
                      },
                    ),
                  );
                }
                else {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                        AssetImage("img/outline_vaccines_black_24dp.png"),
                        backgroundColor: Colors.white,
                        radius: 20,
                      ),
                      title: Text(doc['MedName']),
                      subtitle: Row(
                        children: [ Container(
                          child: Text(days(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(139, 193, 188, 1),
                              borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        ),
                          Spacer(),
                          Container(
                            child: Text(doc['Quantity'].toString() + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(139, 193, 188, 1),
                                borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                          Spacer(),
                          Container(
                            child: Text(doc['Time'].toString() + ' a Day', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(139, 193, 188, 1),
                                borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                        ],
                      ),
                      onTap: () {
                        var docID = doc.id;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(docID)));
                      },
                    ),
                  );
                }
              }).toList(),
            );
        },
      ),
      ),
      ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNextScreen(context);
        },
        backgroundColor: Colors.cyanAccent,
        child: const Icon(Icons.add),
      ),*/
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