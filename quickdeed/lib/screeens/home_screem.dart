import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  bool _isSearch = false, _isUsers = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget getTextFeild({required String hint, required int height_sp}) {
      return // name textbox
          SizedBox(
        width: 320.w,
        // height: height_sp.h,
        child: Container(
          // width: 320.w,
          // height: height.h,
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: nameController,
            onChanged: (name) {
              print(name);
            },
            style: TextStyle(
              fontSize: 24.sp,
              // height: height_sp.h,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(
                    color: Colors.black87,
                    width: 2.0,
                    style: BorderStyle.solid),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(
                      color: Colors.black87,
                      width: 2.0,
                      style: BorderStyle.solid)),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              hintStyle: GoogleFonts.rubik(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
        ),
      );
    }

    Widget getButton({required String buttonText}) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: SizedBox(
          width: 145.w,
          height: 44.h,
          child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromRGBO(19, 18, 18, 1)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                // TODO : Handle user signup
              },
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20.sp,
                ),
              )),
        ),
      );
    }

    Widget getList() {
      return ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: _isSearch
            ? TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Sreach Users",
                ),
              )
            : Text("QuickDeed"),
        backgroundColor: Color.fromRGBO(184, 183, 255, 1),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearch = true;
              });
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              //handle for filtering
            },
            icon: Icon(Icons.filter_alt),
          ),
        ],
      ),
      body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
         child: Container(
           width:350.h,
           height: 32.h,
           child:  TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 1.0,
                          style: BorderStyle.solid),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                          color: Colors.black87,
                          width: 2.0,
                          style: BorderStyle.solid),
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(167, 176, 207, 0.4),
                    hintText: _isUsers
                        ? "you are currently viewing users"
                        : "you are currently viewing works",
                    hintStyle: GoogleFonts.rubik(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isUsers = ! _isUsers;
                          });

                          //to be handled to switching to works
                        },
                        icon: Icon(Icons.toggle_on_rounded))),
              ),
              // SizedBox(height:10.h),
         ),
       
        

        ),
        
        
      );
      
   
  }
}

