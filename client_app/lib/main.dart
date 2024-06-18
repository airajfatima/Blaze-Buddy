import 'package:flutter/material.dart';
import 'Home.dart';
import 'chat.dart';
import 'info.dart';
import 'loading.dart';
import 'location.dart';
import 'contact.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'start.dart';

 void  main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
 );

 Gemini.init(apiKey: "AIzaSyCnXcQVTl9V5a7YrE75Z_NEbYKTkvBr0DA",);

 runApp(MaterialApp(
//home: Home(),
  debugShowCheckedModeBanner: false,


  initialRoute: '/',
  routes: {
   '/': (context) => Loading(),
   '/start': (context)=> Start(),
   '/home': (context) => Home(),
   '/chat': (context) => chatPage(),
   '/location': (context) => location(),
   '/contact': (context) => ContactUsApp(),
   '/info': (context) => Info(),
  },

 )
 );
}


