import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/Models/user_works_model.dart';

class PostedWorks extends StatelessWidget {
   PostedWorks({Key? key}) : super(key: key);

  final List<UserWorksModel> works = [
    UserWorksModel(
      userName: "Arun" , workName: "Coding" , amount: 100.0 ,
      workType: "Education" , isPosted: true , workStatus: "completed"
    ),
    UserWorksModel(
        userName: "Kranthi" , workName: "Maths Teaching" , amount: 500.0 ,
        workType: "Education" , isPosted: true , workStatus: "in progess"
    ),
    UserWorksModel(
        userName: "Hema" , workName: "Anchor" , amount: 1000.0 ,
        workType: "Entertainment" , isPosted: true , workStatus: "in progess"
    ),
    UserWorksModel(
        userName: "Gayathri" , workName: "Training" , amount: 1500.0 ,
        workType: "Sports" , isPosted: true , workStatus: "completed"
    ),
    UserWorksModel(
        userName: "Roseli" , workName: "mentoring" , amount: 2500.0 ,
        workType: "open source" , isPosted: true ,  workStatus: "in progess"
    ),
    UserWorksModel(
        userName: "Arun" , workName: "Coding" , amount: 100.0 ,
        workType: "Education" , isPosted: true , workStatus: "completed"
    ),
    UserWorksModel(
        userName: "Kranthi" , workName: "Maths Teaching" , amount: 500.0 ,
        workType: "Education" , isPosted: true , workStatus: "in progess"
    ),
    UserWorksModel(
        userName: "Hema" , workName: "Anchor" , amount: 1000.0 ,
        workType: "Entertainment" , isPosted: true , workStatus: "in progess"
    ),
    UserWorksModel(
        userName: "Gayathri" , workName: "Training" , amount: 1500.0 ,
        workType: "Sports" , isPosted: true , workStatus: "completed"
    ),
    UserWorksModel(
        userName: "Roseli" , workName: "mentoring" , amount: 2500.0 ,
        workType: "open source" , isPosted: true ,  workStatus: "in progess"
    ),
  ];
  @override
  Widget build(BuildContext context) {

    if(works.isEmpty) return Center(child:  Text("You haven't posted any works yet "));

    return ListView.builder(
        itemCount: works.length,
        itemBuilder: (BuildContext context , int index){
          return Card(
            elevation: 10,
            child:ListTile(
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
                    Text(works[index].workStatus,
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
                      Text((!works[index].isPosted) ? "posted by " : "assigned to ",
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
                      InkWell(
                        onTap: (){
                          if(works[index].workStatus == "completed")
                            {
                              //TODO: navigate user to rate now screen
                              Navigator.pushNamed(context, '/rateWorker');
                            }
                          else
                            {
                              //TODO: navigate uer to track screen
                              Navigator.pushNamed(context, '/track');
                            }
                        },
                        child: Text((works[index].workStatus == "completed") ? "Rate now" : "Track",
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp
                          ),
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
