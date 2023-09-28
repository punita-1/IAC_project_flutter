import 'package:flutter/material.dart';
import 'package:flutter_app/screen/pages/home_page/home_page.dart';
//mport 'package:flutter_app/screen/pages/home_page/Upload_image.dart';
//import 'package:flutter_app/screen/pages/home_page/Firestore/firestore_listscreen.dart';
//import 'package:flutter_app/screen/pages/home_page/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),

    // UploadImageScreen()
    //FireStoreScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    // NetworkScreen(),
    // PostScreen(),
    // NotificationsScreen(),
    // JobScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return SafeArea(
            child: Scaffold(
          // appBar: AppBar(
          //   actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
          // ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userFriends),
                label: 'My Network',
              ),
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.plusCircle),
                label: 'Post',
              ),
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidBell),
                label: 'Notifications',
              ),
              const BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.briefcase),
                label: 'Job',
              ),
            ],
          ),
          body: _children[_currentIndex],
        ));
      },
    );
  }
}
