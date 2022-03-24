
import 'package:flutter/material.dart';
import 'package:senior_project/medication_events/add_event.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
//class Calendar extends StatelessWidget {

  /*void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEventPage()));
  }*/

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    CalendarFormat _format = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _selectedDay;

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );

    return Scaffold(
      backgroundColor: Colors.white,
        //body: SlidingUpPanel(
        /*panelBuilder: (ScrollController sc) => _scrollingList(sc),
          //body: Center(
        //child: Text("This is the sliding Widget"),
        //),
      collapsed: Container(
        decoration: BoxDecoration(
          borderRadius: radius
        ),
      ),*/
      //body: Column(
        //children: <Widget>[
              /*Container(
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
              ),*/
              //Card(
                //clipBehavior: Clip.antiAlias,
                //margin: const EdgeInsets.all(8.0),
                //child: TableCalendar(
        body: TableCalendar(
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  focusedDay: _focusedDay,
                  calendarFormat: _format,

                  onFormatChanged: (calFormat) {
                    if(_format != calFormat) {
                      setState(() {
                        _format = calFormat;
                      });
                    };
                  },

                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,

                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },

                  onDaySelected: (selectDay, focusDay) {
                    if(!isSameDay(_selectedDay, selectDay)) {
                      print(_selectedDay);
                      print('\n');
                      print(selectDay);
                      print('\n');
                      setState(() {
                        _selectedDay = selectDay;
                        _focusedDay = focusDay;
                      });
                    }
                    print(_selectedDay);
                  },

                  onPageChanged: (focusDay) {
                    _focusedDay = focusDay;
                  },

                  calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
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

                  headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                      color:Color.fromRGBO(252, 198, 205, 100),
                    ),
                    headerMargin: const EdgeInsets.only(bottom: 8.0),
                    titleTextStyle: TextStyle(color: Colors.black),
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.black),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                  ),
              ),
              //),
            //],
         // ),
      //borderRadius: radius,
        //),
    );
  }

  /*Widget _scrollingList(ScrollController sc){
    return ListView.builder(
      controller: sc,
      itemCount: 50,
      itemBuilder: (BuildContext context, int i){
        return Container(
          padding: const EdgeInsets.all(12.0),
          child: Text("$i"),
        );
      },
    );
  }*/
}
