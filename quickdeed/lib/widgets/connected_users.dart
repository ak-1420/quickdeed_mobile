import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/users_model.dart';
import 'package:quickdeed/api/user_services.dart';

import '../Models/current_user.dart';

class ConnectedUsers extends StatefulWidget {
 const ConnectedUsers({Key? key}) : super(key: key);

  @override
  State<ConnectedUsers> createState() => _ConnectedUsersState();
}

class _ConnectedUsersState extends State<ConnectedUsers> {

  List<CurrentUser> usersData = [];

  void handleUsersList(List<CurrentUser> users , context){
      setState(() {
        usersData = users;
      });
  }

  @override
  void initState() {
    super.initState();
    User? u = FirebaseAuth.instance.currentUser;
    if(u != null){
       getUserConnections().then((val) => handleUsersList(val, context));
    }
    else{
      Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    if(usersData.isEmpty){
      return const Center(child: Text('No Connections!'),);
    }

    return ListView.builder(
        itemCount: usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 10.0,
            child: InkWell(
              onTap: () {
                // TODO: navigate user to chat screen
                // Navigator.pushNamed(context, '/chat');
              },
              child: Container(
                margin: const EdgeInsets.all(5.0),
                width: 340.w,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  color: Colors.white,
                ),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: Colors.grey[300],
                      // backgroundImage: const AssetImage('images/user.jpeg'),
                      backgroundImage: NetworkImage(usersData[index].profilePic),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          usersData[index].userName,
                          style: GoogleFonts.pacifico(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        //TODO show user distance or something
                        // Text(
                        //   users[index].location,
                        //   style: GoogleFonts.roboto(
                        //       fontSize: 12.sp,
                        //       fontWeight: FontWeight.w400,
                        //       color: Colors.black87),
                        // )
                      ],
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.w,
                          height: 50.h,
                          child: RatingBar.builder(
                            initialRating: double.parse(usersData[index].rating.toString()),
                            minRating: 1,
                            direction: Axis.horizontal,
                            ignoreGestures: true,
                            allowHalfRating: true,
                            itemCount: 5,
                            updateOnDrag: false,
                            tapOnlyMode: true,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Text(
                                "Chat",
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/chat');
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
