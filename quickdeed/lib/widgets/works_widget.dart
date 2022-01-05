import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/works_model.dart';

class WorksList extends StatelessWidget {
  WorksList({Key? key}) : super(key: key);

  final List<Works> works = [
    Works(
        workName: "Driving",
        userName: "Hema",
        estimatedTime: "7.3",
        amount: 1000,
        workType: "Delivery",
        createdTime: "yesterday",
        location: "1.5km away"),
    Works(
        workName: "Fan Repair",
        userName: "Arun",
        estimatedTime: "1",
        amount: 100,
        workType: "Repair",
        location: "1.5km away",
        createdTime: "03-jan-2022"),
    Works(
        workName: "Break Repair",
        userName: "Rose",
        estimatedTime: "7.3",
        workType: "Mechanic",
        amount: 1000,
        createdTime: "31-dec-2021",
        location: "1.5km away"),
    Works(
        workName: "Song Writer",
        estimatedTime: "7.3",
        amount: 1000,
        workType: "Entertainment",
        createdTime: "just now",
        location: "1.5km away"),
    Works(
        userName: "Rose",
        workName: "Singer",
        estimatedTime: "7.3",
        amount: 1000,
        workType: "Entertainment",
        createdTime: "today 10:00 am",
        location: "1.5km away"),
    Works(
        workName: "Driving",
        userName: "Hema",
        estimatedTime: "7.3",
        amount: 1000,
        workType: "Delivery",
        createdTime: "yesterday",
        location: "1.5km away"),
    Works(
        workName: "Fan Repair",
        userName: "Arun",
        estimatedTime: "1",
        amount: 100,
        workType: "Repair",
        location: "1.5km away",
        createdTime: "03-jan-2022"),
    Works(
        workName: "Break Repair",
        userName: "Rose",
        estimatedTime: "7.3",
        workType: "Mechanic",
        amount: 1000,
        createdTime: "31-dec-2021",
        location: "1.5km away"),
    Works(
        workName: "Song Writer",
        estimatedTime: "7.3",
        amount: 1000,
        workType: "Entertainment",
        createdTime: "just now",
        location: "1.5km away"),
    Works(
        userName: "Rose",
        workName: "Singer",
        estimatedTime: "7.3",
        amount: 1000,
        workType: "Entertainment",
        createdTime: "today 10:00 am",
        location: "1.5km away"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: works.length,
      itemBuilder: (BuildContext context , int index){
        return Card(
          elevation: 10,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/viewWork');
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
                  Text(works[index].workName,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        fontSize: 16.sp
                    ),
                  ),
                  const Spacer(),
                  Text(works[index].createdTime,
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
                    Text(works[index].userName ,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black87
                      ),
                    ),
                    const Spacer(),
                    Text(works[index].location,
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
                          Text(works[index].amount.toString() ,
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
                          Text(works[index].workType ,
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
