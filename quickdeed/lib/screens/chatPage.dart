import 'package:flutter/material.dart';
import 'package:quickdeed/widgets/chatAppBar.dart';
import 'package:quickdeed/widgets/chatItemWidget.dart';
import 'package:quickdeed/widgets/chatListWidget.dart';
import 'package:quickdeed/widgets/inputWidget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: ChatAppBar(), // Custom app bar for chat screen
          body: Stack(children: <Widget>[
            Column(
              children: <Widget>[
              ChatListWidget(),//Chat list 
                InputWidget() // The input widget
              ],
            ),
          ]
    )
      )
    );
  }


}