import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quickdeed/arguments/view_user_screen_arguments.dart';

import '../screens/home_screen.dart';

class UserDistance {
  final String userId;
  final int distance;
  UserDistance({required this.userId , required this.distance});
}

class UsersList extends StatefulWidget {
   final String searchWord;
   final UserFilter? sortBy;
   const UsersList({Key? key , required this.searchWord , required this.sortBy}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  //TODO: fetch the users list here
  List<CurrentUser> usersData = [];
  List<CurrentUser> userUIList = [];

  // sorted users by distance
  List<CurrentUser> sortedUsersByDistance = [];
  // sorted users by rating
  List<CurrentUser> sortedUsersByRating = [];

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

  void handleUserList(List<CurrentUser> users , context , String uid , bool isInitState , bool isSort){
    setState(() {
      if(isInitState == true) {
        cUser = users.where((user) => user.userId == uid).toList()[0];
        usersData = users.where((user) => user.userId != uid).toList();

        List<UserDistance> userDistMap = users.map((u) => UserDistance(
            userId: u.userId,
            distance: getUserDistance(cUser.location.lattitude, cUser.location.longitude, u.location.lattitude, u.location.longitude)
        )
        ).toList();

        userDistMap.sort((a, b){
          int d1 = a.distance;
          int d2 = b.distance;
          if(d1 > d2) {
            return 1;
          } else if(d1 < d2) {
            return -1;
          }
          return 0;
        });

        for(int i = 0 ; i < userDistMap.length ; i++){
          CurrentUser? user = getSortedUser(users , userDistMap[i].userId);
          if(user != null && user.userId != uid){
            sortedUsersByDistance.add(user);
          }
        }


        sortedUsersByRating = users.where((user) => user.userId != uid).toList();
        sortedUsersByRating.sort((a , b) {
          num r1 = a.rating;
          num r2 = b.rating;
          if(r1 > r2){
            return -1;
          }
          else if(r1 < r2){
            return 1;
          }
          return 0;
        });


      }
      else{
      if(widget.sortBy?.name == UserFilter.distance.name && isSort == true){
      // filter by distance in ascending order
         userUIList = sortedUsersByDistance;
      }
      else if(widget.sortBy?.name == UserFilter.rating.name && isSort == true) {
      // filter by high rating
        userUIList = sortedUsersByRating;
      }
      else if(isSort == false){
      //local search functionality
        userUIList = users.where((user) => user.userId != uid && user.userName.contains(widget.searchWord)).toList();
      }
      }
    });
  }

  CurrentUser? getSortedUser(List<CurrentUser> users, String userId) {
    CurrentUser? user;
    for(int i = 0 ; i < users.length ; i++){
      if(users[i].userId == userId)
      {
        user = users[i];
      }
    }
    return user;
  }

  int getUserDistance(num sLat ,num sLng , num eLat , num eLng){
    double s_lat = double.parse(sLat.toString());
    double s_lng = double.parse(sLng.toString());
    double e_lat = double.parse(eLat.toString());
    double e_lng = double.parse(eLng.toString());
    double distanceInMeters = Geolocator.distanceBetween(s_lat , s_lng , e_lat, e_lng);
    double distanceInKms =  distanceInMeters / 1000;
    return distanceInKms.ceil();
  }

  @override
  void didUpdateWidget(UsersList oldUsersList) {
    super.didUpdateWidget(oldUsersList);
    if (widget.searchWord != oldUsersList.searchWord) {
      // TODO: whenever search word changes filter the worksData
      if(cUser.userId != "") {
        handleUserList(usersData, context, cUser.userId , false , false);
       }
    }
    else{
        if(cUser.userId != ""){
          handleUserList(usersData, context, cUser.userId , false , true);
        }
    }
  }

  @override
  void initState()  {
    super.initState();
    User? u = FirebaseAuth.instance.currentUser;
    if(u != null){
      // get all the users from api
      String uid = u.uid;
      getAllUsers().then((val) => handleUserList(val , context , uid, true , false));
    }
    else{
      // user not logged in
      Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    List<CurrentUser> Data = (userUIList.isEmpty) ? usersData : userUIList;

    if(usersData.isEmpty){
      return const Center(child: CircularProgressIndicator(),);
    }

    else if(userUIList.isEmpty && usersData.isNotEmpty && widget.searchWord != ""){
      return const Center(child:  Text('No Matches!'),);
    }


    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: Data.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context , int index){
        return Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/viewUser',
                arguments: ViewUserArguments(
                    user: Data[index]
                )
              );
            },
            horizontalTitleGap: 10.0,
            leading: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey[300],
              // backgroundImage: const ExactAssetImage('images/user.jpeg') ,
              backgroundImage: NetworkImage(Data[index].profilePic) ,
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Text(Data[index].userName,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 16.sp
                    ),
                  ),
                  const Spacer(),
                  Text(getUserDistance(cUser.location.lattitude , cUser.location.longitude , Data[index].location.lattitude , Data[index].location.longitude).toString() +
                    ' km away',
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
                    initialRating: double.parse(Data[index].rating.toString()),
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
   ls = skills.map((skill) => (
     Card(
       child: Padding(
       padding: const EdgeInsets.all(10.0),
       child: Text(skill ,
                   style: GoogleFonts.roboto(
                   fontWeight: FontWeight.w500,
                   fontSize: 13.sp
                  ),
                 ),
               ),
              elevation: 5,
             color: Colors.brown[200],
           )
   )
   ).cast<Widget>().toList();
   return ls;
}
