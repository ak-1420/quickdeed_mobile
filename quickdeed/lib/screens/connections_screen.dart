// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:quickdeed/Models/users_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({Key? key}) : super(key: key);

  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  final List<Users> users = [
    Users(userId: "1", userName: "Hema", rating: 4.4, location: "4.4km away"),
    Users(userId: "1", userName: "Arun", rating: 4.4, location: "7km away"),
    Users(userId: "1", userName: "Rose", rating: 4.4, location: "9.4km away"),
    Users(
        userId: "1", userName: "Gayatri", rating: 4.4, location: "4.4km away"),
  ];
  int tabNumber = 0;
  bool isVisible = false;

  void _setTabNumber(int index) {
    setState(() {
      tabNumber = index;
    });
    if (tabNumber == 2) isVisible = true;
  }

  Widget getTabBarView(
      {required List<Users> users,
      String buttonText = "Chat",
      int tabNumber = 0}) {
    return Container(
      width: double.infinity,
      child: Column(
        children: users.map((users) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/viewUser');
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.0),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: const CircleAvatar(
                          backgroundImage:
                              ExactAssetImage('images/user.jpeg', scale: 1.0),
                          radius: 29,
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 250,
                                height: 50,
                                child: RatingBar.builder(
                                  initialRating: users.rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  ignoreGestures: true,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  updateOnDrag: false,
                                  tapOnlyMode: true,
                                  // itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    // size: 0.2,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: RaisedButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  onPressed: () {
                                    //navigate to chat screen
                                  },
                                  color: Colors.purple,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.all(5.0),
                                  splashColor: Colors.grey,
                                ),
                              ),
                              RaisedButton(
                                child: Text(
                                  buttonText,
                                  style: TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context,'/chat');
                                },
                                color: Colors.purple,
                                textColor: Colors.white,
                                padding: EdgeInsets.all(5.0),
                                splashColor: Colors.grey,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            // to be handled for visiblity of second button on every card
            // onTap: () {_setTabNumber(1)},
            tabs: [
              Tab(
                  text: "Connections",
                  icon: Image.asset(
                    "images/connec.jpg",
                    height: 30.0,
                  )),
              Tab(text: "Invitations", icon: Icon(Icons.directions_transit)),
              Tab(text: "Requests", icon: Icon(Icons.directions_car)),
            ],
          ),
          title: Text(
            'Connect',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: TabBarView(
          children: [
            getTabBarView(users: users, buttonText: "Chat"),
            getTabBarView(users: users, buttonText: "Cancel"),
            getTabBarView(users: users, buttonText: "Accept"),
            // Icon(Icons.directions_transit, size: 350),
            // Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
