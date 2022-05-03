import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/os_graphs.dart';
import 'package:senior_project/test_calendar.dart';
import 'package:senior_project/welcome_page.dart';

import 'bluetoothScan.dart';
import 'camera_bpm/calc_heart.dart';
import 'med_list.dart';

class BloodPressureGraphs extends StatelessWidget {

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  void _navigateToBluetooth(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BluetoothScan()));
  }

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToOS(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OxygenSaturationGraphs()));
  }


  List<Color> gradientColors = [
    //const Color(0xff23b6e6),
    //const Color(0xff02d39a),
    const Color.fromRGBO(139, 193, 188, 1),
    const Color.fromRGBO(188, 255, 249, 1),
  ];

  String? uid = FirebaseAuth.instance.currentUser?.uid;
  var sysController = TextEditingController();
  var diaController = TextEditingController();
  var dateInput = TextEditingController();
  var timeInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now();
    TimeOfDay initialTime = TimeOfDay.now();
    String todayDate = DateFormat('yMd').format(now);
    int todayWeek = now.weekday;

    return Scaffold(
      body: Column(
        children: [
          AppBar(
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                    onTap: () {
                      //_navigateToBluetooth(context);
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            color: Colors.white,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: const Text('Add', style: TextStyle(
                                      fontSize: 30,
                                    ),),
                                    alignment: Alignment.topCenter,),
                                  Container(
                                    child: const Text('Would you like to connect to a Blood Pressure Device?', style: TextStyle(
                                      fontSize: 20,
                                    ),),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        ElevatedButton(
                                          child: const Text('No', style: TextStyle(
                                            fontSize: 20,
                                          ),),
                                          onPressed: () => {
                                            showModalBottomSheet(context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 450,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text('Blood Pressure', style: TextStyle(
                                                            fontSize: 20,
                                                          ),),
                                                          alignment: Alignment.topLeft,
                                                          padding: EdgeInsets.all(10),
                                                        ),
                                                            Container(
                                                              height: 60,
                                                              padding: EdgeInsets.only(left: 20, right: 20),
                                                              decoration: BoxDecoration(
                                                                color:Colors.white,
                                                                border: Border.all(
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                              child: TextField(
                                                                controller: sysController,
                                                                decoration: InputDecoration(
                                                                  hintText: "SYS",
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color:Colors.white,
                                                                        width: 1.0
                                                                    ),
                                                                  ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color:Colors.white,
                                                                        width: 1.0
                                                                    ),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                    //borderRadius: BorderRadius.circular(20),
                                                                  ),
                                                                ),
                                                                keyboardType: TextInputType.number,
                                                              ),
                                                              alignment: Alignment.topCenter,
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Container(
                                                              height: 60,
                                                              padding: EdgeInsets.only(left: 20, right: 20),
                                                              decoration: BoxDecoration(
                                                                color:Colors.white,
                                                                border: Border.all(
                                                                  color: Colors.grey,
                                                                ),
                                                              ),
                                                              child: TextField(
                                                                controller: diaController,
                                                                decoration: InputDecoration(
                                                                  hintText: "DIA",
                                                                  focusedBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color:Colors.white,
                                                                        width: 1.0
                                                                    ),
                                                                  ),
                                                                  enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color:Colors.white,
                                                                        width: 1.0
                                                                    ),
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                    //borderRadius: BorderRadius.circular(20),
                                                                  ),
                                                                ),
                                                                keyboardType: TextInputType.number,
                                                              ),
                                                              alignment: Alignment.topCenter,
                                                            ),
                                                        SizedBox(height: 20,),
                                                        Container(
                                                          height: 60,
                                                          padding: EdgeInsets.only(left: 20, right: 20),
                                                          decoration: BoxDecoration(
                                                            color:Colors.white,
                                                            border: Border.all(
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                          child: TextField(
                                                            controller: dateInput,
                                                            decoration: InputDecoration(
                                                              icon: Icon(Icons.calendar_today, size: 25),
                                                              hintText: "Date",
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color:Colors.white,
                                                                    width: 1.0
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color:Colors.white,
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                              ),
                                                            ),
                                                            readOnly: true,
                                                            onTap: () async {
                                                              DateTime? pickedDate = await showDatePicker(
                                                                  context: context,
                                                                  initialDate: DateTime.now(),
                                                                  firstDate: DateTime(2000),
                                                                  lastDate: DateTime(2050)
                                                              );

                                                              if (pickedDate != null) {
                                                                print(pickedDate);
                                                                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                                print(formattedDate);
                                                                dateInput.text = formattedDate;
                                                              }
                                                              else{
                                                                print("no date chosen");
                                                              }
                                                            },
                                                          ),
                                                          alignment: Alignment.topCenter,
                                                        ),
                                                        SizedBox(height: 20,),
                                                        Container(
                                                          height: 60,
                                                          padding: EdgeInsets.only(left: 20, right: 20),
                                                          decoration: BoxDecoration(
                                                            color:Colors.white,
                                                            border: Border.all(
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                          child: TextField(
                                                            controller: timeInput,
                                                            decoration: InputDecoration(
                                                              icon: Icon(Icons.access_time, size: 25),
                                                              hintText: "Time",
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color:Colors.white,
                                                                    width: 1.0
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                  color:Colors.white,
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                              ),
                                                            ),
                                                            readOnly: true,
                                                            onTap: () async {
                                                              TimeOfDay? pickedTime = await showTimePicker(
                                                                context: context,
                                                                initialTime: initialTime,
                                                              );
                                                              if (pickedTime != null) {
                                                                print(pickedTime);
                                                                timeInput.text = pickedTime.format(context);
                                                              }
                                                              else{
                                                                print("no time chosen");
                                                              }
                                                            },
                                                          ),
                                                          alignment: Alignment.topCenter,
                                                        ),
                                                        SizedBox(height: 10,),
                                                        Container(
                                                          child: ElevatedButton(
                                                            child: const Text('Add', style: TextStyle(
                                                              fontSize: 20,
                                                            ),),
                                                            onPressed: () async {

                                                              List myList = [{
                                                                'SYS': int.parse(sysController.text.trim()),
                                                                'DIA': int.parse(diaController.text.trim()),
                                                                'Time': DateTime.now(),
                                                              }
                                                              ];
                                                              final snap = await FirebaseFirestore.instance.collection('UserData').doc(uid).collection('BloodPressure').get();
                                                              if (snap.docs.length == 0) {
                                                                FirebaseFirestore.instance.collection(
                                                                    'UserData').doc(uid).collection(
                                                                    'BloodPressure').doc('Data').set({
                                                                  'Data': FieldValue.arrayUnion(myList),
                                                                });
                                                              }
                                                              else{
                                                                FirebaseFirestore.instance.collection(
                                                                    'UserData').doc(uid).collection(
                                                                    'BloodPressure').doc('Data').update({
                                                                  'Data': FieldValue.arrayUnion(myList),
                                                                });
                                                              }
                                                              Navigator.pop(context);
                                                              Navigator.pop(context);
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                primary: Color.fromRGBO(240, 172, 159, 1.0)
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.grey[500],
                                          ),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                          child: const Text('Yes', style: TextStyle(
                                            fontSize: 20,
                                          ),),
                                          onPressed: () => _navigateToBluetooth(context),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color.fromRGBO(240, 172, 159, 1.0)
                                          ),
                                        )
                                      ],
                                    ),
                                    alignment: Alignment.bottomCenter,
                                    padding: EdgeInsets.only(left: 20, right: 20),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(Icons.add, color: Colors.grey,)
                ),
              ),
            ],
            backgroundColor: Colors.white,
          ),
          Container(
            width: w,
            height: h * 0.01,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('BloodPressure').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else
                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      int arrayLength = doc['Data'].length;
                      //print(arrayLength);
                      var bpTimeList = List.generate(arrayLength, (i) => List.filled(4, '', growable: false), growable: false);
                      var graphBPList = List.generate(7, (i) => List.filled(4, '', growable: false), growable: false);
                      outerLoop:
                      for (int i = 0; i < arrayLength; i++) {
                        bpTimeList[i][0] = DateTime.parse(doc['Data'][i]['Time'].toDate().toString()).toUtc().toString();
                        int date = DateTime.parse(doc['Data'][i]['Time'].toDate().toString()).toUtc().weekday;
                        bpTimeList[i][1] = date.toString();
                        bpTimeList[i][2] = doc['Data'][i]['SYS'].toString();
                        bpTimeList[i][3] = doc['Data'][i]['DIA'].toString();

                        var checkDate = DateTime.parse(doc['Data'][i]['Time'].toDate().toString()).toUtc();
                        String checkDate2 = DateFormat('yMd').format(checkDate);
                        if (checkDate2 == todayDate) {
                          //print(checkDate2);
                          var iVal = i;
                          switch(date) {
                            case 1: {
                              var sun1 = DateTime(checkDate.year, checkDate.month, checkDate.day - 1);
                              var sun = DateFormat('yyyy-MM-dd').format(sun1);

                              graphBPList[1][0] = bpTimeList[iVal][0];
                              graphBPList[1][1] = bpTimeList[iVal][1];
                              graphBPList[1][2] = bpTimeList[iVal][2];
                              graphBPList[1][3] = bpTimeList[iVal][3];

                              for (int i = 0; i < arrayLength; i++) {
                                if (bpTimeList[i][0] !='') {
                                  var check1 = DateTime.parse(bpTimeList[i][0]);
                                  var check = DateFormat('yyyy-MM-dd').format(
                                      check1);
                                  if (check == sun) {
                                    graphBPList[0][0] = bpTimeList[i][0];
                                    graphBPList[0][1] = bpTimeList[i][1];
                                    graphBPList[0][2] = bpTimeList[i][2];
                                    graphBPList[0][3] = bpTimeList[i][3];
                                  }
                                }
                              }
                            }
                            break;
                            case 2: {
                              var sun1 = DateTime(checkDate.year, checkDate.month, checkDate.day - 2);
                              var sun = DateFormat('yyyy-MM-dd').format(sun1);

                              var mon1 = DateTime(checkDate.year, checkDate.month, checkDate.day - 1);
                              var mon = DateFormat('yyyy-MM-dd').format(mon1);

                              graphBPList[2][0] = bpTimeList[iVal][0];
                              graphBPList[2][1] = bpTimeList[iVal][1];
                              graphBPList[2][2] = bpTimeList[iVal][2];
                              graphBPList[2][3] = bpTimeList[iVal][3];

                              for (int i = 0; i < arrayLength; i++) {
                                if (bpTimeList[i][0] != '') {
                                  var check1 = DateTime.parse(bpTimeList[i][0]);
                                  var check = DateFormat('yyyy-MM-dd').format(
                                      check1);
                                  if (check == sun) {
                                    graphBPList[0][0] = bpTimeList[i][0];
                                    graphBPList[0][1] = bpTimeList[i][1];
                                    graphBPList[0][2] = bpTimeList[i][2];
                                    graphBPList[0][3] = bpTimeList[i][3];
                                  }
                                  else if (check == mon) {
                                    graphBPList[1][0] = bpTimeList[i][0];
                                    graphBPList[1][1] = bpTimeList[i][1];
                                    graphBPList[1][2] = bpTimeList[i][2];
                                    graphBPList[1][3] = bpTimeList[i][3];
                                  }
                                }
                              }
                            }
                            break;
                            case 3: {
                              var sun1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 3);
                              var sun = DateFormat('yyyy-MM-dd').format(sun1);

                              var mon1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 2);
                              var mon = DateFormat('yyyy-MM-dd').format(mon1);

                              var tues1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 1);
                              var tues = DateFormat('yyyy-MM-dd').format(tues1);

                              graphBPList[3][0] = bpTimeList[iVal][0];
                              graphBPList[3][1] = bpTimeList[iVal][1];
                              graphBPList[3][2] = bpTimeList[iVal][2];
                              graphBPList[3][3] = bpTimeList[iVal][3];

                              for (int i = 0; i < arrayLength; i++) {
                                if (bpTimeList[i][0] != '') {
                                  var check1 = DateTime.parse(bpTimeList[i][0]);
                                  var check = DateFormat('yyyy-MM-dd').format(
                                      check1);
                                  if (check == sun) {
                                    graphBPList[0][0] = bpTimeList[i][0];
                                    graphBPList[0][1] = bpTimeList[i][1];
                                    graphBPList[0][2] = bpTimeList[i][2];
                                    graphBPList[0][3] = bpTimeList[i][3];
                                  }
                                  else if (check == mon) {
                                    graphBPList[1][0] = bpTimeList[i][0];
                                    graphBPList[1][1] = bpTimeList[i][1];
                                    graphBPList[1][2] = bpTimeList[i][2];
                                    graphBPList[1][3] = bpTimeList[i][3];
                                  }
                                  else if (check == tues) {
                                    graphBPList[2][0] = bpTimeList[i][0];
                                    graphBPList[2][1] = bpTimeList[i][1];
                                    graphBPList[2][2] = bpTimeList[i][2];
                                    graphBPList[2][3] = bpTimeList[i][3];
                                  }
                                }
                              }
                            }
                            break;
                            case 4: {
                              var sun1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 4);
                              var sun = DateFormat('yyyy-MM-dd').format(sun1);

                              var mon1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 3);
                              var mon = DateFormat('yyyy-MM-dd').format(mon1);

                              var tues1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 2);
                              var tues = DateFormat('yyyy-MM-dd').format(tues1);

                              var wed1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 1);
                              var wed = DateFormat('yyyy-MM-dd').format(wed1);

                              graphBPList[4][0] = bpTimeList[iVal][0];
                              graphBPList[4][1] = bpTimeList[iVal][1];
                              graphBPList[4][2] = bpTimeList[iVal][2];
                              graphBPList[4][3] = bpTimeList[iVal][3];

                              for (int i = 0; i < arrayLength; i++) {
                                if (bpTimeList[i][0] != '') {
                                  var check1 = DateTime.parse(bpTimeList[i][0]);
                                  var check = DateFormat('yyyy-MM-dd').format(
                                      check1);
                                  if (check == sun) {
                                    graphBPList[0][0] = bpTimeList[i][0];
                                    graphBPList[0][1] = bpTimeList[i][1];
                                    graphBPList[0][2] = bpTimeList[i][2];
                                    graphBPList[0][3] = bpTimeList[i][3];
                                  }
                                  else if (check == mon) {
                                    graphBPList[1][0] = bpTimeList[i][0];
                                    graphBPList[1][1] = bpTimeList[i][1];
                                    graphBPList[1][2] = bpTimeList[i][2];
                                    graphBPList[1][3] = bpTimeList[i][3];
                                  }
                                  else if (check == tues) {
                                    graphBPList[2][0] = bpTimeList[i][0];
                                    graphBPList[2][1] = bpTimeList[i][1];
                                    graphBPList[2][2] = bpTimeList[i][2];
                                    graphBPList[2][3] = bpTimeList[i][3];
                                  }
                                  else if (check == wed) {
                                    graphBPList[3][0] = bpTimeList[i][0];
                                    graphBPList[3][1] = bpTimeList[i][1];
                                    graphBPList[3][2] = bpTimeList[i][2];
                                    graphBPList[3][3] = bpTimeList[i][3];
                                  }
                                }
                              }
                            }
                            break;
                            case 5: {
                              var sun1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 5);
                              var sun = DateFormat('yyyy-MM-dd').format(sun1);

                              var mon1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 4);
                              var mon = DateFormat('yyyy-MM-dd').format(mon1);

                              var tues1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 3);
                              var tues = DateFormat('yyyy-MM-dd').format(tues1);

                              var wed = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 2).toString();

                              var thurs1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 1);
                              var thurs = DateFormat('yyyy-MM-dd').format(thurs1);

                              graphBPList[5][0] = bpTimeList[iVal][0];
                              graphBPList[5][1] = bpTimeList[iVal][1];
                              graphBPList[5][2] = bpTimeList[iVal][2];
                              graphBPList[5][3] = bpTimeList[iVal][3];

                              for (int i = 0; i < arrayLength; i++) {
                                if (bpTimeList[i][0] != '') {
                                  var check1 = DateTime.parse(bpTimeList[i][0]);
                                  var check = DateFormat('yyyy-MM-dd').format(
                                      check1);
                                  if (check == sun) {
                                    graphBPList[0][0] = bpTimeList[i][0];
                                    graphBPList[0][1] = bpTimeList[i][1];
                                    graphBPList[0][2] = bpTimeList[i][2];
                                    graphBPList[0][3] = bpTimeList[i][3];
                                  }
                                  else if (check == mon) {
                                    graphBPList[1][0] = bpTimeList[i][0];
                                    graphBPList[1][1] = bpTimeList[i][1];
                                    graphBPList[1][2] = bpTimeList[i][2];
                                    graphBPList[1][3] = bpTimeList[i][3];
                                  }
                                  else if (check == tues) {
                                    graphBPList[2][0] = bpTimeList[i][0];
                                    graphBPList[2][1] = bpTimeList[i][1];
                                    graphBPList[2][2] = bpTimeList[i][2];
                                    graphBPList[2][3] = bpTimeList[i][3];
                                  }
                                  else if (check == wed) {
                                    graphBPList[3][0] = bpTimeList[i][0];
                                    graphBPList[3][1] = bpTimeList[i][1];
                                    graphBPList[3][2] = bpTimeList[i][2];
                                    graphBPList[3][3] = bpTimeList[i][3];
                                  }
                                  else if (check == thurs) {
                                    graphBPList[4][0] = bpTimeList[i][0];
                                    graphBPList[4][1] = bpTimeList[i][1];
                                    graphBPList[4][2] = bpTimeList[i][2];
                                    graphBPList[4][3] = bpTimeList[i][3];
                                  }
                                }
                              }
                            }
                            break;
                            case 6: {
                              var sun1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 6);
                              var sun = DateFormat('yyyy-MM-dd').format(sun1);

                              var mon1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 5);
                              var mon = DateFormat('yyyy-MM-dd').format(mon1);

                              var tues1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 4);
                              var tues = DateFormat('yyyy-MM-dd').format(tues1);

                              var wed1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 3);
                              var wed = DateFormat('yyyy-MM-dd').format(wed1);

                              var thurs1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 2);
                              var thurs = DateFormat('yyyy-MM-dd').format(thurs1);

                              var fri1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 1);
                              var fri = DateFormat('yyyy-MM-dd').format(fri1);

                              graphBPList[6][0] = bpTimeList[iVal][0];
                              graphBPList[6][1] = bpTimeList[iVal][1];
                              graphBPList[6][2] = bpTimeList[iVal][2];
                              graphBPList[6][3] = bpTimeList[iVal][3];

                              for (int i = 0; i < arrayLength; i++) {
                                if (bpTimeList[i][0] != '') {
                                  var check1 = DateTime.parse(bpTimeList[i][0]);
                                  var check = DateFormat('yyyy-MM-dd').format(
                                      check1);
                                  if (check == sun) {
                                    graphBPList[0][0] = bpTimeList[i][0];
                                    graphBPList[0][1] = bpTimeList[i][1];
                                    graphBPList[0][2] = bpTimeList[i][2];
                                    graphBPList[0][3] = bpTimeList[i][3];
                                  }
                                  else if (check == mon) {
                                    graphBPList[1][0] = bpTimeList[i][0];
                                    graphBPList[1][1] = bpTimeList[i][1];
                                    graphBPList[1][2] = bpTimeList[i][2];
                                    graphBPList[1][3] = bpTimeList[i][3];
                                  }
                                  else if (check == tues) {
                                    graphBPList[2][0] = bpTimeList[i][0];
                                    graphBPList[2][1] = bpTimeList[i][1];
                                    graphBPList[2][2] = bpTimeList[i][2];
                                    graphBPList[2][3] = bpTimeList[i][3];
                                  }
                                  else if (check == wed) {
                                    graphBPList[3][0] = bpTimeList[i][0];
                                    graphBPList[3][1] = bpTimeList[i][1];
                                    graphBPList[3][2] = bpTimeList[i][2];
                                    graphBPList[3][3] = bpTimeList[i][3];
                                  }
                                  else if (check == thurs) {
                                    graphBPList[4][0] = bpTimeList[i][0];
                                    graphBPList[4][1] = bpTimeList[i][1];
                                    graphBPList[4][2] = bpTimeList[i][2];
                                    graphBPList[4][3] = bpTimeList[i][3];
                                  }
                                  else if (check == fri) {
                                    graphBPList[5][0] = bpTimeList[i][0];
                                    graphBPList[5][1] = bpTimeList[i][1];
                                    graphBPList[5][2] = bpTimeList[i][2];
                                    graphBPList[5][3] = bpTimeList[i][3];
                                  }
                                }
                              }
                            }
                            break;
                            case 7: {
                              var mon1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 6);
                              var mon = DateFormat('yyyy-MM-dd').format(mon1);

                              var tues1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 5);
                              var tues = DateFormat('yyyy-MM-dd').format(tues1);

                              var wed1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 4);
                              var wed = DateFormat('yyyy-MM-dd').format(wed1);

                              var thurs1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 3);
                              var thurs = DateFormat('yyyy-MM-dd').format(thurs1);

                              var fri1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 2);
                              var fri = DateFormat('yyyy-MM-dd').format(fri1);

                              var sat1 = DateTime(
                                  checkDate.year, checkDate.month,
                                  checkDate.day - 1);
                              var sat = DateFormat('yyyy-MM-dd').format(sat1);

                              graphBPList[0][0] = bpTimeList[iVal][0];
                              graphBPList[0][1] = bpTimeList[iVal][1];
                              graphBPList[0][2] = bpTimeList[iVal][2];
                              graphBPList[0][3] = bpTimeList[iVal][3];

                              for (int i = 0; i < arrayLength; i++) {
                                if (bpTimeList[i][0] != '') {
                                  var check1 = DateTime.parse(
                                      bpTimeList[i][0]);
                                  var check = DateFormat('yyyy-MM-dd').format(
                                      check1);
                                  if (check == mon) {
                                    graphBPList[1][0] = bpTimeList[i][0];
                                    graphBPList[1][1] = bpTimeList[i][1];
                                    graphBPList[1][2] = bpTimeList[i][2];
                                    graphBPList[1][3] = bpTimeList[i][3];
                                  }
                                  else if (check == tues) {
                                    graphBPList[2][0] = bpTimeList[i][0];
                                    graphBPList[2][1] = bpTimeList[i][1];
                                    graphBPList[2][2] = bpTimeList[i][2];
                                    graphBPList[2][3] = bpTimeList[i][3];
                                  }
                                  else if (check == wed) {
                                    graphBPList[3][0] = bpTimeList[i][0];
                                    graphBPList[3][1] = bpTimeList[i][1];
                                    graphBPList[3][2] = bpTimeList[i][2];
                                    graphBPList[3][3] = bpTimeList[i][3];
                                  }
                                  else if (check == thurs) {
                                    graphBPList[4][0] = bpTimeList[i][0];
                                    graphBPList[4][1] = bpTimeList[i][1];
                                    graphBPList[4][2] = bpTimeList[i][2];
                                    graphBPList[4][3] = bpTimeList[i][3];
                                  }
                                  else if (check == fri) {
                                    graphBPList[5][0] = bpTimeList[i][0];
                                    graphBPList[5][1] = bpTimeList[i][1];
                                    graphBPList[5][2] = bpTimeList[i][2];
                                    graphBPList[5][3] = bpTimeList[i][3];
                                  }
                                  else if (check == sat) {
                                    graphBPList[6][0] = bpTimeList[i][0];
                                    graphBPList[6][1] = bpTimeList[i][1];
                                    graphBPList[6][2] = bpTimeList[i][2];
                                    graphBPList[1][3] = bpTimeList[i][3];
                                  }
                                }
                              }
                            }
                            break;
                          }
                          break outerLoop;
                        }
                        /*print('Time $i: ' + doc['Data'][i]['Time'].toString());
                        print('BPM $i: ' + doc['Data'][i]['BPM'].toString());
                        print('');*/
                      }

                      List<FlSpot>spotListSys(int x) {
                        List<FlSpot>sList = [];
                        switch(x) {
                          case 1: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 2: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 3: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 4: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 5: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[5][0] != '') {
                              var sys1 = int.parse(graphBPList[5][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[5][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 6: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[5][0] != '') {
                              var sys1 = int.parse(graphBPList[5][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[5][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[6][0] != '') {
                              var sys1 = int.parse(graphBPList[6][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[6][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 7: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }

                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[5][0] != '') {
                              var sys1 = int.parse(graphBPList[5][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[5][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[6][0] != '') {
                              var sys1 = int.parse(graphBPList[6][2]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[6][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                        }
                        return sList;
                      }
                      List<FlSpot>spotListDia(int x) {
                        List<FlSpot>sList = [];
                        switch(x) {
                          case 1: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 2: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 3: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 4: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 5: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[5][0] != '') {
                              var sys1 = int.parse(graphBPList[5][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[5][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 6: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }
                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[5][0] != '') {
                              var sys1 = int.parse(graphBPList[5][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[5][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[6][0] != '') {
                              var sys1 = int.parse(graphBPList[6][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[6][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                          case 7: {
                            if (graphBPList[0][0] != '') {
                              var sys1 = int.parse(graphBPList[0][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[0][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(0, sys2));
                            }

                            if (graphBPList[1][0] != '') {
                              var sys1 = int.parse(graphBPList[1][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[1][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[2][0] != '') {
                              var sys1 = int.parse(graphBPList[2][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[2][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[3][0] != '') {
                              var sys1 = int.parse(graphBPList[3][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[3][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[4][0] != '') {
                              var sys1 = int.parse(graphBPList[4][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[4][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[5][0] != '') {
                              var sys1 = int.parse(graphBPList[5][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[5][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                            if (graphBPList[6][0] != '') {
                              var sys1 = int.parse(graphBPList[6][3]);
                              double sys2 = sys1.toDouble();
                              var day1 = int.parse(graphBPList[6][1]);
                              double day2 = day1.toDouble();
                              sList.add(FlSpot(day2, sys2));
                            }
                          }
                          break;
                        }
                        return sList;
                      }
                      print('List: $bpTimeList');
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 22.0, top: 20, left: 10),
                          child: Center(
                            child: SizedBox(
                              width: 400,
                              height: 250,
                              child: LineChart(
                                LineChartData(
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                        color: Colors.white,
                                        width: 2
                                    ),
                                  ),
                                  gridData: FlGridData(
                                      show: true,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: Colors.white,
                                          strokeWidth: 0.5,
                                        );
                                      },
                                      drawVerticalLine: true,
                                      getDrawingVerticalLine: (value) {
                                        return FlLine(
                                          color: Colors.white,
                                          strokeWidth: 0.5,
                                        );
                                      }
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 35,
                                        interval: 1,
                                        getTitlesWidget: bottomTitleWidgets,
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        reservedSize: 40,
                                        getTitlesWidget: leftTitleWidgets,
                                      ),
                                    ),
                                  ),
                                  maxX: 7,
                                  maxY: 200,
                                  minX: 0,
                                  minY: 50,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: spotListSys(todayWeek),
                                      isCurved: true,
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      barWidth: 5,
                                    ),
                                    LineChartBarData(
                                      spots: spotListDia(todayWeek),
                                      isCurved: true,
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      barWidth: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 10),
            alignment: Alignment.centerLeft,
            child: Text("Today's Blood Pressure Data", style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(139, 193, 188, 1),
            ),),
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
                      children: snapshot.data!.docs.map((doc) {
                        int arrayLength2 = doc['Data'].length;
                        List hearts = [];
                        int x = 0;
                        for (int i = 0; i < arrayLength2; i++) {
                          var sys = doc['Data'][i]['SYS'].toString();
                          var dia = doc['Data'][i]['DIA'].toString();
                          var checkDate3 = DateTime.parse(
                              doc['Data'][i]['Time'].toDate().toString()).toUtc();
                          String checkDate4 = DateFormat('yMd').format(
                              checkDate3);
                          if (checkDate4 == todayDate) {
                            hearts.add(heart(sys: sys, dia: dia, date: checkDate4));
                            x = x + 1;
                          }
                        }
                        return Container(
                          child: ListView.builder(
                            itemCount: hearts.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) => Card(
                              child: ListTile(
                                leading: Icon(
                                  Icons.bloodtype_outlined, color: Color.fromRGBO(240, 172, 159, 1.0), size: 40,),
                                title: Text("${hearts[index].sys} / ${hearts[index].dia}"),
                                subtitle: Text("${hearts[index].date}"),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget ?text;
    switch(value.toInt()) {
      case 0 :
        text = const Text('S', style: style,);
        break;
      case 1 :
        text = const Text('M', style: style,);
        break;
      case 2 :
        text = const Text('T', style: style,);
        break;
      case 3 :
        text = const Text('W', style: style,);
        break;
      case 4 :
        text = const Text('Th', style: style,);
        break;
      case 5 :
        text = const Text('F', style: style,);
        break;
      case 6 :
        text = const Text('S', style: style,);
        break;
    }
    return Padding(child: text, padding: const EdgeInsets.only(top:8.0,));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text;
    switch(value.toInt()) {
      case 50 :
        text =  '50';
        break;
      case 100 :
        text = '100';
        break;
      case 150 :
        text = '150';
        break;
      case 200 :
        text = '200';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }
}

class heart {

  String? sys;
  String? dia;
  String? date;

  heart({this.sys,this.dia,this.date});

}