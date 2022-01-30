import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class VerifyOtpScreen extends StatefulWidget {

  VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {


  final otpNumberController = TextEditingController();




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
                    Text( "+91 - 7660941707",
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

                        Navigator.pushNamed(context , '/signUpOne');
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

             const Center(
                child: CircularProgressIndicator(
                  backgroundColor:  Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
                  strokeWidth: 5,
                )
              ),

              const Spacer(),

            ],

          ),

        ),
      ),
    );
  }
}