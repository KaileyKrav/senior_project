import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/medication_events/details_page.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../med_list.dart';

class EditMed extends StatefulWidget {
  final docID;
  EditMed(this.docID);

  @override
  State<StatefulWidget> createState() => _EditMedState(docID);

}
class _EditMedState extends State<EditMed> {

  void _navigateToScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsScreen(docID)));
  }

  String typeMed() {
    String type;
    if(p == true) {
      type = "Pill";
    }
    else if (l == true) {
      type = "Liquid";
    }
    else if (s = true) {
      type = "Shot";
    }
    else {
      type = "Null";
    }
    return type;
  }

  medDays() {
    List<String> daysOfWeek = [];
    for (int i = 0; i < 7; i++) {
      if (values[i] == false) {
        switch(i) {
          case 0: {
            daysOfWeek.add("Sn");
          }
          break;
          case 1: {
            daysOfWeek.add("M");
          }
          break;
          case 2: {
            daysOfWeek.add("T");
          }
          break;
          case 3: {
            daysOfWeek.add("W");
          }
          break;
          case 4: {
            daysOfWeek.add("Th");
          }
          break;
          case 5: {
            daysOfWeek.add("F");
          }
          break;
          case 6: {
            daysOfWeek.add("S");
          }
          break;
        }
      }
    }
    return daysOfWeek;
  }

  var nameController = TextEditingController();
  var typeController = TextEditingController();
  var dateInput = TextEditingController();
  var quantityController = TextEditingController();
  var timeController = TextEditingController();
  final db = FirebaseFirestore.instance;
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  String medType = '';
  String? selectedValue;
  List<String> items = [
    'tablets',
    'mL',
    'tsp',
    'other',
  ];
  bool p = false;
  bool l = false;
  bool s = false;
  final values = List.filled(7, true);

  final docID;
  _EditMedState(this.docID);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 35,),
            Container(
            child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').doc(docID).snapshots(),
                builder: (BuildContext context, AsyncSnapshot <DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      width: w,
                      margin: const EdgeInsets.only(left:20, right:20),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Edit " + snapshot.data!['MedName'],
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(139, 193, 188, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: w,
                      margin: const EdgeInsets.only(left:20, right:20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "Type",
                            style: TextStyle(
                              fontSize: 20,
                              color:Colors.grey[500],
                            ),
                          ),
                          Container(
                              child: new ButtonBar (
                                alignment: MainAxisAlignment.center,
                                buttonPadding:EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10
                                ),
                                children: [
                                  ElevatedButton(
                                    child: SizedBox(
                                      width: 50,
                                      height: 70,
                                      child: Icon(Icons.remove_circle_outline, size: 40,),//Image.asset('img/pills_graphic.png')
                                    ),
                                    onPressed: () {
                                      if(l == true || s == true) {
                                        l = false;
                                        s = false;
                                        p = true;
                                      }
                                      else {
                                        p = true;
                                      }
                                      //print(p);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: SizedBox(
                                      width: 50,
                                      height: 70,
                                      child: Icon(Icons.medication, size: 40,),//Image.asset('img/bottle_graphic.png')
                                    ),
                                    onPressed: () {
                                      if(p == true || s == true) {
                                        p = false;
                                        s = false;
                                        l = true;
                                      }
                                      else {
                                        l = true;
                                      }
                                      //print(l);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: SizedBox(
                                      width: 50,
                                      height: 70,
                                      child: Image.asset('img/outline_vaccines_black_24dp.png'),
                                    ),
                                    onPressed: () {
                                      if(l == true || p == true) {
                                        l = false;
                                        p = false;
                                        s = true;
                                      }
                                      else {
                                        s = true;
                                      }
                                      //print(p);
                                      //print(l);
                                      //print(s);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      onPrimary: Color.fromRGBO(139, 193, 188, 1),
                                    ),
                                  ),
                                ],
                              )
                          ),
                          SizedBox(height: 30,),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: "Medication Name",
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
                                    )
                                )
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            //width: 165,
                            height: 60,
                            decoration: BoxDecoration(
                              color:Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                hintText: "Start",
                                icon: Icon(Icons.calendar_today, size: 25),
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

                                  setState(() {
                                    dateInput.text = formattedDate;
                                  });
                                }
                                else{
                                  print("no date chosen");
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 30,),
                          Row(children: [
                            Expanded(child: Container(
                              width: 150,
                              height: 60,
                              decoration: BoxDecoration(
                                  color:Colors.white,
                                  border: Border.all(
                                    color: Colors.grey,
                                  )
                              ),
                              child: TextField(
                                controller: quantityController,
                                decoration: InputDecoration(
                                  hintText: "Quantity",
                                  icon: Icon(Icons.medication, size: 35),
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
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: DropdownButton2(
                                hint: Text('Units'),
                                items: items.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ),).toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                    //print(selectedValue);
                                  });
                                },
                                //buttonHeight: 30,
                                //buttonWidth: 80,
                                //itemHeight: 40,
                              ),
                            ),
                          ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: w,
                      margin: const EdgeInsets.only(left:20, right:20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "Frequency",
                            style: TextStyle(
                              fontSize: 20,
                              color:Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: WeekdaySelector(
                        onChanged: (int day) {
                          setState(() {
                            final index = day % 7;
                            values[index] = !values[index];
                          });
                        },
                        values: values,
                        selectedFillColor: Color.fromRGBO(139, 193, 188, 1),
                        firstDayOfWeek: 0,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: w,
                      margin: const EdgeInsets.only(left:20, right:20),
                      height: 70,
                      decoration: BoxDecoration(
                          color:Colors.white,
                          border: Border.all(
                            color: Colors.grey,
                          )
                      ),
                      child: TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: "Daily",
                          icon: Icon(Icons.access_time_outlined, size: 35),
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
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(height: 40),
                    GestureDetector(
                      onTap: (){
                        //FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').doc(docID).delete();
                        FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').doc(docID).set({
                          'MedName' : nameController.text.trim(),
                          'MedType': typeMed(),
                          'StartDate': dateInput.text.trim(),
                          'Quantity': quantityController.text.trim(),
                          'Units': selectedValue,
                          'Days': medDays(),
                          'Time': timeController.text.trim(),
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(docID)));
                      },
                      child: Container(
                        width: w * 0.3,
                        height: h * 0.05,
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(30),
                          /*image: DecorationImage(
                      image: AssetImage(
                          "img/mesh.png"
                      ),
                      fit: BoxFit.cover
                  ),*/
                          color: Color.fromRGBO(139, 193, 188, 1),
                        ),
                        child: Center(
                          child: Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}