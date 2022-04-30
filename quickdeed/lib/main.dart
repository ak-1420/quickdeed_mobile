import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/screens/connect.dart';
import 'package:quickdeed/screens/profile_screen.dart';
import 'package:quickdeed/screens/rate_worker.dart';
import 'package:quickdeed/screens/send_otp_screen.dart';
import 'package:quickdeed/screens/sign_up_screen_one.dart';
import 'package:quickdeed/screens/splash_screen.dart';
import 'package:quickdeed/screens/track_screen.dart';
import 'package:quickdeed/screens/user_details_screen.dart';
import 'package:quickdeed/screens/user_works.dart';
import 'package:quickdeed/screens/verify_otp_screen.dart';
import 'package:quickdeed/screens/post_work.dart';
import 'package:quickdeed/screens/home_screen.dart';
import 'package:quickdeed/screens/work_details_screen.dart';
import 'package:quickdeed/screens/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
            '/chat':(context) => const ChatPage(),
          },
        )
    );


  } // end of build method

}
