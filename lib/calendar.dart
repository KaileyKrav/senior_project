
//Using sample UI from a tutorial, Will change later
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/medication_events/add_event.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEventPage()));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
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
              Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 01, 01),
                  lastDay: DateTime.utc(2050, 12, 31),
                  focusedDay: DateTime.now(),
                  weekendDays: [6,7],
                  headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                      color:Color.fromRGBO(252, 198, 205, 100),
                    ),
                    headerMargin: const EdgeInsets.only(bottom: 8.0),
                    titleTextStyle: TextStyle(color: Colors.black),
                    formatButtonDecoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.black),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                  ),
                  calendarStyle: CalendarStyle(

                  ),
                  calendarBuilders: CalendarBuilders(

                  ),
              ),
              ),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(252, 198, 205, 100),
        onPressed: () {
          _navigateToNextScreen(context);
        },
      ),
    );
  }
}
