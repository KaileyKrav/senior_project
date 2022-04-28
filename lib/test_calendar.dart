import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/heart_graph.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

import 'camera_bpm/calc_heart.dart';
import 'heart_graphs.dart';
import 'med_list.dart';

class TestCalendar extends StatefulWidget {
  @override
  _TestCalendarState createState() => _TestCalendarState();
}

class _TestCalendarState extends State<TestCalendar> {
  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHeart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HeartGraphs()));
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  String? uid = FirebaseAuth.instance.currentUser?.uid;

  String weekday() {
    String weekdate = DateFormat('EEEEE').format(_focusedDay);
    switch (weekdate) {
      case 'Monday' : {
        weekdate = 'M';
      }
        break;
      case 'Tuesday' : {
        weekdate = 'T';
      }
      break;
      case 'Wednesday' : {
        weekdate = 'W';
      }
      break;
      case 'Thursday' : {
        weekdate = 'Th';
      }
      break;
      case 'Friday' : {
        weekdate = 'F';
      }
      break;
      case 'Saturday' : {
        weekdate = 'S';
      }
      break;
      case 'Sunday' : {
        weekdate = 'Sn';
      }
      break;
    }
    return weekdate;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      /*body: SlidingUpPanel(
      panelBuilder: (ScrollController sc) => _scrollingList(sc),
          //body: Center(
        //child: Text("This is the sliding Widget"),
        //),
      collapsed: Container(
        decoration: BoxDecoration(
          borderRadius: radius
        ),
      ),*/
    body: Column(
        children: [
          Container(
                width: w,
                height: h * 0.1,
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
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                    children: [
                      Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.all(8.0),
                  child: TableCalendar(
                    //body: TableCalendar(
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2050),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color:Colors.lightBlueAccent,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Colors.pink,
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                      SizedBox(height: 10,),
                      Container(
                        width: w,
                        height: h * 0.35,
                        child: ListView(
                          children: snapshot.data!.docs.map((doc) {
                            List<String> medDays = List.from(doc['Days']);
                            var today = false;
                            var quantityInt = int.parse(doc['Quantity'].toString());
                            assert(quantityInt is int);
                              for (String day in medDays) {
                                if (day == weekday()) {
                                  today = true;
                                  break;
                                }
                              }
                            if (doc['MedType'] == ('Pill') && today == true && quantityInt > 0) {
                              return Card(
                                child: ListTile(
                                  leading: Icon(Icons.remove_circle_outline, color: Colors.black, size: 40,),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Text(doc['MedName'], style: TextStyle(
                                    fontSize: 20,
                                  ),),
                                  ),
                                  subtitle: Container(
                                    //height: 50,
                                    child: Row(
                                    children: [
                                      AnimatedButton(
                                        height: 30,
                                        width: 70,
                                        text: 'Taken',
                                        isReverse: true,
                                        selectedTextColor: Colors.black,
                                        transitionType: TransitionType.LEFT_TO_RIGHT,
                                        backgroundColor: Colors.black,
                                        borderColor: Colors.black,
                                        borderRadius: 60,
                                        borderWidth: 1,
                                        onPress: () {
                                          var docID = doc.id;
                                          List myList = [
                                            {
                                              'Date': _selectedDay?.toUtc(),
                                              'Taken': 'Yes'
                                            }
                                          ];
                                          quantityInt--;
                                          FirebaseFirestore.instance.collection(
                                              'UserData').doc(uid).collection(
                                              'MedicationList')
                                              .doc(docID)
                                              .update({
                                            'Dates': FieldValue.arrayUnion(
                                                myList),
                                            'Quantity': quantityInt,
                                          },
                                          );
                                        },
                                      ),
                                      /*GestureDetector(
                                        onTap: (){
                                          var docID = doc.id;
                                          List myList =[{'Date': _focusedDay, 'Taken': 'Yes'}];
                                          FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').doc(docID).update({
                                            'Dates' : FieldValue.arrayUnion(myList),
                                          });
                                  },
                                  child: Container(
                                  child: Text('Taken', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(Radius.elliptical(10,10))
                                  ),
                                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                                    ),
                                      ),*/
                                      Spacer(),
                                      Container(
                                       child: AnimatedButton(
                                          height: 30,
                                          width: 70,
                                          text: 'Late',
                                          isReverse: true,
                                          selectedTextColor: Colors.black,
                                          transitionType: TransitionType.LEFT_TO_RIGHT,
                                          backgroundColor: Colors.black,
                                          borderColor: Colors.black,
                                          borderRadius: 60,
                                          borderWidth: 1,
                                          onPress: () {
                                            var docID = doc.id;
                                            List myList = [
                                              {
                                                'Date': _selectedDay?.toUtc(),
                                                'Taken': 'Late'
                                              }
                                            ];
                                            quantityInt--;
                                            FirebaseFirestore.instance.collection(
                                                'UserData').doc(uid).collection(
                                                'MedicationList')
                                                .doc(docID)
                                                .update({
                                              'Dates': FieldValue.arrayUnion(
                                                  myList),
                                              'Quantity': quantityInt,
                                            },
                                            );
                                          },
                                        ),
                                        ),
                                      Spacer(),
                                      Container(
                                        child: AnimatedButton(
                                          height: 30,
                                          width: 70,
                                          text: 'Missed',
                                          isReverse: true,
                                          selectedTextColor: Colors.black,
                                          transitionType: TransitionType.LEFT_TO_RIGHT,
                                          backgroundColor: Colors.black,
                                          borderColor: Colors.black,
                                          borderRadius: 60,
                                          borderWidth: 1,
                                          onPress: () {
                                            var docID = doc.id;
                                            List myList = [
                                              {
                                                'Date': _selectedDay?.toUtc(),
                                                'Taken': 'No'
                                              }
                                            ];
                                            FirebaseFirestore.instance.collection(
                                                'UserData').doc(uid).collection(
                                                'MedicationList')
                                                .doc(docID)
                                                .update({
                                              'Dates': FieldValue.arrayUnion(
                                                  myList),
                                              'Quantity': quantityInt,
                                            },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  ),
                                ),
                              );
                            }
                            else if (doc['MedType'] == ('Liquid') && today == true && quantityInt > 0){
                              return Card(
                                child: ListTile(
                                  leading: Icon(Icons.medication, color: Colors.black, size: 40,),
                                  title: Text(doc['MedName']),
                                  subtitle: Container(
                                    //height: 70,
                                    child: Row(
                                    children: [ Container(
                                      child: AnimatedButton(
                                        height: 30,
                                        width: 70,
                                        text: 'Taken',
                                        isReverse: true,
                                        selectedTextColor: Colors.black,
                                        transitionType: TransitionType.LEFT_TO_RIGHT,
                                        backgroundColor: Colors.black,
                                        borderColor: Colors.black,
                                        borderRadius: 60,
                                        borderWidth: 1,
                                        onPress: () {
                                          var docID = doc.id;
                                          List myList = [
                                            {
                                              'Date': _selectedDay?.toUtc(),
                                              'Taken': 'Yes'
                                            }
                                          ];
                                          quantityInt--;
                                          FirebaseFirestore.instance.collection(
                                              'UserData').doc(uid).collection(
                                              'MedicationList')
                                              .doc(docID)
                                              .update({
                                            'Dates': FieldValue.arrayUnion(
                                                myList),
                                            'Quantity': quantityInt,
                                          },
                                          );
                                        },
                                      ),
                                    ),
                                      Spacer(),
                                      Container(
                                        child: AnimatedButton(
                                          height: 30,
                                          width: 70,
                                          text: 'Late',
                                          isReverse: true,
                                          selectedTextColor: Colors.black,
                                          transitionType: TransitionType.LEFT_TO_RIGHT,
                                          backgroundColor: Colors.black,
                                          borderColor: Colors.black,
                                          borderRadius: 60,
                                          borderWidth: 1,
                                          onPress: () {
                                            var docID = doc.id;
                                            List myList = [
                                              {
                                                'Date': _selectedDay?.toUtc(),
                                                'Taken': 'Late'
                                              }
                                            ];
                                            quantityInt--;
                                            FirebaseFirestore.instance.collection(
                                                'UserData').doc(uid).collection(
                                                'MedicationList')
                                                .doc(docID)
                                                .update({
                                              'Dates': FieldValue.arrayUnion(
                                                  myList),
                                              'Quantity': quantityInt,
                                            },
                                            );
                                          },
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: AnimatedButton(
                                          height: 30,
                                          width: 70,
                                          text: 'Missed',
                                          isReverse: true,
                                          selectedTextColor: Colors.black,
                                          transitionType: TransitionType.LEFT_TO_RIGHT,
                                          backgroundColor: Colors.black,
                                          borderColor: Colors.black,
                                          borderRadius: 60,
                                          borderWidth: 1,
                                          onPress: () {
                                            var docID = doc.id;
                                            List myList = [
                                              {
                                                'Date': _selectedDay?.toUtc(),
                                                'Taken': 'No'
                                              }
                                            ];
                                            FirebaseFirestore.instance.collection(
                                                'UserData').doc(uid).collection(
                                                'MedicationList')
                                                .doc(docID)
                                                .update({
                                              'Dates': FieldValue.arrayUnion(
                                                  myList),
                                              'Quantity': quantityInt,
                                            },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  ),
                                ),
                              );
                            }
                            else if (doc['MedType'] == ('Shot') && today == true && quantityInt > 0){
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                    AssetImage("img/outline_vaccines_black_24dp.png"),
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                  ),
                                  title: Text(doc['MedName']),
                                  subtitle: Container(
                                    //height: 70,
                                    child: Row(
                                    children: [ Container(
                                      child: AnimatedButton(
                                        height: 30,
                                        width: 70,
                                        text: 'Taken',
                                        isReverse: true,
                                        selectedTextColor: Colors.black,
                                        transitionType: TransitionType.LEFT_TO_RIGHT,
                                        backgroundColor: Colors.black,
                                        borderColor: Colors.black,
                                        borderRadius: 60,
                                        borderWidth: 1,
                                        onPress: () {
                                          var docID = doc.id;
                                          List myList = [
                                            {
                                              'Date': _selectedDay?.toUtc(),
                                              'Taken': 'Yes'
                                            }
                                          ];
                                          quantityInt--;
                                          FirebaseFirestore.instance.collection(
                                              'UserData').doc(uid).collection(
                                              'MedicationList')
                                              .doc(docID)
                                              .update({
                                            'Dates': FieldValue.arrayUnion(
                                                myList),
                                            'Quantity': quantityInt,
                                          },
                                          );
                                        },
                                      ),
                                    ),
                                      Spacer(),
                                      Container(
                                        child: AnimatedButton(
                                          height: 30,
                                          width: 70,
                                          text: 'Late',
                                          isReverse: true,
                                          selectedTextColor: Colors.black,
                                          transitionType: TransitionType.LEFT_TO_RIGHT,
                                          backgroundColor: Colors.black,
                                          borderColor: Colors.black,
                                          borderRadius: 60,
                                          borderWidth: 1,
                                          onPress: () {
                                            var docID = doc.id;
                                            List myList = [
                                              {
                                                'Date': _selectedDay?.toUtc(),
                                                'Taken': 'Late'
                                              }
                                            ];
                                            quantityInt--;
                                            FirebaseFirestore.instance.collection(
                                                'UserData').doc(uid).collection(
                                                'MedicationList')
                                                .doc(docID)
                                                .update({
                                              'Dates': FieldValue.arrayUnion(
                                                  myList),
                                              'Quantity': quantityInt,
                                            },
                                            );
                                          },
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        child: AnimatedButton(
                                          height: 30,
                                          width: 70,
                                          text: 'Missed',
                                          isReverse: true,
                                          selectedTextColor: Colors.black,
                                          transitionType: TransitionType.LEFT_TO_RIGHT,
                                          backgroundColor: Colors.black,
                                          borderColor: Colors.black,
                                          borderRadius: 60,
                                          borderWidth: 1,
                                          onPress: () {
                                            var docID = doc.id;
                                            List myList = [
                                              {
                                                'Date': _selectedDay?.toUtc(),
                                                'Taken': 'No'
                                              }
                                            ];
                                            FirebaseFirestore.instance.collection(
                                                'UserData').doc(uid).collection(
                                                'MedicationList')
                                                .doc(docID)
                                                .update({
                                              'Dates': FieldValue.arrayUnion(
                                                  myList),
                                              'Quantity': quantityInt,
                                            },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  ),
                                ),
                              );
                            }
                            else {
                              return Card(
                              );
                            }
              }).toList(),
                      ),
                      ),
              ],
              );
              }
            }
          ),
        ),
        /*Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8.0),
        child: TableCalendar(
      //body: TableCalendar(
        firstDay: DateTime(1990),
        lastDay: DateTime(2050),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
              color:Colors.lightBlueAccent,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: Colors.white,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.pink,
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: Colors.white,
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
     // ),
    );
  }

/*Widget _scrollingList(ScrollController sc){
    return ListView.builder(
      controller: sc,
      itemCount: 3,
      itemBuilder: (BuildContext context, int i){
        int j = i + 1;
        return Container(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
                AssetImage("img/pills_graphic.png"),
              backgroundColor: Colors.white,
              radius: 30,
            ),
            title: Text("Sample Medication" + " $j"),
            subtitle: Text ("test" + "$j"),
        ),
          //child: Text("Medication: " + "$j"),
        );
      },
    );
  }*/
}
