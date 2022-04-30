// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/users_model.dart';

class InvitedUsers extends StatelessWidget {
  InvitedUsers({Key? key}) : super(key: key);

  final List<Users> users = [
    Users(userId: "1", userName: "Hema", rating: 4, location: "4.4km away"),
    Users(userId: "1", userName: "Arun", rating: 3, location: "7km away"),
    Users(userId: "1", userName: "Rose", rating: 5, location: "9.4km away"),
    Users(userId: "1", userName: "Gayatri", rating: 4, location: "4.4km away"),
    Users(userId: "1", userName: "Hema", rating: 4, location: "4.4km away"),
    Users(userId: "1", userName: "Arun", rating: 3, location: "7km away"),
    Users(userId: "1", userName: "Rose", rating: 5, location: "9.4km away"),
    Users(userId: "1", userName: "Gayatri", rating: 4, location: "4.4km away"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 10.0,
            child: InkWell(
              onTap: () {
                //TODO: figure out what to do when user clicks on a user on invited users tab
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
                      backgroundImage: const AssetImage('images/user.jpeg'),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          users[index].userName,
                          style: GoogleFonts.pacifico(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        ),
                        Text(
                          users[index].location,
                          style: GoogleFonts.roboto(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87),
                        )
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
                            initialRating: users[index].rating,
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
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red[400]),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              onPressed: () {},
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
