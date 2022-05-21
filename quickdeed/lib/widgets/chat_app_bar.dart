import 'package:flutter/material.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/config/Assets.dart';
import 'package:quickdeed/config/Palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  final CurrentUser chatUser;
  const ChatAppBar({Key? key , required this.chatUser}) : super(key: key);

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(80.h);
  }
}

class _ChatAppBarState extends State<ChatAppBar> {
  final double height = 100.h;

  final String profilePicture =
      "https://instagram.fhyd11-2.fna.fbcdn.net/v/t51.2885-19/s320x320/124480382_821404835315782_2213267434541466715_n.jpg?_nc_ht=instagram.fhyd11-2.fna.fbcdn.net&_nc_cat=110&_nc_ohc=WxyqhagcuHoAX-NoC9i&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT9Cz23x3C9IETgHwhoyS-LCZ9-guAL4upjTOoVUfoL2Mg&oe=61FB0289&_nc_sid=7bff83";

  @override
  Widget build(BuildContext context) {
    var textHeading = TextStyle(
        color: Palette.primaryTextColor,
        fontSize: 20.sp); // Text style for the name
    var textStyle = TextStyle(
        color: Palette.secondaryTextColor); // Text style for everything else

    double width =
        MediaQuery.of(context).size.width; // calculate the screen width
    return Material(
      child: Container(
          decoration: new BoxDecoration(boxShadow: [
            //adds a shadow to the appbar
            new BoxShadow(
              color: Colors.black,
              blurRadius: 5.0,
            )
          ]),
          child: Container(
            color: Palette.primaryBackgroundColor,
            child: Row(children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Center(
                    child: CircleAvatar(
                      radius: (80 - (width * .06)) / 2,
                      backgroundImage:  NetworkImage(widget.chatUser.profilePic),
                    ),
                  ),
                ),
              ),
              Expanded(
                  //we're dividing the appbar into 7 : 3 ratio. 7 is for content and 3 is for the display picture.
                  flex: 7,
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          height: 70 - (width * .06),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: Icon(
                                    Icons.arrow_back,
                                    color: Palette.secondaryColor,
                                  ))),
                              Expanded(
                                  flex: 7,
                                  child: Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text( widget.chatUser.userName , style: textHeading),
                                    ],
                                  ))),
                            ],
                          )),
                      //second row containing the buttons for media
                      // Container(
                      //     height: 23.h,
                      //     padding: EdgeInsets.fromLTRB(20, 5, 5, 0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: <Widget>[
                      //         Text(
                      //           'Photos',
                      //           style: textStyle,
                      //         ),
                      //         VerticalDivider(
                      //           width: 30.w,
                      //           color: Palette.primaryTextColor,
                      //         ),
                      //         Text(
                      //           'Videos',
                      //           style: textStyle,
                      //         ),
                      //         VerticalDivider(
                      //           width: 30.w,
                      //           color: Palette.primaryTextColor,
                      //         ),
                      //         Text('Files', style: textStyle)
                      //       ],
                      //     )),
                    ],
                  ))),
              //This is the display picture

            ]),
          )),
    );
  }

  Size get preferredSize => Size.fromHeight(height);
}
