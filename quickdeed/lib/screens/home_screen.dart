import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickdeed/widgets/users_widget.dart';
import 'package:quickdeed/widgets/works_widget.dart';

enum WorkFilter {distance , amount}
enum UserFilter {distance , rating}


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  int _selectedIndex = 0;

  WorkFilter? sortWork = WorkFilter.distance;

  ValueNotifier<UserFilter?> selectedUserSort = ValueNotifier<UserFilter?>(null);
  ValueNotifier<WorkFilter?> selectedWorkSort = ValueNotifier<WorkFilter?>(null);

  UserFilter? sortUser = UserFilter.distance;
  
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final searchController = TextEditingController();

  bool _isSearch = false ;

  bool viewUsers =  false;

  String searchWord = "";

  List<Widget> workFilter(){
    return [
      SizedBox(
        height: 10.h,
      ),
      const Text("Sort by",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),),
      const Divider(thickness: 2.0,),
      SizedBox(
        height: 10.h,
      ),
      AnimatedBuilder(
        child: Text(WorkFilter.distance.name),
        animation: selectedWorkSort,
        builder: (BuildContext context, Widget? child) {
          return RadioListTile(
              value: WorkFilter.distance,
              groupValue: selectedWorkSort.value,
              title: child,
              onChanged: (WorkFilter? value) {
                selectedWorkSort.value = value;
                setState(() {
                  sortWork = value;
                });
              });
        },
      ),
      AnimatedBuilder(
        child: Text(WorkFilter.amount.name),
        animation: selectedWorkSort,
        builder: (BuildContext context, Widget? child) {
          return RadioListTile(
              value: WorkFilter.amount,
              groupValue: selectedWorkSort.value,
              title: child,
              onChanged: (WorkFilter? value) {
                selectedWorkSort.value = value;
                setState(() {
                  sortWork = value;
                });
              });
        },
      ),
    ];
  }

  List<Widget> userFilter(){
    return [
      SizedBox(
        height: 10.h,
      ),
      const Text("Sort by",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),),
      const Divider(thickness: 2.0,),
      SizedBox(
        height: 10.h,
      ),
      AnimatedBuilder(
        child: Text(UserFilter.distance.name),
        animation: selectedUserSort,
        builder: (BuildContext context, Widget? child) {
          return RadioListTile(
              value: UserFilter.distance,
              groupValue: selectedUserSort.value,
              title: child,
              onChanged: (UserFilter? value) {
                selectedUserSort.value = value;
                setState(() {
                  sortUser = value;
                });
              });
        },
      ),
      AnimatedBuilder(
        child: Text(UserFilter.rating.name),
        animation: selectedUserSort,
        builder: (BuildContext context, Widget? child) {
          return RadioListTile(
              value: UserFilter.rating,
              groupValue: selectedUserSort.value,
              title: child,
              onChanged: (UserFilter? value) {
                selectedUserSort.value = value;
                setState(() {
                  sortUser = value;
                });
              });
        },
      ),
    ];
  }

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
                    keyboardType: TextInputType.name,
                    controller: searchController,
                    onChanged: (val) {
                      //TODO: filter works/users by search word
                      setState(() {
                        searchWord = val;
                      });
                    },
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
              icon: const Icon(Icons.search),
            ),
            PopupMenuButton(
                offset: const Offset(0, 60),
                icon: const Icon(Icons.filter_alt),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      enabled: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:(viewUsers) ? userFilter() : workFilter(),
                      )
                  )
                ]
            )
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
                            searchWord = "";
                            searchController.clear();
                         });
                       }
                   )
                 ],
               ),
              ),
              viewUsers ?  UsersList(searchWord: searchWord , sortBy: sortUser,) : WorksList(searchWord: searchWord, sortBy : sortWork)
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








