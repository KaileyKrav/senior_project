import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior_project/test_calendar.dart';

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

  void _navigateToHeart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalcHeartPage()));
  }

  void _navigateToNextScreen(BuildContext context) {
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Calendar()));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMed()));
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
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
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        ),
                          Spacer(),
                          Container(
                            child: Text(doc['Quantity'].toString() + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                          Spacer(),
                          Container(
                            child: Text(doc['Time'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Colors.lightBlue,
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
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      ),
                          Spacer(),
                          Container(
                            child: Text(doc['Quantity'].toString() + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                          Spacer(),
                          Container(
                            child: Text(doc['Time'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Colors.lightBlue,
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
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        ),
                          Spacer(),
                          Container(
                            child: Text(doc['Quantity'].toString() + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          ),
                          Spacer(),
                          Container(
                            child: Text(doc['Time'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            decoration: const BoxDecoration(
                                color: Colors.lightBlue,
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
                /*return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      AssetImage("img/pills_graphic.png"),
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    title: Text(doc['MedName']),
                  ),
                );*/
              }).toList(),
            );
        },
      ),
      ),
      ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNextScreen(context);
        },
        backgroundColor: Colors.cyanAccent,
        child: const Icon(Icons.add),
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















/*class MedList extends StatefulWidget {
  @override
  _MedListState createState() => _MedListState();
}

class _MedListState extends State<MedList> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  /*Future getPosts() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("posts").get();

    return qn.docs;
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      StreamBuilder<QuerySnapshot>(
        stream: db.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Card(
                  child: ListTile(
                    title: Text(doc['title']),
                  ),
                );
              }).toList(),
            );
        },
      ),
      /*FutureBuilder(builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Loading..."),
          );
        }
        else {
          return ListView.builder(
          itemCount: snapshot.data.length,
              itemBuilder: (_, index) {

            return ListTile(
              title: Text(snapshot.data[index]["title"]),
            );
          });
        }
    }
      ),*/
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/



/*class MedList extends StatelessWidget {

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHeart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalcHeartPage()));
  }

  void _navigateToNextScreen(BuildContext context) {
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Calendar()));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMed()));
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
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
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              ),
                                Spacer(),
                                Container(
                                  child: Text(doc['Quantity'] + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                ),
                                Spacer(),
                                Container(
                                  child: Text(doc['Time'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
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
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              ),
                                Spacer(),
                                Container(
                                  child: Text(doc['Quantity'] + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                ),
                                Spacer(),
                                Container(
                                  child: Text(doc['Time'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
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
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                              ),
                                Spacer(),
                                Container(
                                  child: Text(doc['Quantity'] + ' ' + doc['Units'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                ),
                                Spacer(),
                                Container(
                                  child: Text(doc['Time'], style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  decoration: const BoxDecoration(
                                      color: Colors.lightBlue,
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
                      /*return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      AssetImage("img/pills_graphic.png"),
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    title: Text(doc['MedName']),
                  ),
                );*/
                    }).toList(),
                  );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNextScreen(context);
        },
        backgroundColor: Colors.cyanAccent,
        child: const Icon(Icons.add),
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
*/