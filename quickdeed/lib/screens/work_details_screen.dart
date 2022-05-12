import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickdeed/arguments/view_work_screen_arguments.dart';
import 'package:quickdeed/api/user_services.dart';


class WorkDetailsScreen extends StatefulWidget {
  WorkDetailsScreen({Key? key}) : super(key: key);

  @override
  _WorkDetailsScreen createState() => _WorkDetailsScreen();
}

class _WorkDetailsScreen extends State<WorkDetailsScreen> {


  void sendRequest(String? userId , String? workId , context){
    if(userId != null && workId != null) {
      inviteUser(userId , workId).then((val) => {
        if(val['status'] == true){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('invitation sent'))
          ),
        }
      }).catchError((err) => {
        print('error while sending user invitations $err')
      });
    }
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
                  child: Text(
                    title,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp,
                        color: Colors.grey),
                  ),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    value,
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Colors.black),
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

    final args = ModalRoute.of(context)!.settings.arguments as ViewWorkArguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Text(
                  "Work Details",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.w400,
                      fontSize: 30.sp,
                      color: const Color.fromRGBO(249, 250, 253, 1)),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Column(
                    children: [
                      getCard(
                          title: "Work Name :",
                          value: args.work?.name ?? "Loading",
                          imgPath: 'images/work.jpeg'),
                      Divider(
                        color: Colors.black,
                        indent: 75.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                      ),
                      getCard(
                          title: "Posted By:",
                          value: args.work?.userName ?? "Loading",
                          imgPath: 'images/user.jpeg'),
                      Divider(
                        color: Colors.black,
                        indent: 75.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                      ),
                      getCard(
                          title: "Estimated Time:",
                          value: args.work?.duration.toString() ?? "Loading",
                          imgPath: 'images/time.jpeg'),
                      Divider(
                        color: Colors.black,
                        indent: 75.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                      ),
                      getCard(
                          title: "Amount:",
                          value: args.work?.amount.toString() ?? "Loading",
                          imgPath: 'images/salary.jpg'),
                      Divider(
                        color: Colors.black,
                        indent: 75.0,
                        endIndent: 55.0,
                        thickness: 2.0,
                      ),
                      getCard(
                          title: "Description:",
                          value:
                              args.work?.description ?? "description",
                          imgPath: 'images/description.jpeg'),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                                  sendRequest(args.user?.userId , args.work?.workId , context);
                                },

                                child: Text(
                                  "Send Request",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20.sp,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } // end of build method

}
