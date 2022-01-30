import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickdeed/widgets/connected_users.dart';
import 'package:quickdeed/widgets/invited_users.dart';
import 'package:quickdeed/widgets/requested_users.dart';


class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this ,initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {

    final  width = MediaQuery.of(context).size.width;
    final  height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black87,
        title: Text("Connect",
          style: GoogleFonts.pacifico(
            fontSize: 28.sp,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(255 , 255 , 255 , 1)
          ),
        ),
        bottom: TabBar(
          tabs: const [
            Tab(text: "Connections",),
            Tab(text: "Invitations",),
            Tab(text: "Requests",),
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
          ConnectedUsers(),
          InvitedUsers(),
          RequestedUsers()
        ],
      ),
    );


  }


}
