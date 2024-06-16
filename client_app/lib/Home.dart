import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'firebase_options.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class AlertClass {
  String description = "";
  int count = 0;
  String name="", sensorid="";
  AlertClass(int a) {
    description = 'Fire Alert, Please Evacuate Immediately';
    count = a;
  }
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selected = 0;
  dynamic name = 'Hello User!';
  int countAlerts = 0;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  String status = "";
  bool _callbacksExecuted = false;

  void fetchdata() {
    final ref = FirebaseDatabase.instance.ref().child('Flame sensor/Status');

    ref.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          status = event.snapshot.value.toString();
          print('Status: $status');
        });
      } else {
        print('Data cant be fetched.');
      }
    });
  }

  List<AlertClass> alerts = <AlertClass>[
    AlertClass(0),
  ];
  static const List<Widget> _widgetOptions = <Widget>[
    Icon(Icons.home, size: 30, color: Colors.amber),
    // Icon(Icons.location_pin, size: 30, color: Colors.amber),
    Icon(Icons.contact_phone, size: 30, color: Colors.amber),
    Icon(Icons.medical_information, size: 30, color: Colors.amber),
    Icon(Icons.chat, size: 30, color: Colors.amber),
  ];
  List<String> navigPage = ['/home', '/contact', '/info', '/chat'];

//  List<String> navigPage = ['/home', '/location', '/contact', '/info', '/chat'];

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  final FlutterTts flutterTts = FlutterTts();

  Future<void> readAlert(String alert) async {
    await flutterTts.setLanguage("EN-IN");
    await flutterTts.speak(alert);
  }

  // void _sendSMS(String message, List<String> recipients) async {
  //   String _result = await sendSMS(message: message, recipients: recipients)
  //       .catchError((onError) {
  //     print(onError);
  //   });
  //   print(_result);
  // }


  @override
  Widget build(BuildContext context) {
    // int flag =0;
    // print('----------Before: $status');
    Timer.periodic(Duration(seconds: 30), (timer) {
      fetchdata();
    });
    // print('----------After: $status');
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fireman.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              // if (status == "Fire Detected" || flag == 1)
              //   flag= 1;
              //   Column(
              //     children: alerts.map((c) => charCard(c)).toList(),
              //   );

              if (status == "Fire Detected")
              // flag = 1,

                Column(
                  children: alerts.map((c) => charCard(c)).toList(),
                )

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _widgetOptions.map((Widget icon) {
          return BottomNavigationBarItem(
            icon: icon,
            label: '', // No label
          );
        }).toList(),
        currentIndex: selected,
        onTap: tapped,
      ),
    );
  }

  void tapped(int i) {
    setState(() {
      selected = i;
      Navigator.pushNamed(context, navigPage[i]);
    });
  }

  void generate_alert() {
    setState(() {
      countAlerts += 1;
    });
    alerts.add(AlertClass(countAlerts));
  }

  Widget charCard(AlertClass alert) {
    if (!_callbacksExecuted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        readAlert("Fire Alert, Please Evacuate Immediately");
        fetchEmergencyContact(alert);
      });
    }
    _callbacksExecuted = true;

    return Card(
      color: Colors.white.withOpacity(0.95),
      margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                alerts.remove(alert);
                setState(() {});
              },
              child: Icon(
                Icons.warning_rounded,
                color: Colors.red,
                size: 40.0,
              ),
            ),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            Center(
              child: Text(
                alert.description,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.amber[800],
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Center(
              child: Text(
                'User:'+alert.name,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.amber[800],
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Center(
              child: Text(
                'Sensor ID:'+alert.sensorid,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.amber[800],
                ),
              ),
            ),
            SizedBox(height: 4.0),
          ],
        ),
      ),
    );
  }


  void fetchEmergencyContact(AlertClass alert) async {
    final ref = database.ref().child('Flame sensor/SensorValue');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      int sensorValue = snapshot.value as int;
      String id = '';

      switch (sensorValue) {
        case 1:
          id = 'VCJ5bb8Tvb07YolWpTRU';
          break;
        case 2:
          id = 'OcN4RybPqgYltkm2TT24';
          break;
        case 3:
          id = 'XDHr8p2GCaxs3K6j1QTa';
          break;
        case 4:
          id = 'ueTXg20Rx3QNNQ2sb4Jp';
          break;
        case 5:
          id = 'vrYB8NtuRq3ZrqAm9bTn';
          break;
        default:
          print('Invalid sensor value');
          return;
      }

      final docRef = db.collection("users").doc(id);
      docRef.get().then(
            (DocumentSnapshot doc) {
          final data = doc.data();
          print('-------------data-------------');

          if (data != null && data is Map<String, dynamic>) {
            String phno = data['Emergency contact'];
            String name = data['Name'];
            String sensorId = data['Sensor Id'];

            setState(() {
              alert.name = name;
              alert.sensorid = sensorId;
            });

              sendsms(phno);
          }
          else {
            print('Document data is null or not a Map<String, dynamic>');
          }
        },
        onError: (e) => print("Error getting document: $e"),
      );


    }
    else {
      print('No data available.');
    }
  }

