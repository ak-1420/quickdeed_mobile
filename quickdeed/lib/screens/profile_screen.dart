import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({ Key? key }) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final String profilePicture = "https://instagram.fhyd11-2.fna.fbcdn.net/v/t51.2885-19/s320x320/124480382_821404835315782_2213267434541466715_n.jpg?_nc_ht=instagram.fhyd11-2.fna.fbcdn.net&_nc_cat=110&_nc_ohc=WxyqhagcuHoAX-NoC9i&edm=ABfd0MgBAAAA&ccb=7-4&oh=00_AT9Cz23x3C9IETgHwhoyS-LCZ9-guAL4upjTOoVUfoL2Mg&oe=61FB0289&_nc_sid=7bff83";
  final String coverPicture = "https://media-exp1.licdn.com/dms/image/C4E03AQHPVmJBFmJlRw/profile-displayphoto-shrink_400_400/0/1634745198438?e=1647475200&v=beta&t=w5f0Y7msi65EJFg2UDqKrRQj39WvUgeulBdR9UGEt-k";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(coverPicture),
                  fit: BoxFit.cover
                )
              ),
              child: Container(
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
            ),
            SizedBox(height: 80.h,),
            Text("Arun Kumar Kalakuntla",
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
              "Hyderabad, India"
              ,style: GoogleFonts.roboto(
                fontSize: 18.sp,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 200.w,
              height: 30.h,
              child: RatingBar.builder(
                initialRating: 4, // add it dynamically
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
                    child: Text("Skill Set",style: TextStyle(
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
                  children:[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("flutter",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("react js",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Node js",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("MERN stack",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Problem Solving",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Quick Learning",
                                style: GoogleFonts.roboto(),
                              )
                          ),
                        ),
                      ],
                    )
                  ]
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}