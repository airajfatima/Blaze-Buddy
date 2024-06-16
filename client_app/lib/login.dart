import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';


class Client extends StatefulWidget {
  //const Client({super.key});
  const Client({Key? key}) : super(key: key);


  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  TextEditingController emergencyController = TextEditingController();
  TextEditingController sensorController = TextEditingController();

  void storedata() async{
    final user = <String, dynamic>{
      "Name": nameController.text,
      "Phno": phnoController.text,
      "Emergency contact": emergencyController.text,
      "Sensor Id": sensorController.text

    };
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("users").add(user);
    print('----------------------User details added: ${docRef.id}----------------');
}
    catch (e) {
      print('Error adding user: $e');
    }
  }

  @override


    // db.collection("users").add(user).then((DocumentReference doc) =>
    //     print('User details added: ${doc.id}'));

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'Registration Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.orange[700],
      ),

      body:Container(
          margin: EdgeInsets.only(left:20.0,top:30,right:20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height:10.0,),
              Container(
                padding: EdgeInsets.only(left:10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(border:InputBorder.none),
                ),
              ),
              SizedBox(height:15.0,),


              Text("Mobile number",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height:10.0,),
              Container(
                padding: EdgeInsets.only(left:10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: phnoController,
                  decoration: InputDecoration(border:InputBorder.none),
                ),
              ),
              SizedBox(height:15.0,),

              Text("Emergency mobile number",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height:10.0,),
              Container(
                padding: EdgeInsets.only(left:10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emergencyController,

                  decoration: InputDecoration(border:InputBorder.none),
                ),
              ),
              SizedBox(height:15.0,),

              Text("Sensor ID",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height:10.0,),
              Container(
                padding: EdgeInsets.only(left:10.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: sensorController,

                  decoration: InputDecoration(border:InputBorder.none),
                ),
              ),
              SizedBox(height:30.0,),

              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    storedata();
                    nameController.clear();
                    phnoController.clear();
                    emergencyController.clear();
                    sensorController.clear();

                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade700),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color:Colors.white),
                  ),
                ),
              ),
            ],
          )
      ),



    );
  }
}