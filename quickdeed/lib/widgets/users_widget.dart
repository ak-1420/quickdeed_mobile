import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/current_user.dart';
import 'package:quickdeed/Models/users_model.dart';
import 'package:quickdeed/api/user_services.dart';

class UsersList extends StatefulWidget {

   const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {

  final List<Users> users = [
    Users(userId: "1", userName: "Hema", rating: 4, location: "4.4km away"),
    Users(userId: "2", userName: "Arun", rating: 5, location: "4.4km away"),
    Users(userId: "3", userName: "Rose", rating: 3, location: "4.4km away"),
    Users(userId: "4", userName: "Gayatri", rating: 2, location: "4.4km away"),
  ];

  //TODO: fetch the users list here
  List<CurrentUser> usersData = [];

  @override
  void initState() async {
    super.initState();
    User? u = FirebaseAuth.instance.currentUser;
    if(u != null){
      // get all the users from api
      usersData = await getAllUsers();
    }
    else{
      // user not logged in
      Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (BuildContext context , int index){
        return Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/viewUser');
            },
            horizontalTitleGap: 10.0,
            leading: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey[300],
              backgroundImage: const ExactAssetImage('images/user.jpeg'),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Text(users[index].userName,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 16.sp
                    ),
                  ),
                  const Spacer(),
                  Text(users[index].location,
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
                initialRating: users[index].rating,
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
                 children: [
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
                   ),
                   Card(

                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text("Skill 2",
                         style: GoogleFonts.roboto(
                             fontWeight: FontWeight.w500,
                             fontSize: 13.sp
                         ),
                       ),
                     ),
                     elevation: 5,
                     color: Colors.green[200],
                   ),
                   Card(

                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text("Skill 3",
                         style: GoogleFonts.roboto(
                             fontWeight: FontWeight.w500,
                             fontSize: 13.sp
                         ),
                       ),
                     ),
                     elevation: 5,
                     color: Colors.red[200],
                   ),
                 ],
               ),
              ],
            ),
          ),
        );
      },
    );
  }
}
