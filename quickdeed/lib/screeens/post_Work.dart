import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostWorkScreen extends StatefulWidget {
  PostWorkScreen({Key? key}) : super(key: key);

  @override
  State<PostWorkScreen> createState() => _PostWorkScreenState();
}

class _PostWorkScreenState extends State<PostWorkScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget getTextFeild({required String hint, required int height_sp}) {
      return // name textbox
          SizedBox(
        width: 320.w,
        // height: height_sp.h,
        child: Container(
          // width: 320.w,
          // height: height.h,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            onChanged: (name) {
              print(name);
            },
            style: TextStyle(
              fontSize: 24.sp,
              // height: height_sp.h,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(
                      color: Colors.black87,
                      width: 2.0,
                      style: BorderStyle.solid)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(
                      color: Colors.black87,
                      width: 2.0,
                      style: BorderStyle.solid)),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              hintStyle: GoogleFonts.rubik(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
        ),
      );
    }

    Widget getButton({required String buttonText}) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: SizedBox(
          width: 145.w,
          height: 44.h,
          child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(19, 18, 18, 1)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                 Navigator.pushNamed(context , '/home');
              },
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20.sp,
                ),
              )),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 30.h),
              Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10.h,
              ),

              Text(
                " Post the work ",
                style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.w400,
                    fontSize: 40.sp,
                    color: const Color.fromRGBO(249, 250, 253, 1)),
              ),

              SizedBox(
                height: 40.h,
              ),
              getTextFeild(hint: "Enter Your Name", height_sp: 45),
              SizedBox(
                height: 20.h,
              ),

              //add select for work type
              getTextFeild(hint: "Estimated Time ", height_sp: 45),
              SizedBox(
                height: 20.h,
              ),
              getTextFeild(hint: "Amount you want to pay", height_sp: 45),
              SizedBox(
                height: 20.h,
              ),
              getTextFeild(hint: "Description", height_sp: 200),
              const Spacer(),

              //submit button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                      child: getButton(buttonText: "Cancel"),
                    ),
                    getButton(buttonText: "Post"),
                    
                  ],
                ),
              ),

              
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
