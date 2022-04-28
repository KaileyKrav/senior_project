import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior_project/test_calendar.dart';

import 'add_med.dart';
import 'bluetoothScan.dart';
import 'camera_bpm/calc_heart.dart';
import 'med_list.dart';

class HeartGraphs extends StatelessWidget {

  void _navigateToBluetooth(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BluetoothScan()));
  }

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

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  String? uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            //leading: Icon(Icons.menu),
            //title: Text('Page title'),
            actions: [
              //Icon(Icons.favorite),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    _navigateToBluetooth(context);
                  },
                  child: Icon(Icons.add)
                ),
              ),
            ],
            backgroundColor: Color(0xff23b6e6),
          ),
          Container(
            width: w,
            height: h * 0.01,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('HeartRate').snapshots(),
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
                      var bpmTimeList = List.generate(arrayLength, (i) => List.filled(3, '', growable: false), growable: false);
                      for (int i = 0; i < arrayLength; i++) {
                        bpmTimeList[i][0] = DateTime.parse(doc['Data'][i]['Time'].toDate().toString()).toUtc().toString();
                        int date = DateTime.parse(doc['Data'][i]['Time'].toDate().toString()).toUtc().weekday;
                        bpmTimeList[i][1] = date.toString();
                        bpmTimeList[i][2] = doc['Data'][i]['BPM'].toString();
                        /*print('Time $i: ' + doc['Data'][i]['Time'].toString());
                        print('BPM $i: ' + doc['Data'][i]['BPM'].toString());
                        print('');*/
                      }
                      FlSpot spotData(int x) {
                        /*for (int i = 0; i < arrayLength; i++) {
                          var bpm1 = int.parse(bpmTimeList[i][2]);
                          double bpm2 = bpm1.toDouble();
                          var day1 = int.parse(bpmTimeList[i][1]);
                          double day2 = day1.toDouble();
                          return FlSpot(day2, bpm2);
                        }
                        return FlSpot(0, 0);*/
                        if (x >= arrayLength) {
                          return FlSpot(0,0);
                        }
                        else {
                          var bpm1 = int.parse(bpmTimeList[x][2]);
                          double bpm2 = bpm1.toDouble();
                          var day1 = int.parse(bpmTimeList[x][1]);
                          double day2 = day1.toDouble();
                          return FlSpot(day2, bpm2);
                        }
                      }
                      print('List: $bpmTimeList');
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
                                          reservedSize: 35,
                                          getTitlesWidget: leftTitleWidgets,
                                        ),
                                      ),
                                    ),
                                    maxX: 8,
                                    maxY: 120,
                                    minX: 0,
                                    minY: 60,
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          spotData(0),
                                          spotData(1),
                                          /*spotData(2),
                                          spotData(3),
                                          spotData(4),
                                          spotData(5),
                                          spotData(6),*/
                                        ],
                                        isCurved: true,
                                        gradient: LinearGradient(
                                          colors: gradientColors,
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        barWidth: 5,
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            colors: gradientColors.map((color) =>
                                                color.withOpacity(0.3)).toList(),
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
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
        ],
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
      case 1 :
        text = const Text('Sun', style: style,);
        break;
      case 4 :
        text = const Text('Wed', style: style,);
        break;
      case 7 :
        text = const Text('Sat', style: style,);
        break;
    }
    return Padding(child: text, padding: const EdgeInsets.only(top:8.0));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text;
    switch(value.toInt()) {
      case 60 :
        text =  '60';
        break;
      case 80 :
        text = '80';
        break;
      case 100 :
        text = '100';
        break;
      case 120 :
        text = '120';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }
}