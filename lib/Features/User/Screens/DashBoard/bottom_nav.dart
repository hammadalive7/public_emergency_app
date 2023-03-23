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
  int currentIndex = 1;
  final screens = const [
    UserProfile(),
    DashBoard(),
    DashBoard(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.white,
          color: Colors.lightBlueAccent,
          animationDuration: const Duration(milliseconds: 300),
          height: 55,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            Icon(
              Icons.person,
              size: 24,
              color: Colors.white,
            ),
            Icon(
              Icons.emergency,
              size: 24,
              color: Colors.white,
            ),
            Icon(
              Icons.message,
              size: 24,
              color: Colors.white,
            )
          ]),
      body: screens[currentIndex],
    );
  }
}
