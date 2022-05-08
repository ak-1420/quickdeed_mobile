import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/notificationServices/local_notification_service.dart';
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

// Receive message when app is in background
// solution for on Message
Future<void> backgroundHandler(RemoteMessage message) async {
  print('back msg: ${message.data.toString()}');
  print('back notif: ${message.notification?.title}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(navigatorKey);
    // gives you the message on which user taps
    // and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((msg){
       if(msg != null){
        final r = msg.data['routePage'];
        navigatorKey.currentState?.pushNamed(r);
        }
    });

    // to handle foreground notification
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null) {
        print('foreground notification: ${message.notification?.body}');
        print('foreground title ${message.notification?.title}');
        LocalNotificationService.display(message);
      }
    });

    // when the app is in background
    // and user taps on notification
    // to take user to particular route
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['routePage'];
      print('notification  route $routeFromMessage');
      navigatorKey.currentState?.pushNamed(routeFromMessage);
    });
  }

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
          navigatorKey: navigatorKey,
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


  } }
