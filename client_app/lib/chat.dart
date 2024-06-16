import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class chatPage extends StatefulWidget {
  //const chatPage({super.key});
  const chatPage({Key? key}) : super(key: key);

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  final Gemini gemini_ob = Gemini.instance;
    String GEMINI_KEY = "AIzaSyCnXcQVTl9V5a7YrE75Z_NEbYKTkvBr0DA";
    ChatUser currUser = ChatUser(id:"0",firstName: "User");
    ChatUser geminiUser = ChatUser(id:"1",firstName: "Gemini");
    List<ChatMessage> msgs = [];

    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF6C744),
        title: Text(
          "Chat",
          style: TextStyle(
              color: Color(0xFFFFFAFE),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: buildUI(),
    );
  }
  Widget buildUI(){
     return DashChat(
       currentUser: currUser,
       onSend: sendmsg,
       messages: msgs,
 
     );
  }
  void sendmsg(ChatMessage chatMessage){
      setState(() {
        msgs = [chatMessage, ...msgs];

      });
      try{
        String ip = chatMessage.text;
        gemini_ob.streamGenerateContent(ip).listen((event) {
          ChatMessage? lastMessage = msgs.firstOrNull;
          if(lastMessage!=null && lastMessage.user == geminiUser){
            lastMessage = msgs.removeAt(0);
            String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}" )?? " ";
            lastMessage.text += response;
            setState(() {
              msgs = [lastMessage!, ...msgs];
            });
          }
          else{
            String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}" )?? " ";
            ChatMessage newmsg = ChatMessage(user: geminiUser, createdAt: DateTime.now(), text:response );
          setState(() {
            msgs = [newmsg, ...msgs];
          });
          }
        });
      }
      catch(e){
        print(e);
      }
  }

}
