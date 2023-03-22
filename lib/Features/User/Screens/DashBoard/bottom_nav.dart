import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:public_emergency_app/Features/User/Screens/DashBoard/dash_board.dart';

import '../Profile/user_profile.dart';


class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentindex = 1;
  final screens = [
    UserProfile(),
    DashBoard(),
    DashBoard(),
    // ProfileScreen(),
    // CategoriesScreen(),
    // ContactForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.blueGrey,
          color: Colors.lightBlueAccent,
          animationDuration: Duration(milliseconds: 300),
          height: 55,
          onTap: (index) => setState(() => currentindex = index),

          items: [
            Icon(
              Icons.person,
              size: 24,
              color: Colors.white,
            ),
            Icon(
              Icons.app_registration_rounded,
              size: 24,
              color: Colors.white,
            ),

            Icon(
              Icons.message,
              size: 24,
              color: Colors.white,
            )
          ]),
      body: screens[currentindex],
    );
  }
}
