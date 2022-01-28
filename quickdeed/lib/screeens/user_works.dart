import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/widgets/posted_works.dart';
import 'package:quickdeed/widgets/serviced_works.dart';

class UserWorks extends StatefulWidget {
  const UserWorks({Key? key}) : super(key: key);

  @override
  _UserWorksState createState() => _UserWorksState();
}

class _UserWorksState extends State<UserWorks> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this , initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black87,
        title: Text("Your Works",
          style: GoogleFonts.pacifico(
              fontSize: 28.sp,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(255 , 255 , 255 , 1)
          ),
        ),
        bottom: TabBar(
          tabs: const [
            Tab(text: "Posted",),
            Tab(text: "Serviced",)
          ],
          labelStyle: GoogleFonts.pacifico(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp
          ),
          controller: _tabController,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
           PostedWorks(),
           ServicedWorks(),
        ],
      ),
    );
  }

}

