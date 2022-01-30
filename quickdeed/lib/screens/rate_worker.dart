import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RateWorker extends StatefulWidget {
  const RateWorker({Key? key}) : super(key: key);

  @override
  _RateWorkerState createState() => _RateWorkerState();
}

class _RateWorkerState extends State<RateWorker> {

  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black87,
        title: Text("Rate the worker",
          style: GoogleFonts.pacifico(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(255 , 255 , 255 , 1)
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 60.r,
                ),
                SizedBox(height: 20.h,),
                SizedBox(
                  width: 200.w,
                  height: 50.h,
                  child: RatingBar.builder(
                    initialRating: 1,
                    unratedColor: Colors.white,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                SizedBox(
                  width: 320.w,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: reviewController,
                    maxLines: null,
                    onChanged: (review) {
                      print(review);
                    },
                    style:TextStyle(
                      fontSize: 16.sp,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                              style: BorderStyle.solid
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(
                              color: Colors.black87,
                              width: 2.0,
                              style: BorderStyle.solid
                          )
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "write your review ",
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                      hintStyle: GoogleFonts.rubik(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(0, 0, 0, 1)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: SizedBox(
                    width: 145.w,
                    height: 44.h,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(19, 18, 18, 1)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),

                        ),
                        onPressed: () {
                          // TODO: show a toast like feedback saved successfully
                          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                            content: Text("your review recorded successfully!"),
                          ));
                        },
                        child: Text("submit",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20.sp,
                          ),)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
