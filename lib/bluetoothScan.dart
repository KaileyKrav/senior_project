import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScan extends StatelessWidget {

  FlutterBlue flutterBlue = FlutterBlue.instance;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
        child:Center(
          child: AnimatedButton(
            height: 70,
            width: 200,
            text: 'SCAN',
            isReverse: true,
            selectedTextColor: Colors.black,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            backgroundColor: Colors.black,
            borderColor: Colors.white,
            borderRadius: 0,
            borderWidth: 2, onPress: () {
            // Start scanning
            flutterBlue.startScan(timeout: Duration(seconds: 4));

            // Listen to scan results
            var subscription = flutterBlue.scanResults.listen((results) {
              // do something with scan results
              for (ScanResult r in results) {
                print('${r.device.name} found! rssi: ${r.rssi}');
              }
            });

            // Stop scanning
            flutterBlue.stopScan();
          },
          ),
        ),
      ),
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: FlutterBlue.instance.scanResults,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    children: snapshot.data!.map((e) {
                      if (e.device.name.isNotEmpty) {
                        return Card(
                          child: ExpansionTile(
                            title: Text(e.device.name.toString()),//Text(e.device.name),
                            children: <Widget>[
                              Row(
                          children: <Widget>[
                            Expanded(
                            child: AnimatedButton(
                              height: 30,
                              width: 100,
                              text: 'CONNECT',
                              textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.white
                              ),
                              isReverse: true,
                              selectedTextColor: Colors.black,
                              transitionType: TransitionType.LEFT_TO_RIGHT,
                              backgroundColor: Colors.black,
                              borderColor: Colors.white,
                              borderRadius: 0,
                              borderWidth: 2, onPress: () async {
                               await e.device.connect(autoConnect: false);
                                List<BluetoothService> services = await e.device.discoverServices();
                                services.forEach((service) async {
                                  print(service.uuid);
                                  if (service.uuid.toString() == '0000180d-0000-1000-8000-00805f9b34fb') {
                                    print('Heartbeat uuid');
                                    var characteristics = service.characteristics;
                                    for (BluetoothCharacteristic c in characteristics) {
                                      //print(c.uuid.toString());
                                      if (c.uuid.toString() == '00002a37-0000-1000-8000-00805f9b34fb') {
                                        print('characteristic uuid');
                                        //if (c.properties.read) {
                                        List<int> val = await c.read();
                                        print(val);
                                        List myList = [{
                                          'BPM': val[0],
                                          'Time': DateTime.now().toUtc(),
                                        }];
                                        FirebaseFirestore.instance.collection('UserData').doc(uid).collection('HeartRate').doc('Data').update({
                                          'Data': FieldValue.arrayUnion(myList),
                                        });
                                          /*await c.setNotifyValue(true);
                                          c.value.listen((value) async {
                                            //value = await c.read();
                                            if (value.isNotEmpty) {
                                              print(value);
                                              var binary = int.parse(value[0].toString()).toRadixString(2);
                                              var bit = binary.substring(binary.length - 1);
                                              var intBit = int.parse(bit);
                                              if (intBit == 0) {
                                                //8-bit
                                                var bpm = int.parse(value[2].toString(), radix: 16);
                                                print('worked ' + bpm.toString());
                                              }
                                              else {
                                                print('16 bit not converted');
                                              }
                                            }
                                            else {
                                              print('empty value');
                                            }
                                          });*/
                                        //}
                                        /*else {
                                          print('read property not set');
                                        }*/
                                      }
                                    }
                                  }
                                });

                            },
                          ),
                        ),
                            Expanded(
                              child: AnimatedButton(
                                height: 30,
                                width: 100,
                                text: 'Disconnect',
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white
                                ),
                                isReverse: true,
                                selectedTextColor: Colors.black,
                                transitionType: TransitionType.LEFT_TO_RIGHT,
                                backgroundColor: Colors.black,
                                borderColor: Colors.white,
                                borderRadius: 0,
                                borderWidth: 2, onPress: () {
                                e.device.disconnect();
                              },
                              ),
                            ),
                      ],
                      ),
                      ],
                          ),
                        );
                      }
                      else {
                        return Card(
                          child: ListTile(
                            title: Text(e.device.id.toString()),
                          ),
                        );
                      }
                    }).toList(),
                  );
                }
              },
          ),
          ),
    ],
      ),
    );
  }

}