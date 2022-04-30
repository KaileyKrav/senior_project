import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/calendar.dart';
import 'package:senior_project/camera_bpm/calc_heart.dart';
import 'package:senior_project/test_calendar.dart';
import 'med_list.dart';


class HeartGraph extends StatefulWidget {
  @override
  _HeartGraphState createState() => _HeartGraphState();
}

class _HeartGraphState extends State<HeartGraph> {

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHeart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalcHeartPage()));
  }

  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('HeartRate').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<dynamic> data = snapshot.data!.docs.map((doc) {
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
              //print('List: $bpmTimeList');
            }).toList();
            return Padding(
              padding: const EdgeInsets.only(
                  right: 22.0, bottom: 200, left: 10),
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
                      maxY: 8,
                      minX: 0,
                      minY: 0,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            const FlSpot(0, 0),
                            const FlSpot(5, 5),
                            const FlSpot(7, 6),
                            const FlSpot(8, 4),
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
            );
          }
        }
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
      case 0 :
        text =  '60';
        break;
      case 2 :
        text = '80';
        break;
      case 4 :
        text = '100';
        break;
      case 6 :
        text = '150';
        break;
      case 8 :
        text = '200';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
