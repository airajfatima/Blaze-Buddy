import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mini_project/start.dart';

class Loading extends StatefulWidget {
  //const Loading({super.key});
  const Loading({Key? key}) : super(key: key);


  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void initState() {
    super.initState();
    // Simulate loading time using Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to home screen after loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Start()),
      );
    });
  }

  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.orange,
        body: Center(
          //padding: EdgeInsets.all(40.0),
          //child: Text('Loading $currentTime'),
          child:  SpinKitDualRing(
            color: Colors.white,
            size: 50.0,
          ),

        )
    );
  }
}



