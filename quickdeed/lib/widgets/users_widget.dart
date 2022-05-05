import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/Models/users_model.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickdeed/arguments/view_user_screen_arguments.dart';
import 'package:quickdeed/config/Assets.dart';

class UsersList extends StatefulWidget {

   const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  //TODO: fetch the users list here
  List<CurrentUser> usersData = [];
  CurrentUser cUser = CurrentUser(
      userId: '',
      userName: '',
      email: '',
      mobile: 0,
      skills: [],
      rating: 0,
      location: LocationDTO(address:"",lattitude: 0 , longitude: 0),
      requests: [],
      connections: [],
      invitations: [],
      createdAt: '',
      updatedAt: '',
      profilePic: ''
  );

  void handleUserList(List<CurrentUser> users , context , String uid){
    setState(() {
      usersData = users.where((user) => user.userId != uid).toList();
      cUser = users.where((user) => user.userId == uid).toList()[0];
    });
  }

  String getUserDistance(num sLat ,num sLng , num eLat , num eLng){
    double s_lat = double.parse(sLat.toString());
    double s_lng = double.parse(sLng.toString());
    double e_lat = double.parse(eLat.toString());
    double e_lng = double.parse(eLng.toString());
    double distanceInMeters = Geolocator.distanceBetween(s_lat , s_lng , e_lat, e_lng);
    double distanceInKms =  distanceInMeters / 1000;
    return distanceInKms.toString() + 'km away';
  }

  @override
  void initState()  {
    super.initState();
    User? u = FirebaseAuth.instance.currentUser;
    if(u != null){
      // get all the users from api
      String uid = u.uid;
      getAllUsers().then((val) => handleUserList(val , context , uid));
    }
    else{
      // user not logged in
      Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    if(usersData.isEmpty){
      return const Center(child: CircularProgressIndicator(),);
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount:usersData.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context , int index){
        return Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/viewUser',
                arguments: ViewUserArguments(
                    user: usersData[index]
                )
              );
            },
            horizontalTitleGap: 10.0,
            leading: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey[300],
              // backgroundImage: const ExactAssetImage('images/user.jpeg') ,
              backgroundImage: NetworkImage(usersData[index].profilePic) ,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Text(usersData[index].userName,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 16.sp
                    ),
                  ),
                  const Spacer(),
                  Text(getUserDistance(cUser.location.lattitude , cUser.location.longitude , usersData[index].location.lattitude , usersData[index].location.longitude),
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp
                    ),
                  )
                ],
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.w,
                  height: 30.h,
                  child: RatingBar.builder(
                    initialRating: double.parse(usersData[index].rating.toString()),
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
                SizedBox(height: 5.h,),
                Row(
                  children: showUserSkills(usersData[index].skills),
                ),
              ],
            ),
          ),
        );
      },
    );


  }
}

List<Widget> showUserSkills (List<String> skills){
   List<Widget> ls = [];
   ls = skills.map((skill) => {
     Card(
       child: Padding(
       padding: const EdgeInsets.all(10.0),
       child: Text("Skill 1",
                   style: GoogleFonts.roboto(
                   fontWeight: FontWeight.w500,
                   fontSize: 13.sp
                  ),
                 ),
               ),
              elevation: 5,
             color: Colors.brown[200],
           )
   }).cast<Widget>().toList();
   return ls;
}
