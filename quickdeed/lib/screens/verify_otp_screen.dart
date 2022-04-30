import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:quickdeed/arguments/verify_otp_screen_args.dart';


class VerifyOtpScreen extends StatefulWidget {

  VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {

  bool showLoading = false;
  final otpNumberController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<CurrentUser> futureUser;

  void handleCurrentUser(CurrentUser cUser , context){
    print('current user: $cUser');
    String path = (cUser.userId.isEmpty) ? "/signUpOne" : "/home";
    Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
  }

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try{
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if(authCredential.user != null){
        print('user logged in ${authCredential.user}');
        String? mobileNumber = authCredential.user?.phoneNumber;
        futureUser = getUserByMobile(mobileNumber);
        futureUser.then((u) => handleCurrentUser(u, context),onError: (e) => print('error: $e'));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      String errMsg = (e.message == null ? "error occured try again!" : e.message.toString());

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:  Text(errMsg)
          )
      );
    }
  }

  void handleVerifyOtp(String otp , String verificationId) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp
    );
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }



  @override
  Widget build(BuildContext context) {

   // get the verifcation id from args

    final args = ModalRoute.of(context)!.settings.arguments as VerifyOtpArguments;

    final  width = MediaQuery.of(context).size.width;
    final  height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
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

              Row(
                children:  [
                  SizedBox(width: 10.w,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              Text(  "OTP Verification" ,
                style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.w400,
                    fontSize: 30.sp,
                    color: const Color.fromRGBO(249, 250, 253, 1)
                ),
              ),
              SizedBox(height:30.h),
              Wrap(

                  children:[
                    Text(  " Enter " ,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w300,
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(249, 250, 253, 1)
                      ),
                    ),
                    Text(  " One Time Password " ,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(249, 250, 253, 1)
                      ),
                    ),
                    Text(  " sent to " ,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w300,
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(249, 250, 253, 1)
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Text( args.phoneNumber ,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(249, 250, 253, 1)
                      ),
                    ),
                  ]
              ),


              SizedBox(height: 27.h,),

              SizedBox(
                width: 320.w,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: otpNumberController,
                  onChanged: (otp) {
                    print(otp);
                  },
                  style:TextStyle(
                    fontSize: 24.sp,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Colors.black87,
                            width: 2.0,
                            style: BorderStyle.solid
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Colors.black87,
                            width: 2.0,
                            style: BorderStyle.solid
                        )
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter OTP ",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                    hintStyle: GoogleFonts.rubik(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color:const Color.fromRGBO(0, 0, 0, 1)
                    ),
                  ),
                ),
              ),

              SizedBox(height: 50.h,),

              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: SizedBox(
                  width: 145.w,
                  height: 44.h,
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(19, 18, 18, 1)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),

                      ),
                      onPressed: () {
                        // TODO: Verify Otp entered by the user
                        handleVerifyOtp(otpNumberController.text, args.verificationId);
                      },
                      child: Text("Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20.sp,
                        ),)
                  ),
                ),
              ),
              SizedBox(height:27.h),

              Wrap(
                  children: [
                    Text(" Don’t receive the OTP ? " ,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: const Color.fromRGBO(255, 255, 255, 1)
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        print('user pressed on resend otp!!');
                      },
                      child: Text(" RESEND OTP " ,
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: Colors.orange
                        ),
                      ),
                    ),

                  ]
              ),

              SizedBox(height : 50.h),

              Center(
                child: showLoading ? CircularProgressIndicator(
                  backgroundColor:  Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                  strokeWidth: 5,
                ) : null ,
              ),

              const Spacer(),

            ],

          ),

        ),
      ),
    );
  }
}