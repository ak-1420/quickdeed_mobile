import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class SplashScreen extends StatefulWidget {

   SplashScreen({Key? key}) : super(key: key);



  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

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

            Text(  "Quick Deed" ,
              style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.w400,
                  fontSize: 50.sp,
                  color: const Color.fromRGBO(249, 250, 253, 1)
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
