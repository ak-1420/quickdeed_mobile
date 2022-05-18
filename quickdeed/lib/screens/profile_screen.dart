import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/api/user_services.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({ Key? key }) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  late Future<CurrentUser> profileUser;

   String profilePicture = "https://picsum.photos/200";
   String coverPicture = "https://picsum.photos/200";
   String address = "";
   String userName = "Your Name";
   double rating = 0;
   List<String> skills = [];

  void setProfileUser(CurrentUser pUser , context){
   setState(() {
     profilePicture = (pUser.profilePic != "") ? pUser.profilePic : profilePicture;
     coverPicture = (pUser.profilePic != "") ? pUser.profilePic : profilePicture;
     rating = (pUser.rating != 0) ? double.parse(pUser.rating.toString()) : 0;
     skills = (pUser.skills.isNotEmpty) ? pUser.skills : [];
     userName = (pUser.userName != "") ? pUser.userName : userName;
     address = (pUser.location.address != "") ? pUser.location.address : address;

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


  showAddSkillsDialog(BuildContext context){
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: (){
        Navigator.of(context).pop();
      },
    );
    Widget okButton = TextButton(
      child: const Text("Ok"),
      onPressed: (){
        // hit update skills api
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Add / Update Skills"),
      // content: showSkillChips(),
      actions: [
        cancelButton,
        okButton
      ],
    );
  }

  // show logout alert dialog to the user
  showAlertDialog(BuildContext context){
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: (){
        Navigator.of(context).pop();
      },
    );

    Widget okButton =  TextButton(
      child: const Text("Ok"),
      onPressed: (){
        signOut();
        Navigator.of(context).pop();
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Warning"),
      content: const Text("Would you really like to logout?"),
      actions: [
        cancelButton,
        okButton
      ],
    );

    //show the dialog
    showDialog(context: context,
        builder: (BuildContext context){
          return alert;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 20.h,),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(coverPicture),
                    fit: BoxFit.cover
                  )
                ),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back ,
                              color: Colors.white,
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon:  const Icon(Icons.logout ,
                              color: Colors.white,
                            ),
                            onPressed: (){
                              showAlertDialog(context);
                            },
                          ),
                        ]
                    ),
                    Container(
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
                  ],
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
                ,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                  fontSize: 18.sp,
                  color:Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300,
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
                      child: Text("Skills",style: TextStyle(
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
                    children: renderSkills(skills)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


List<Widget> renderSkills(List<String> skills){

  List<Widget> ls = [];

  ls = skills.map((skill) => (
     Card(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),  
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(skill,
              style: GoogleFonts.roboto(),
          )
          ),
         )
      )
    ).cast<Widget>().toList();

  return ls;
}
