import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';

class TestCalendar extends StatefulWidget {
  @override
  _TestCalendarState createState() => _TestCalendarState();
}

class _TestCalendarState extends State<TestCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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
      body: SlidingUpPanel(
      panelBuilder: (ScrollController sc) => _scrollingList(sc),
          //body: Center(
        //child: Text("This is the sliding Widget"),
        //),
      collapsed: Container(
        decoration: BoxDecoration(
          borderRadius: radius
        ),
      ),
    body: Column(
        children: <Widget>[
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
    ],
    ),
      ),
    );
  }

Widget _scrollingList(ScrollController sc){
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
  }
}
