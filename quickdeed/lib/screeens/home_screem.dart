import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickdeed/widgets/users_widget.dart';
import 'package:quickdeed/widgets/works_widget.dart';
import '../Models/users_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _selectedIndex = 0;
  
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  bool _isSearch = false ;

  bool viewUsers =  false;
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (_selectedIndex) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          Navigator.pushNamed(context, '/myProfile');
          break;
        case 2:
          Navigator.pushNamed(context, '/postWork');
          break;
        case 3:
          Navigator.pushNamed(context, '/connect');
          break;
        case 4:
          Navigator.pushNamed(context, '/userWorks');
          break;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: _isSearch
              ? TextField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: (viewUsers) ? "Search Users" : "Search Works",
                  ),
                )
              : const Text("QuickDeed"),
          backgroundColor: const Color.fromRGBO(184, 183, 255, 1),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              //show toggle bar for selecting works/users
              Container(
               margin: const EdgeInsets.all(10.0),
               height: 35.h,
               width: width,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10.0),
                 color: Colors.indigo[200]
               ),
               child: Row(
                 children: [
                   SizedBox(width: 10.w,),
                   Text("you are currently viewing ${(viewUsers) ? 'users' : 'works'}",
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp
                    ),
                   ),
                   const Spacer(),
                   Switch(
                       inactiveThumbColor: Colors.white,
                       inactiveTrackColor: Colors.black,
                       activeTrackColor: Colors.indigo,
                       activeColor: Colors.white,
                       value: viewUsers,
                       onChanged: (onChanged){
                         setState(() {
                            viewUsers = !viewUsers;
                         });
                       }
                   )
                 ],
               ),
              ),
              viewUsers ? UsersList() : WorksList()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color.fromRGBO(184, 183, 255, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_add_outlined),
              label: 'Connections',
              backgroundColor: Color.fromRGBO(184, 183, 255, 1),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              label: 'Your Works',
              backgroundColor: Color.fromRGBO(184, 183, 255, 1),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      );

  }
}




