import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class SignUpScreenOne extends StatefulWidget {

  SignUpScreenOne({Key? key}) : super(key: key);

  @override
  State<SignUpScreenOne> createState() => _SignUpScreenOneState();
}

class _SignUpScreenOneState extends State<SignUpScreenOne> {

  final nameController = TextEditingController();

  final emailController = TextEditingController();


  XFile? _profilePic;

  set _imageFile(XFile? value) {
    _profilePic = (value == null) ? null : value;
  }

  final ImagePicker _picker = ImagePicker();

  // method to select an image from gallery

  _imgFromGallery() async {

    XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front
    );

    setState(() {
      _imageFile = image;
    });

  }

  // method to select an image by capturing image from camera

  _imgFromCamera() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50
    );

    setState(() {
      _imageFile = image;
    });

  }


  // method to display a bottom sheet for the user for choosing
  // the option of camera or gallery

  void _showPicker(context)
  {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: (){
                      _imgFromGallery();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: (){
                      _imgFromCamera();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

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
              SizedBox(height:30.h),
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

              SizedBox(height: 10.h,),

              Text(  " Create Profile " ,
                style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.w400,
                    fontSize: 30.sp,
                    color: const Color.fromRGBO(249, 250, 253, 1)
                ),
              ),
              SizedBox(height:10.h),

              //  add profile circle
              InkWell(
                onTap: (){
                  // show image picker
                  _showPicker(context);
                },
                child: CircleAvatar(
                    backgroundImage: (_profilePic != null) ? Image.file(File(_profilePic!.path)).image : null,
                    backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
                    radius: 100.r,
                    child: (_profilePic != null) ? null : const Icon(Icons.camera_alt , size: 40,color: Colors.black87,)
                ),
              ),


              SizedBox(height: 30.h,),

              // name textbox
              SizedBox(
                width: 320.w,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: nameController,
                  onChanged: (name) {
                    print(name);
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
                    hintText: "Your name",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                    hintStyle: GoogleFonts.rubik(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color:const Color.fromRGBO(0, 0, 0, 1)
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h,),

              // username textbox
              SizedBox(
                width: 320.w,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: emailController,
                  onChanged: (email) {
                    print(email);
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
                    hintText: "your email",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                    hintStyle: GoogleFonts.rubik(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color:const Color.fromRGBO(0, 0, 0, 1)
                    ),
                  ),
                ),
              ),


              SizedBox(height: 30.h,),

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

                        Navigator.pushNamed(context , '/postWork');
                      },
                      child: Text("Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 20.sp,
                        ),)
                  ),
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