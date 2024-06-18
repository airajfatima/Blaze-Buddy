import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fireman_app/pages/map_utils.dart';
import 'package:fireman_app/pages/call.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import '../firebase_options.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String status = "";
  String phno1="1234567890";
  String name1="Name 1";
  double latitude = 0.0;
  double longitude = 0.0;
  String address = "";
  double latitude1 = 17.4062;
  double longitude1 = 78.4691;
  String address1 = "Address 1";
  final String googleMapsApiKey = 'AIzaSyAIpuJIPdUt_-TEWdTdUNjwp2Im6_KZWQc';

  void fetchdata() {
    final statusRef = FirebaseDatabase.instance.ref().child('Flame sensor/Status');
    final locationRef = FirebaseDatabase.instance.ref().child('Flame sensor/Location');
    statusRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          status = event.snapshot.value.toString();
          print('Status: $status');
        });
      } else {
        print('Status data can\'t be fetched.');
      }
    });

    locationRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          String loc = event.snapshot.value.toString();
          List<String> latLong = loc.split(',');
          latitude = double.parse(latLong[0]);
          longitude = double.parse(latLong[1]);
          _getAddressFromLatLng(latitude, longitude);
          print('Location: $loc');
        });
      } else {
        print('Location data can\'t be fetched.');
      }
    });
  }

  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleMapsApiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        setState(() {
          address = data['results'][0]['formatted_address'];
        });
      } else {
        setState(() {
          address = 'No address available';
        });
      }
    } else {
      setState(() {
        address = 'Error fetching address';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchdata();
      if (status == "Fire Detected"){
        fetchEmergencyContact();
        latitude1 = latitude;
        longitude1 = longitude;
        address1 = address;
      }
    });
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'BlazeBuddy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.orange[700],
        leading: GestureDetector(
          onTap: () {
            print('Hello');
          },
          child: Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Image.asset(
              'D:/Flutter/fireman_app/assets/icons/Blazebuddy.jpg',
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildNotificationContainer(
            name: name1,
            contact: phno1,
            address: address1,
            latitude: latitude1,
            longitude: longitude1,
          ),
          // Add more containers here if needed
        ],
      ),
    );
  }

  void fetchEmergencyContact() async {
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
            phno1 = data['Emergency contact'];
            name1 = data['Name'];
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
  Widget _buildNotificationContainer({
    required String name,
    required String contact,
    required String address,
    required double latitude,
    required double longitude,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.orange[50]!, Colors.orange[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(
                color: Colors.orange[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Contact: $contact',
              style: TextStyle(
                color: Colors.orange[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Address: $address',
              style: TextStyle(
                color: Colors.orange[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(minWidth: 100),
                  child: FloatingActionButton(
                    onPressed: () {
                      MapUtils.openMap(latitude, longitude);
                    },
                    backgroundColor: Colors.orange[600],
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        Text(
                          'Accept',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  constraints: BoxConstraints(minWidth: 100),
                  child: FloatingActionButton(
                    onPressed: () {
                      CallInFlutter.callnumber(contact);
                    },
                    backgroundColor: Colors.orange[600],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Call',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}