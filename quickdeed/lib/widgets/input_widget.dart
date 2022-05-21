import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/config/Palette.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class InputWidget extends StatefulWidget {
  final CurrentUser chatUser;
  final IO.Socket? socket;
  final Function setMessage;
  final User? user;
  const InputWidget({Key? key , required this.chatUser , required this.user , required this.socket , required this.setMessage}) : super(key: key);
  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController textEditingController =  TextEditingController();
  String currentMessage = "";

  void sendMessage(String msg , String sourceId ,String targetId) async {
     String jwtToken = await widget.user?.getIdToken().then((val) => val) ?? "";
           widget.setMessage("sent" ,msg);
           if(jwtToken != "") {
             widget.socket?.emit("send", {
               'message': msg,
               'sourceId': sourceId,
               'targetId': targetId,
               'type': 'sent',
               'timestamp': DateTime
                   .now()
                   .millisecondsSinceEpoch,
               'token': jwtToken
             });
           }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children:[
          Material(
            child:  Container(
              margin:  const EdgeInsets.symmetric(horizontal: 1.0),
              child:  IconButton(
                icon: const Icon(Icons.face),
                color: Palette.primaryColor,
                onPressed: (){
                 //TODO: show emojis keypad
                },
              ),
            ),
            color: Colors.white,
          ),

          // Text input
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Palette.primaryTextColor, fontSize: 15.0),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Palette.greyColor),
                ),
                onChanged: (value) => {
                  setState(() {
                    currentMessage = value;
                  })
                },
              ),
            ),
          ),

          // Send Message Button
          Material(
            child:  Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: (){
                  //TODO emit new message
                  if(textEditingController.text.isNotEmpty && widget.user?.uid != null){
                    sendMessage(textEditingController.text, widget.user!.uid, widget.chatUser.userId);
                    textEditingController.clear();
                  }

                },
                color: Palette.primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(color: Palette.greyColor, width: 0.5)),
          color: Colors.white),
    );
  }
}