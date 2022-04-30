import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/api/user_services.dart';


class SplashScreen extends StatefulWidget {

   SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Future<CurrentUser> futureUser;

  // method to navigate user to sign up screen if the user
  // does not have an account in the database
  // else navigates the user to home page
  void handleCurrentUser(CurrentUser cUser , context){
    print('current user: $cUser');
    String path = (cUser.userId.isEmpty) ? "/signUpOne" : "/home";
    Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
  }

  @override
  void initState() {
    super.initState();

    // check if the user is already logged in or not
    Timer(const Duration(seconds: 5),(){
      User? user = FirebaseAuth.instance.currentUser;

      if(user != null){
        // user already logged in
        //TODO: check if the user has an account in database
        // TODO: if user has an account , navigate user to home screen
        // TODO: if account is not there , then navigate user to signup screen

        print('user already logged in $user');
        String? mobileNumber = user.phoneNumber;
        futureUser = getUserByMobile(mobileNumber);
        futureUser.then((dbUser) => handleCurrentUser(dbUser, context),
          onError: (e) => print('error while fetching user by mobile: $e')
        );

      }
      else{
        // user not logged in
        // navigate user to send otp screen
        print('user not logged in');
        Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
      }

    });
  }


  @override
  Widget build(BuildContext context) {

    // get the device height and width
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width : width,
        decoration: const BoxDecoration(
          image:  DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

            const Spacer(),

            InkWell(
              onDoubleTap: () {
                Navigator.pushNamed(context, '/sendOtp');
              },
              child: Text(  "Quick Deed" ,
                style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.w400,
                    fontSize: 50.sp,
                    color: const Color.fromRGBO(249, 250, 253, 1)
                ),
              ),
            ),

            Text(  "version 1.0" ,
              style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: const Color.fromRGBO(249, 250, 253, 1)
              ),
            ),

            SizedBox(height: 40.h,),

            const Center(
              child:  CircularProgressIndicator(
                backgroundColor:  Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                strokeWidth: 5,
              ),
            ),

            const Spacer(),
          ],

        ),
      ),


    );

  } // end of build method



}
