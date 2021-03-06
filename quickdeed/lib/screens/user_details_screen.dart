import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:quickdeed/arguments/view_user_screen_arguments.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({Key? key}) : super(key: key);

  @override
  _UserDetailsScreen createState() => _UserDetailsScreen();
}

class _UserDetailsScreen extends State<UserDetailsScreen> {

  bool isInvited = false;

  void sendInvitation(String userId , String workId , context){
    if(isInvited == true){
      return;
    }
    inviteUser(userId, workId).then((val) => {

      if(val['status'] == true){
        // show snackbar like invited successfully
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('invitation sent'))
        ),
        setState(() {
          isInvited = true;
        }),
      }
    }).catchError((err)=>{
             print('error while sending user invitations $err')
          });
  }

  List<Widget> renderSkills(List<String> skills){
    List<Widget> ls = [];
    ls = skills.map((skill) =>(
        getCard(
            title: "Skill",
            value: skill,
            imgPath: 'images/skill.jpg')
    )).cast<Widget>().toList();

    return ls;
  }

  Widget getUserCard(
      {required String title, required String value, required String imgPath}) {
    return Container(
      child: Row(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(imgPath, scale: 1.0),
                // backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
                radius: 60.r,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(title,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  Widget getCard(
      {required String title, required String value, required String imgPath}) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              backgroundImage: ExactAssetImage(imgPath, scale: 1.0),
              // backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
              radius: 20.r,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(title,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get the device height and width

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    //get the user arg

    final args = ModalRoute.of(context)!.settings.arguments as ViewUserArguments;

    return Scaffold(
        body:Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 100, 10, 10),
                    child: Text(
                      "User Details",
                      style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.sp,
                          color: const Color.fromRGBO(249, 250, 253, 1)),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        (args.user.profilePic == "") ? getCard( title: "User Name", value: args.user.userName, imgPath: 'images/user.jpeg') :
                        getUserCard( title: "User Name", value: args.user.userName, imgPath: args.user.profilePic),
                        Container(
                          child: Text(
                            "Rated",
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          width: 200.w,
                          height: 50.h,
                          child: RatingBar.builder(
                            initialRating: double.parse(args.user.rating.toString()),
                            minRating: 1,
                            ignoreGestures: true,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 2,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: ClipRRect(
                            
                            borderRadius: BorderRadius.circular(20.r),
                            child: SizedBox(
                              width: 145.w,
                              height: 44.h,
                              child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromRGBO(19, 18, 18, 1)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {
                                    //user details has to be added to conenctions
                                    sendInvitation(args.user.userId, "NA", context);
                                    //Navigator.pushNamed(context, '/home');
                                  },
                                  child: Text(
                                    (!isInvited) ? 'Invite User' : 'Invited',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20.sp,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Column(
                          children: renderSkills(args.user.skills),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      );
  } // end of build method

}






