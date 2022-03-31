import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/auth_controller.dart';
import 'package:senior_project/google_sign_in.dart';
import 'package:senior_project/signup_page.dart';
import 'package:senior_project/test_calendar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:senior_project/icons/custom_icons_icons.dart';
import 'camera_bpm/calc_heart.dart';
import 'med_list.dart';

//Using sample UI from a tutorial, Will change later
class AddMed extends StatefulWidget {
  const AddMed({Key? key}) : super(key: key);

  @override
  _AddMedState createState() => _AddMedState();
}

class _AddMedState extends State<AddMed> {

  void _navigateToList(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedList()));
  }

  void _navigateToCalendar(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestCalendar()));
  }

  void _navigateToHeart(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalcHeartPage()));
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

  var nameController = TextEditingController();
  var typeController = TextEditingController();
  var dateInput = TextEditingController();
  var quantityController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
              "Add a medication",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
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
                SizedBox(height: 30),
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
                            height: 50,
                            child: Icon(Icons.remove_circle_outline),//Image.asset('img/pills_graphic.png')
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
                          onPrimary: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.medication),//Image.asset('img/bottle_graphic.png')
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
                          onPrimary: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(CustomIcons.vaccines_black_24dp),//Image.asset('img/shot_graphic.png')
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
                          onPrimary: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(height: 20,),
                Container(
                  height: 50,
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
                  SizedBox(height: 20),
                Container(
                  //width: 165,
                  height: 50,
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
                      hintText: "Start",
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
                SizedBox(height: 20,),
                Row(children: [
                  Expanded(child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color:Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                      )
                    ),
                    child: TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.medication, size: 35),
                        hintText: "Quantity",
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
          SizedBox(height: 50),
          GestureDetector(
            onTap: (){
              FirebaseFirestore.instance.collection('UserData').doc(uid).collection('MedicationList').add({
                'MedName' : nameController.text.trim(),
                'MedType': typeMed(),
                'StartDate': dateInput.text.trim(),
                'Units': selectedValue,
              });
              _navigateToList(context);
            },
            child: Container(
                width: w * 0.5,
                height: h * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage(
                          "img/mesh.png"
                      ),
                      fit: BoxFit.cover
                  ),
                ),
                child: Center(
                  child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                      )
                  ),
                )
            ),
          ),
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

    );
  }
}