void sendsms(phno) async{
  Uri smsUri = Uri(
    scheme: 'sms',
    path: phno,
    queryParameters: <String, String>{
      'body': 'Fire Alert, Please Contact Immediately'
    },
  );

  if (await canLaunchUrl(smsUri)) {
    await launchUrl(smsUri);
  } else {
    print('Could not launch $smsUri');
  }

}


}


//   Widget charCard(AlertClass alert) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       readAlert("Fire Alert, Please Evacuate Immediately");
//       fetchEmergencyContact(alert);
//
//     });
//
//     return Card(
//       color: Colors.white.withOpacity(0.95),
//       margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             TextButton(
//               onPressed: () {
//                 //readAlert("Fire Alert, Please Evacuate Immediately");
//                 alerts.remove(alert);
//                 setState(() {});
//               },
//               child: Icon(
//                 Icons.warning_rounded,
//                 color: Colors.red,
//                 size: 40.0,
//               ),
//             ),
//             SizedBox(height: 5.0),
//             // Text(
//             //   alert.count.toString(),
//             //   style: TextStyle(
//             //     fontSize: 20.0,
//             //     color: Colors.blue,
//             //   ),
//             // ),
//             SizedBox(height: 5.0),
//             Center(
//               child: Text(
//                 alert.description,
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Colors.amber[800],
//                 ),
//               ),
//             ),
//             SizedBox(height: 4.0),
//            Center( child: Text(
//             alert.name,
//              style: TextStyle(
//              fontSize: 16.0,
//             color: Colors.amber[800],
//           ),
//     )),
//     SizedBox(height: 4.0),
//
//     Center( child: Text(
//     alert.sensorid,
//     style: TextStyle(
//     fontSize: 16.0,
//     color: Colors.amber[800],
//     ),
//     )
//
//     ],
//         ),
//       ),
//     );
//
//   }
//   void fetchEmergencyContact(AlertClass alert) async {
//     final ref = database.ref().child('Flame sensor/RandomValue');
//     final snapshot = await ref.get();
//
//     if (snapshot.exists) {
//       int sensorValue = snapshot.value as int;
//       String id = '';
//
//       switch (sensorValue) {
//         case 1:
//           id = 'VCJ5bb8Tvb07YolWpTRU';
//           break;
//         case 2:
//           id = 'OcN4RybPqgYltkm2TT24';
//           break;
//         case 3:
//           id = 'XDHr8p2GCaxs3K6j1QTa';
//           break;
//         case 4:
//           id = 'ueTXg20Rx3QNNQ2sb4Jp';
//           break;
//         case 5:
//           id = 'vrYB8NtuRq3ZrqAm9bTn';
//           break;
//         default:
//           print('Invalid sensor value');
//           return;
//       }
//
//       final docRef = db.collection("user").doc(id);
//       docRef.get().then(
//             (DocumentSnapshot doc) {
//           final data = doc.data() as Map<String, dynamic>;
//           String phno = data['Emergency contact'];
//           String name = data['Name'];
//           String sensorid = data['Sensor Id'];
//           _sendSMS('Fire Alert, Please Contact Immediately', [phno]);
//
//         },
//         onError: (e) => print("----------Error getting document: $e-------------------"),
//       );
//     } else {
//       print('No data available.');
//     }
//   }
// }
