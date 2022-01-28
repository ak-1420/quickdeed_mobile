import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/screeens/connect.dart';
import 'package:quickdeed/screeens/profile_screen.dart';
import 'package:quickdeed/screeens/rate_worker.dart';
import 'package:quickdeed/screeens/send_otp_screen.dart';
import 'package:quickdeed/screeens/sign_up_screen_one.dart';
import 'package:quickdeed/screeens/splash_screen.dart';
import 'package:quickdeed/screeens/track_screen.dart';
import 'package:quickdeed/screeens/user_Details_screen.dart';
import 'package:quickdeed/screeens/user_works.dart';
import 'package:quickdeed/screeens/verify_otp_screen.dart';
import 'package:quickdeed/screeens/post_Work.dart';
import 'package:quickdeed/screeens/home_screem.dart';
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
        splitScreenMode: true,
        minTextAdapt: true,
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
          builder: (context , widget){
            ScreenUtil.setContext(context);
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
            );
          },
          routes: {
            '/': (context) => SplashScreen(),
            '/sendOtp': (context) => SendOtpScreen(),
            '/verifyOtp': (context) => VerifyOtpScreen(),
            '/signUpOne': (context) => SignUpScreenOne(),
            '/postWork': (context) => PostWorkScreen(),
            '/home': (context) => HomeScreen(),
            '/viewUser':(context) => UserDetailsScreen(),
            '/viewWork':(context) => WorkDetailsScreen(),
            '/myProfile': (context)=> const MyProfileScreen(),
            '/connect': (context) => const Connect(),
            '/userWorks' : (context) => const UserWorks(),
            '/rateWorker' : (context) => const RateWorker(),
            '/track': (context) => const TrackScreen(),
          },
        )
    );


  } // end of build method

}
