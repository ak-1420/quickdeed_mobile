import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WorkDetailsScreen extends StatefulWidget {
  WorkDetailsScreen({Key? key}) : super(key: key);

  @override
  _WorkDetailsScreen createState() => _WorkDetailsScreen();
}

class _WorkDetailsScreen extends State<WorkDetailsScreen> {
  Widget getCard(
      {required String title, required String value, required String imgPath}) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              backgroundImage: ExactAssetImage('images/user.jpeg', scale: 1.0),
              // backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
              radius: 20.r,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    title,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    value,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get the device height and width

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: Text(
                "Work Details",
                style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.w400,
                    fontSize: 30.sp,
                    color: const Color.fromRGBO(249, 250, 253, 1)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: Column(
                  children: [
                    getCard(
                        title: "Work Name :",
                        value: "Delivery",
                        imgPath: 'images/user.jpeg'),
                    Divider(
                      color: Colors.black,
                      indent: 75.0,
                      endIndent: 55.0,
                      thickness: 2.0,
                    ),
                    getCard(
                        title: "Posted By:",
                        value: "Arun Kumar",
                        imgPath: 'images/user.jpeg'),
                    Divider(
                      color: Colors.black,
                      indent: 75.0,
                      endIndent: 55.0,
                      thickness: 2.0,
                    ),
                    getCard(
                        title: "Estimated Time:",
                        value: "5h",
                        imgPath: 'images/user.jpeg'),
                    Divider(
                      color: Colors.black,
                      indent: 75.0,
                      endIndent: 55.0,
                      thickness: 2.0,
                    ),
                    getCard(
                        title: "Amount:",
                        value: "300.0",
                        imgPath: 'images/user.jpeg'),
                    Divider(
                      color: Colors.black,
                      indent: 75.0,
                      endIndent: 55.0,
                      thickness: 2.0,
                    ),
                    getCard(
                        title: "Description:",
                        value:
                            "Luggage Delivery from secunderabad to kukatpally",
                        imgPath: 'images/user.jpeg'),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: SizedBox(
                          width: 145.w,
                          height: 44.h,
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(19, 18, 18, 1)),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () {
                                //user details has to be added to Requests
                                Navigator.pushNamed(context, '/home');
                              },
                            
                              child: Text(
                                "Send Request",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.sp,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } // end of build method

}
