import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SignUpScreenOne extends StatefulWidget {

  SignUpScreenOne({Key? key}) : super(key: key);

  @override
  State<SignUpScreenOne> createState() => _SignUpScreenOneState();
}

class _SignUpScreenOneState extends State<SignUpScreenOne> {

  bool showLoading = false;

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  // to get the user location
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromLatLng(Position pos) async {
    List<Placemark> placemark = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    Placemark place = placemark[0];
    return '${place.street}, ${place.subLocality},${place.locality},${place.postalCode}';
  }

  Future<LocationDTO> getUserLocation() async {

    Position pos = await _determinePosition();
    String addr = await getAddressFromLatLng(pos);
    return
      LocationDTO(address: addr ,
        lattitude: pos.latitude,
        longitude: pos.longitude
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<CurrentUser> futureUser;

  String profilePic = "";

  XFile? _profilePic;

  void navigateUser(CurrentUser user , context){
    String path = (user.userId.isEmpty) ? "/sendOtp" : "/home";
    Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
  }

  Future<String> uploadFile(String uid , File? photo) async {
    if(photo == null) return "";
    const fileName = 'profile';
    final destination = '$uid/$fileName';
    try{
      final ref = storage.ref(destination);
      await ref.putFile(photo);
     return await ref.getDownloadURL();
    }
    catch(e){
      print('error uploading file');
    }
    return "";
  }


  void handleUserSignUp(context) async {
    setState((){
      showLoading = true;
    });


    // TODO: 1 upload _profilePic to firebase storage
    // TODO: 2 get the url of the image

    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      String? mbl = user.phoneNumber?.substring(3);
      String userId = user.uid;
      //TODO : get user location and add it below ot the LocationDTO object
      LocationDTO loc = await getUserLocation();
      List<RequestDTO> reqs = [];
      List<String> skills = [];
      List<ConnectionDTO> cons = [];
      List<InvitationDTO> invs = [];
      String email = emailController.text;
      String uname = nameController.text;
      num rating = 0;
      int mobile = int.parse(mbl ?? "0");
      String? imageUrl = "";
      File? file =  File(_profilePic!.path);
      if(_profilePic != null){
        imageUrl = await uploadFile(userId , file);
      }
      CurrentUser usr = CurrentUser(
          userId: userId,
          userName: uname,
          email: email,
          mobile: mobile,
          skills: skills,
          rating: rating,
          location: loc,
          requests: reqs,
          connections: cons,
          invitations: invs,
          createdAt: '',
          updatedAt: '',
          profilePic: imageUrl
      );

      futureUser = registerUser(usr);

      futureUser.then((dbUser) => navigateUser(dbUser , context)
      ).catchError((e) => {
      setState(() {
      showLoading = false;
      }),
       if(e.runtimeType == Exception || e.runtimeType == String){
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())
           )
          )
         }
       else if(e.runtimeType != TypeError)
         {
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(e?.message['message'] ?? "Error")
               )
           )
         }
      });
    }


  }

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
                  keyboardType: TextInputType.name,
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

              // email textbox
              SizedBox(
                width: 320.w,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
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
                        handleUserSignUp(context);
                        //Navigator.pushNamed(context , '/postWork');
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

              Center(
                child: showLoading ? const CircularProgressIndicator(
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