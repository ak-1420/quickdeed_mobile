import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/LocationService/location_handler.dart';
import 'package:quickdeed/Models/work.dart';
import 'package:quickdeed/api/user_services.dart';
import 'package:quickdeed/api/works_services.dart';
import 'package:quickdeed/arguments/view_work_screen_arguments.dart';
import 'package:quickdeed/screens/home_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../Models/current_user.dart';

class WorkDistance{
  final String workId;
  final int distance;
  WorkDistance({required this.workId , required this.distance});
}


class WorksList extends StatefulWidget {
  final String searchWord;
  final WorkFilter? sortBy;
  const WorksList({Key? key ,required this.searchWord , required this.sortBy}) : super(key: key);

  @override
  State<WorksList> createState() => _WorksListState();
}

class _WorksListState extends State<WorksList> {

  List<Work> worksData  = [];
  List<Work> workUIData = [];

  // sorted works by distance
  List<Work> sortedWorksByDistance = [];
  // sorted works by amount
  List<Work> sortedWorksByAmount = [];

  LocationHandler locationHandler = LocationHandler();
  late Future<CurrentUser> futureUser;
  CurrentUser? cUser;

  Work? getSortedWork(List<Work> works, String workId) {
    Work? work;
    for(int i = 0 ; i < works.length ; i++){
      if(works[i].workId == workId)
      {
        work = works[i];
      }
    }
    return work;
  }


  void handleWorksList(List<Work> works , context , String uid , bool isInitState , bool isSort) {

    if(uid == "") return;

    setState((){
      if(isInitState == true){
        worksData = works.where((work) => work.userId != uid).toList();

        // sort works by user distance
        List<WorkDistance> userDistMap = worksData.map((w) => WorkDistance(
                workId: w.workId,
                distance: getUserDistance(cUser?.location.lattitude ?? 0, cUser?.location.longitude ?? 0, w.location.lattitude, w.location.longitude)
            )
        ).toList();

        userDistMap.sort((a , b){
          int d1 = a.distance;
          int d2 = b.distance;
          if(d1 > d2) {
            return 1;
          }
          else if(d1 < d2){
            return -1;
          }
          return 0;
        });

        for(int i = 0 ; i < userDistMap.length ; i++){
          Work? work = getSortedWork(worksData, userDistMap[i].workId);
          if(work != null && work.userId != uid){
            sortedWorksByDistance.add(work);
          }
        }

        // sort works by amount
        sortedWorksByAmount = works.where((work) => work.userId != uid).toList();
        sortedWorksByAmount.sort((a , b){
          double a1 = a.amount;
          double a2 = b.amount;

          if(a1 > a2){
            return -1;
          }else if(a1 < a2){
            return 1;
          }
          return 0;
        });

      }
      else{

        if(widget.sortBy?.name == WorkFilter.distance.name && isSort == true){
          // filter by distance in ascending order
          workUIData = sortedWorksByDistance;
        }
        else if(widget.sortBy?.name == WorkFilter.amount.name && isSort == true){
          workUIData = sortedWorksByAmount;
        }
        else if(isSort == false){
          workUIData = works.where((work) => work.userId != uid && work.name.contains(widget.searchWord)).toList();
        }
      }
    });
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
  void didUpdateWidget(WorksList oldWorksList) {
    super.didUpdateWidget(oldWorksList);
    if (widget.searchWord != oldWorksList.searchWord) {
      // TODO: whenever search word changes filter the worksData
      if(cUser?.userId != null){
        handleWorksList(worksData, context, cUser?.userId ??  "" , false , false);
      }
    }
    else
      {
        if(cUser?.userId != null){
          handleWorksList(worksData , context , cUser?.userId ?? "", false , true);
        }
      }
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
      getAllWorks().then((val) => handleWorksList(val, context, uid , true , false));
    }
    else{
      Navigator.pushNamedAndRemoveUntil(context, '/sendOtp', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Work> Data = (workUIData.isEmpty) ? worksData : workUIData;

    if(worksData.isEmpty || cUser == null){
      return const Center(child: CircularProgressIndicator(),);
    }

    else if(workUIData.isEmpty && worksData.isNotEmpty && widget.searchWord != ""){
      return const Center(child: Text('No Matches!'),);
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Data.length,
      itemBuilder: (BuildContext context , int index){
        return Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/viewWork' ,
                arguments: ViewWorkArguments(
                  work: Data[index],
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
                  Flexible(
                    child: Text(Data[index].name,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          fontSize: 16.sp
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(timeago.format(DateTime.parse(Data[index].createdAt)),
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
                    Text(Data[index].userName ,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black87
                      ),
                    ),
                    const Spacer(),
                    Text(locationHandler.getUserDistance(cUser?.location.lattitude ?? 0, cUser?.location.longitude ?? 0 , Data[index].location.lattitude , Data[index].location.longitude),
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
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: [
                          Text("amount : ",
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp
                            ),
                          ),
                          Text(Data[index].amount.toString() ,
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Colors.black87
                                ),
                              ),
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
                          Text(Data[index].type ,
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
