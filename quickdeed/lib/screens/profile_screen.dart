import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:quickdeed/config/Assets.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({ Key? key }) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  late Future<CurrentUser> profileUser;

   String profilePicture = "https://picsum.photos/200";
   String coverPicture = "https://picsum.photos/200";
   String address = "Hyderabad , India";
   String userName = "Your Name";
   double rating = 0;
   List<String> skills = [];



 void setProfileUser(CurrentUser pUser , context){
   setState(() {
     profilePicture = (pUser.profilePic != "") ? pUser.profilePic : profilePicture;
     coverPicture = (pUser.profilePic != "") ? pUser.profilePic : profilePicture;
     rating = (pUser.rating != "") ? double.parse(pUser.rating) : 0;
     skills = (pUser.skills.isNotEmpty) ? pUser.skills : [];
     userName = (pUser.userName != "") ? pUser.userName : userName;

   });
 }


  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      String? mobileNumber = user.phoneNumber;
      profileUser = getUserByMobile(mobileNumber);
      profileUser.then((dbUser) => setProfileUser(dbUser, context)
      ).catchError((e) => {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:  Text(e?.message['message'] ?? "Error")))
      });
    }
    else{
      Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(coverPicture),
                  fit: BoxFit.cover
                )
              ),
              child: Container(
                width: double.infinity,
                height: 200.h,
                child: Container(
                  alignment:const Alignment(0.0,2.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(profilePicture),
                    radius: 60.r,
                  ),
                ),
              ),
            ),
            SizedBox(height: 80.h,),
            Text(userName,
              style: GoogleFonts.roboto(
                fontSize: 25.sp,
                color: Colors.blueGrey,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w400
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              address
              ,style: GoogleFonts.roboto(
                fontSize: 18.sp,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 200.w,
              height: 30.h,
              child: RatingBar.builder(
                initialRating: rating, // add it dynamically
                ignoreGestures: true,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 2,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                elevation: 2.0,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                    child: Text("Skill Set",style: TextStyle(
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w300
                    ),))
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("flutter",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("react js",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Node js",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("MERN stack",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Problem Solving",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Quick Learning",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                      ],
                    )
                  ]
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}