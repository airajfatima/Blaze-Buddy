import 'package:flutter/material.dart';
import 'package:mini_project/Home.dart';
import 'package:mini_project/login.dart';

class Start extends StatefulWidget {
  const Start({Key? key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 30.0,
            bottom: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Icon(Icons.home, color: Colors.cyan.shade400),
              backgroundColor: Colors.white,
            ),
          ),
          Positioned(
            right: 1.0,
            bottom: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Client()));

              },
              child: Icon(Icons.add, color: Colors.cyan.shade400), // Example icon, change as needed
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          'Blaze Buddy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFD8F092),
      ),
      body: Stack(
        fit: StackFit.expand,

        children: [
          // Background image

          Positioned.fill(
            child: Image.asset(
              'assets/logo1.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          //Greeting message
          // Positioned(
          //   top: 10, // Adjust this value to move the text vertically
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Text(
          //       'Brightening Safety, Dimming Danger!',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}