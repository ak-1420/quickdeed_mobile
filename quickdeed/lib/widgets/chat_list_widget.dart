import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickdeed/Models/message_model.dart';
import 'package:quickdeed/config/Palette.dart';

class ChatListWidget extends StatefulWidget{
  final List<Message> chatList;
  final User? currentUser;
  const ChatListWidget({Key? key , required this.chatList ,required this.currentUser}) : super(key: key);

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {


  Widget renderSentMessage(int index){
    return Container(
        child: Column(
            children:[
          Row(
            children:[
              Container(
                child: Text(
                  widget.chatList[index].message,
                  style: TextStyle(color: Palette.selfMessageColor),
                ),
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                width: 200.0,
                decoration: BoxDecoration(
                    color: Palette.selfMessageBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0)),
                margin: const EdgeInsets.only(right: 10.0),
              )
            ],
            mainAxisAlignment:
            MainAxisAlignment.end, // aligns the chatitem to right end
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Container(
                  child: Text(
                    DateFormat('dd MMM kk:mm')
                        .format(DateTime.fromMillisecondsSinceEpoch(widget.chatList[index].timestamp)),
                    style: TextStyle(
                        color: Palette.greyColor,
                        fontSize: 12.0,
                        fontStyle: FontStyle.normal),
                  ),
                  margin: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                )])
        ]));
  }

  Widget renderReceivedMessage(int index){
    return Container(
      child: Column(
        children: [
          Row(
            children:[
              Container(
                child: Text(
                  widget.chatList[index].message,
                  style: TextStyle(color: Palette.otherMessageColor),
                ),
                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                width: 200.0,
                decoration: BoxDecoration(
                    color: Palette.otherMessageBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0)),
                margin: const EdgeInsets.only(left: 10.0),
              )
            ],
          ),
          Container(
            child: Text(
              DateFormat('dd MMM kk:mm')
                  .format(DateTime.fromMillisecondsSinceEpoch(widget.chatList[index].timestamp)),
              style: TextStyle(
                  color: Palette.greyColor,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal),
            ),
            margin: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      margin: const EdgeInsets.only(bottom: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(widget.chatList.isEmpty){
      return  Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('No Chat')),
        ],
      );
    }
    return Flexible(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemBuilder: (context, index) => (widget.chatList[index].senderId == widget.currentUser?.uid) ? renderSentMessage(index) : renderReceivedMessage(index), //type can be sent / received
          itemCount: widget.chatList.length,
          reverse: true,
        ),
      ),
    );
  }
}

