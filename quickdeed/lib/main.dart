import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/screeens/send_otp_screen.dart';
import 'package:quickdeed/screeens/sign_up_screen_one.dart';
import 'package:quickdeed/screeens/splash_screen.dart';
import 'package:quickdeed/screeens/user_Details_screen.dart';
import 'package:quickdeed/screeens/verify_otp_screen.dart';
import 'package:quickdeed/screeens/post_Work.dart';
import 'package:quickdeed/screeens/home_screem.dart';
import 'package:quickdeed/screeens/user_Details_screen.dart';
import 'package:quickdeed/screeens/work_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // restrict device orientation to portrait only
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quick Deed',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.pacificoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/sendOtp': (context) => SendOtpScreen(),
          '/verifyOtp': (context) => VerifyOtpScreen(),
          '/signUpOne': (context) => SignUpScreenOne(),
          '/postWork': (context) => PostWorkScreen(),
          '/home': (context) => HomeScreen(),
          '/viewUser':(context) => User_Details_Screen(),
          '/viewWork':(context) => Work_Details_Screen(),
        },
      ),
    );
  } // end of build method

}
