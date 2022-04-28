import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final docID;
  DetailsScreen(this.docID);

  @override
  State<StatefulWidget> createState() => _DetailsScreenState(docID);
}

class _DetailsScreenState extends State<DetailsScreen> {
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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
        ),
            Container(
              width: w,
                margin: const EdgeInsets.only(left:20, right:20),
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
                        Container(
                          width: w,
                          height: h * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: medPic(snapshot.data!['MedType']),
                                fit: BoxFit.contain,
                              )
                          ),
                        ),
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
                                      Text(snapshot.data!['Time'],
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
    );
  }
}