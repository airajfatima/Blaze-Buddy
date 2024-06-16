import 'package:flutter/material.dart';



class ContactUsApp extends StatelessWidget {
  const ContactUsApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFF6C744),
          title: Text(
            "Contact Us",
            style: TextStyle(
                color: Color(0xFFFFFAFE),
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
    leading: IconButton(
    icon: Icon(Icons.home, color: Colors.white,),
    onPressed: () {
      Navigator.pushNamed(context, '/home');
    },
    ),
    ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'For any queries contact us at:',
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Color(0xFFF6C744),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Color(0xFFF6C744),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                        'BlazeBuddy@gmail.com',
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                        )
                    )
                  ]
              ),
              SizedBox(height: 20.0),
              Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Color(0xFFF6C744),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                        '1234567890',
                        style: TextStyle(
                          fontSize: 18.0,
                          letterSpacing: 1.0,
                        )
                    )
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
