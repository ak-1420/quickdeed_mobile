import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../Models/users_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sticky_footer_scrollview/sticky_footer_scrollview.dart';
// import 'package:image_picker/image_picker.dart';
import '../Models/works_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  bool _isSearch = false, _isUsers = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool viewUsers = true;
    final List<Users> users = [
      Users(userId: "1", userName: "Hema", rating: 4.4, location: "4.4km away"),
      Users(userId: "1", userName: "Arun", rating: 4.4, location: "4.4km away"),
      Users(userId: "1", userName: "Rose", rating: 4.4, location: "4.4km away"),
      Users(
          userId: "1",
          userName: "Gayatri",
          rating: 4.4,
          location: "4.4km away"),
    ];
    final List<Works> works = [
      Works(
          workName: "Driving",
          userName: "Hema",
          estimatedTime: "7.3",
          amount: 1000,
          workType: "Delivery",
          createdTime: DateTime(1990, 9, 7, 17, 30),
          location: "1.5km away"),
      Works(
          workName: "Fan Repair",
          userName: "Arun",
          estimatedTime: "1",
          amount: 100,
          workType: "Repair",
          location: "1.5km away",
          createdTime: DateTime.now()),
      Works(
          workName: "Break Repair",
          userName: "Rose",
          estimatedTime: "7.3",
          workType: "Mechanic",
          amount: 1000,
          createdTime: DateTime.now(),
          location: "1.5km away"),
      Works(
          workName: "Song Writer",
          estimatedTime: "7.3",
          amount: 1000,
          createdTime: DateTime.now(),
          location: "1.5km away"),
      Works(
          userName: "Rose",
          workName: "Singer",
          estimatedTime: "7.3",
          amount: 1000,
          workType: "Entertainment",
          createdTime: DateTime.now(),
          location: "1.5km away"),
    ];

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
          Navigator.pushNamed(context, '/home');
          break;
        case 3:
          Navigator.pushNamed(context, '/connections');
          break;
        case 4:
          Navigator.pushNamed(context, '/home');
          break;
      }
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
      body: viewUsers
          ? Column(
              children: users.map((users) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/viewUser');
                  },
                  child: Card(
                    elevation: 10,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: CircleAvatar(
                            backgroundImage:
                                ExactAssetImage('images/user.jpeg', scale: 1.0),
                            // backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
                            radius: 29.r,
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(users.userName),
                                Text(users.location),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 200,
                                  height: 100,
                                  child: RatingBar.builder(
                                    initialRating: users.rating,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 2,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                                Card(child: Text("Skill 1")),
                                Card(
                                  child: Text("Skill 2"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          : Column(
              children: works.map((works) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/viewWork');
                  },
                  child: Card(
                      child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            ExactAssetImage('images/work.jpeg', scale: 1),
                        // backgroundColor: const Color.fromRGBO(229, 229, 229, 1),
                        radius: 29.r,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(works.workName),
                              Text(works.createdTime.toString())
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("posted by ${works.userName}"),
                              Text(works.location),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount ${works.amount}"),
                              Text(works.workType),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
                );
              }).toList(),
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
            icon: Icon(Icons.perm_device_information),
            label: 'About',
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
