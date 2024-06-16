import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6C744),
        title: Text("Safety Guidelines",style:TextStyle(color: Color(0xFFFFFAFE),fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white,),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: SingleChildScrollView(
        // child:DecoratedBox(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),

        child:Container(
          padding:EdgeInsets.all(15),
          color:  Color(0xFFFFFAFE),
          child: Center(
            child: RichText(
              text:TextSpan(
                style:TextStyle(fontSize: 18.0,color: Colors.grey[800],),
                children: [
                  TextSpan(
                    text:'Exit Strategy\n\n',
                    style:TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF6C744),
                      fontSize: 24,
                      // decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                  TextSpan(
                    text:'1. Know Multiple Exits:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'Familiarise yourself with all possible exits in any building you frequent, including emergency exits, stairwells, and windows that can be used for escape.\n\n',
                  ),

                  TextSpan(
                    text:'2. Primary Exit Blocked:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'If your primary exit is blocked by fire or smoke, find an alternative exit route. This may include using a window or another door.\n\n',
                  ),
                  TextSpan(
                    text:'3. Stay Low:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'When moving through smoke-filled areas, stay close to the ground where the air is cleaner and cooler.\n\n',
                  ),
                  TextSpan(
                    text:'4. Do Not Use Elevators:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'Elevators can become a trap during a fire. Always use stairs for evacuation.\n\n',
                  ),
                  TextSpan(
                    text:'5. Assist Others:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'Help individuals who are struggling to evacuate, but do not jeopardize your own safety in the process.\n\n',
                  ),
                  TextSpan(
                    text:'\nFirst Aid\n\n',
                    style:TextStyle
                      (fontWeight: FontWeight.bold,
                      color: Color(0xFFF6C744),
                      // decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text:'1. Minor Burns:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'- Cool burn with lukewarm water for 20 minutes.\n- Cover with sterile bandage.\n- Seek medical attention for large burns.\n\n',
                  ),
                  TextSpan(
                    text:'2. Smoke Inhalation:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'- Move the individual to an area with fresh air.\n- Help the person to sit upright to ease breathing.\n- Seek medical attention if person experiences difficulty in breathing.\n\n',
                  ),
                  TextSpan(
                    text:'3. CPR (Cardiopulmonary Resuscitation):\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'- If person is unresponsive and not breathing normally, begin CPR immediately.\n- Perform chest compressions at 100-120 per minute.\n- Use an AED (Automated External Defibrillator) if available.\n\n',
                  ),

                  TextSpan(
                    text:'4. Eye Irritation:\n',
                    style:TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF6C744),),
                  ),
                  TextSpan(
                    text:'- Flush with clean water for 15 minutes.\n- Do not rub.\n- Seek medical attention for persistent irritation or vision changes.\n\n',
                  ),
                ],
              ),
            ),
          ),
          // Text(
          //   'Exit Strategy:\n1. Know Multiple Exits:\nFamiliarize yourself with all possible exits in any building you frequent, including emergency exits, stairwells, and windows that can be used for escape.\n2. Primary Exit Blocked? Find Alternatives:\nIf your primary exit is blocked by fire or smoke, use an alternative exit route. This may include using a window or another door.\n3. Stay Low:\nWhen moving through smoke-filled areas, stay close to the ground where the air is cleaner and cooler.\n4. Close Doors Behind You:\nClose doors behind you as you evacuate to slow down the spread of smoke and fire.\n5. Do Not Use Elevators:\nElevators can become a trap during a fire. Always use stairs for evacuation.\n6. Assist Others:\nHelp individuals who are struggling to evacuate, but do not jeopardize your own safety in the process.\n',
          //   style: TextStyle(fontSize: 20),
          // ),
        ),
        // ),
      ),
    );
  }
}
