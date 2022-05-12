import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/LocationService/location_handler.dart';
import 'package:quickdeed/Models/work.dart';
import 'package:quickdeed/Models/works_model.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:quickdeed/api/works_services.dart';
import 'package:quickdeed/arguments/view_work_screen_arguments.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../Models/current_user.dart';


class WorksList extends StatefulWidget {
  WorksList({Key? key}) : super(key: key);

  @override
  State<WorksList> createState() => _WorksListState();
}

class _WorksListState extends State<WorksList> {
  List<Work> worksData  = [];
  LocationHandler locationHandler = LocationHandler();
  late Future<CurrentUser> futureUser;
  CurrentUser? cUser;

  void handleWorksList(List<Work> works , context , String uid) {
    setState((){
      worksData = works.where((work) => work.userId != uid).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    User? u = FirebaseAuth.instance.currentUser;
    if(u != null){
      String? mobileNumber = u.phoneNumber;
      futureUser = getUserByMobile(mobileNumber);
      futureUser.then((dbUser) => setState((){
        cUser = dbUser;
      })
      );
      String uid = u.uid;
      getAllWorks().then((val) => handleWorksList(val, context, uid));
    }
    else{
      Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    if(worksData.isEmpty || cUser == null){
      return const Center(child: CircularProgressIndicator(),);
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: worksData.length,
      itemBuilder: (BuildContext context , int index){
        return Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/viewWork' ,
                arguments: ViewWorkArguments(
                  work: worksData[index],
                  user: cUser
                )
              );
            },
            horizontalTitleGap: 10.0,
            leading: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey[300],
              backgroundImage: const ExactAssetImage('images/work.jpeg'),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Text(worksData[index].name,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 16.sp
                    ),
                  ),
                  const Spacer(),
                  Text(timeago.format(DateTime.parse(worksData[index].createdAt)),
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp
                    ),
                  )
                ],
              ),
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text("posted by ",
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp
                      ),
                    ),
                    SizedBox(width:10.w,),
                    Text(worksData[index].userName ,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black87
                      ),
                    ),
                    const Spacer(),
                    Text(locationHandler.getUserDistance(cUser?.location.lattitude ?? 0, cUser?.location.longitude ?? 0 , worksData[index].location.lattitude , worksData[index].location.longitude),
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5.h,),
                Row(
                    children:[
                      Row(
                        children: [
                          Text("amount : ",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp
                            ),
                          ),
                          Text(worksData[index].amount.toString() ,
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.black87
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text("type: ",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp
                            ),
                          ),
                          Text(worksData[index].type ,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black87
                            ),
                          )
                        ],
                      ),
                    ]
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
