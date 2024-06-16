import 'package:flutter/material.dart';
 class location extends StatefulWidget {
   //const location({super.key});
   const location({Key? key}) : super(key: key);


   @override
   State<location> createState() => _locationState();
 }

 class _locationState extends State<location> {
   @override
   Widget build(BuildContext context) {
     return const Scaffold(
       body:SafeArea(child: Text('location')),
     );
   }
 }

