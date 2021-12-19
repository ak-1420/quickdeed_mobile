import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class SendOtpScreen extends StatefulWidget {

  SendOtpScreen({Key? key}) : super(key: key);

  @override
  _SendOtpScreenState createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {


  final mobileNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {

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
              Text(  "OTP Verification" ,
                style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.w400,
                    fontSize: 30.sp,
                    color: const Color.fromRGBO(249, 250, 253, 1)
                ),
              ),
              SizedBox(height:63.h),
              Wrap(

                  children:[
                    Text(  "We will send you an " ,
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
                    Text(  " on this mobile number " ,
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w300,
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
                  controller: mobileNumberController,
                  onChanged: (mobile) {
                    print(mobile);
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
                    hintText: "Enter mobile number",
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
                        // TODO: handle send otp to mobile  functionality

                        Navigator.pushNamed(context , '/verifyOtp');
                      },
                      child: Text("Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20.sp,
                        ),)
                  ),
                ),
              ),

              SizedBox(height : 50.h),

              const Center(
                child: CircularProgressIndicator(
                  backgroundColor:  Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.black87),
                  strokeWidth: 5,
                ) ,

              ),

              const Spacer(),
            ],

          ),
        ),
      ),
    );


  }



}
