import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/Models/message_model.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:quickdeed/widgets/chat_list_widget.dart';
import 'package:quickdeed/widgets/input_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:audioplayers/audioplayers.dart';

import '../arguments/chat_screen_args.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // get chat user args
    final args = ModalRoute.of(context)!.settings.arguments as ChatUserArguments;
    return SafeArea(
      child: Helper(chatUser: args.user , currentUser:user)
    );
  }

}


class Helper extends StatefulWidget {
  final CurrentUser chatUser;
  final User? currentUser;
  const Helper({Key? key , required this.chatUser , required this.currentUser}) : super(key: key);

  @override
  _HelperState createState() => _HelperState();
}

class _HelperState extends State<Helper> {
  IO.Socket? socket;
  List<Message> messages = [];
  static AudioCache player = AudioCache();
  final sendTone = "audio_sender.mp3";
  final receiveTone = "audio_receiver.mp3";


  void setMessage(String type , String message){
    Message msgModel =  Message(type: type, message: message, senderId: widget.currentUser!.uid, receiverId: widget.chatUser.userId , timestamp:DateTime.now().millisecondsSinceEpoch );
     setState(() {
       messages.insert(0 ,msgModel);
       // play sent message sound
       player.play(sendTone);
     });
  }

  void connect(){
    // url = https://major-chat-server.herokuapp.com
    // http://192.168.232.118:5000/
    socket = IO.io("https://major-chat-server.herokuapp.com" , <String, dynamic> {
      "transports" :["websocket"],
      "autoConnect" : false,
      'forceNew':true
    });
    socket?.connect();
    socket?.onConnect((data){
      print('connected');
      socket?.on("message",(payload){
        print("data from server $payload");
        String receiverId = payload['targetId'];
        String senderId = payload['sourceId'];
        String type = payload['type'];
        int timestamp = payload['timestamp'];
        String message = payload['message'];
        // setMessage("received", payload['message']);
        if(mounted){
          setState(() {
            messages.insert(0 ,Message(type: type , senderId: senderId, receiverId: receiverId , timestamp: timestamp , message: message));
            // play received message sound
            player.play(receiveTone);
          });
        }
      });
    });
    socket?.emit("signin",widget.currentUser?.uid);
  }

  void handleMessageList(List<Message> msgs){
    setState(() {
      messages = msgs;
    });
  }

  //TODO fetch user messages
  void getMsgs(senderId , receiverId){
    fetchMessages(senderId , receiverId).then((val) => handleMessageList(val));
  }

  @override
  void initState() {
    super.initState();
    User? u = FirebaseAuth.instance.currentUser;
    if(u != null){
      String senderId = u.uid;
      String receiverId = widget.chatUser.userId;
      getMsgs(senderId,receiverId);
    }
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black87,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage:  NetworkImage(widget.chatUser.profilePic),
              ),
              SizedBox(width: 8.w,),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.chatUser.userName,
                    style: GoogleFonts.pacifico(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(255 , 255 , 255 , 1)
                    ),
                  ),
                  Text(
                    "online",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: const Color.fromRGBO(255 , 255 , 255 , 1)
                    ),
                  ), // to show status of the user like  typing , last seen , online
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(MdiIcons.dotsVertical)
            )
          ],
        ),
        //ChatAppBar( chatUser: widget.chatUser,), // Custom app bar for chat screen
        body: Container(
          color: Colors.black12,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
              children:[
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                children:[
                  ChatListWidget(chatList:messages
                      , currentUser: widget.currentUser),//Chat list
                ],
            ),
              ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InputWidget(chatUser: widget.chatUser ,user:  widget.currentUser,socket:socket , setMessage: setMessage)
                ) // The input widget
          ]
          ),
        )
    );
  }
}
